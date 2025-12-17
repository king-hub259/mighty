<?php

namespace App\Traits;

use App\Enums\UserLogAction;
use App\Enums\VoucherType;
use App\Exceptions\StudentCollectionException;
use Carbon\Carbon;
use Illuminate\Support\Facades\DB;
use Modules\Academic\Models\Student;
use Modules\Academic\Models\StudentSession;
use Modules\Accounting\Models\AccountingFund;
use Modules\Accounting\Models\AccountingLedger;
use Modules\Finance\Models\AttendanceFine;
use Modules\Finance\Models\Fee;
use Modules\Finance\Models\FeeDateConfig;
use Modules\Finance\Models\FeeMap;
use Modules\Finance\Models\FeeMapFund;
use Modules\Finance\Models\FeeSubHead;
use Modules\Finance\Models\StudentCollection;
use Modules\Finance\Models\StudentCollectionDetails;
use Modules\Finance\Models\StudentCollectionDetailsSubHead;
use Modules\Finance\Models\StudentWaiverConfig;

trait StudentCollectionTrait
{
    use AccountingCalculationTrait, Trackable;

    public function generateCollectionInvoiceNo(): string
    {
        // Create an invoice number based on the current year and month.
        $invoiceNumber = date('Y').date('m');

        // Get the last invoice number that matches the current year and month.
        $lastInvoice = StudentCollection::where('invoice_id', 'like', '%'.$invoiceNumber.'%')
            ->orderBy('id', 'DESC')
            ->first();

        if ($lastInvoice) {
            $existingInvoiceId = $lastInvoice->invoice_id;

            // Extract the numeric part of the invoice ID and convert it to an integer.
            $lastInvoiceNumber = (int) substr($existingInvoiceId, 6);

            // Increment the last invoice number.
            return $invoiceNumber.str_pad((string) ($lastInvoiceNumber + 1), 4, '0', STR_PAD_LEFT);
        } else {
            // No existing invoice found; start with 1.
            return $invoiceNumber.str_pad('1', 4, '0', STR_PAD_LEFT);
        }
    }

    public function getCollectionAmountsByFeeHeadAndSubHeads(
        int $studentId,
        int $feeHeadId,
        array $feeSubHeadIds
    ): array {
        $collectionData = [
            'student_id' => $studentId,
            'total_due' => 0,
            'total_paid' => 0,
            'waiver' => 0,
            'fine_payable' => 0,
            'fee_payable' => 0,
            'fee_and_fine_payable' => 0,
            'fee_and_fine_paid' => 0,
            'previous_due_payable' => 0,
            'previous_due_paid' => 0,
            'fee_head_id' => 0,
            'total_payable' => 0,
            'found_student' => false,
            'found_fee_amount' => false,
        ];
        // Get student info from student_sessions table
        $studentSession = StudentSession::where('student_id', $studentId)
            ->with('student')
            ->first();

        if (! $studentSession || empty($studentSession->student)) {
            return $collectionData;
        }

        // Make response that student is found.
        $collectionData['found_student'] = true;

        // Map the $feeSubHeadIds and convert them to integer
        $feeSubHeadIds = array_map(function ($feeSubHeadId) {
            return (int) $feeSubHeadId;
        }, $feeSubHeadIds);

        $feeMapFeeSubHeads = DB::table('fee_map_fee_sub_head')->where('fee_head_id', $feeHeadId)->pluck('fee_sub_head_id')->toArray();
        $commonValues = array_intersect($feeMapFeeSubHeads, $feeSubHeadIds);
        $feeSubHeads = FeeSubHead::whereIn('id', $commonValues)->get();

        if (! $feeSubHeads) {
            return $collectionData;
        }

        // Check in Fee, if there is any configuration for this class, section, session_id.
        $fee = Fee::where('class_id', $studentSession->class_id)
            ->where('section_id', $studentSession->section_id)
            ->where('session_id', $studentSession->session_id)
            ->where('student_category_id', $studentSession->student->student_category_id)
            ->where('fee_head_id', $feeHeadId)
            ->first();

        if (! $fee) {
            return $collectionData;
        }

        $waiver = StudentWaiverConfig::where('student_id', $studentId)->where('fee_head_id', $feeHeadId)->first();
        if ($waiver) {
            $collectionData['waiver'] = $waiver->amount * count($feeSubHeads);
        }

        // Make response that fee is found.
        $collectionData['found_fee_amount'] = true;
        $collectionData['fee_head_id'] = $feeHeadId;

        // Get total amount by number of subheads.
        $collectionData['total_payable'] = $fee->fee_amount * count($feeSubHeads);

        $currentDate = now(); // Assuming you want the current date
        $totalFinePayable = 0;

        foreach ($feeSubHeads as $feeSubHead) {
            $dateConfig = FeeDateConfig::where(
                'fee_sub_head_id',
                $feeSubHead->id
            )->first();

            if ($dateConfig && $currentDate > $dateConfig->payable_date_end) {
                $totalFinePayable += $fee->fine_amount;
            }
        }

        $collectionData['fine_payable'] = $totalFinePayable;
        // Total fine and fee payable.
        $collectionData['fee_and_fine_payable'] = $collectionData['total_payable'] + $collectionData['fine_payable'];
        // Update total payable amount.
        $collectionData['fee_payable'] = $fee->fee_amount * count($feeSubHeads);

        // Update total_paid amount.
        // This is for initial time, so that user can identify
        // how much needs to be paid in the form.
        $collectionData['total_paid'] = $collectionData['fee_and_fine_payable'] - $collectionData['waiver'];
        $collectionData['fee_and_fine_paid'] = $collectionData['fee_and_fine_payable'];
        $collectionData['total_payable'] = $collectionData['fee_and_fine_payable'];

        return $collectionData;
    }

    public function getLedgerIdFromFeeHead(int $feeHeadId): int
    {
        return FeeMap::where('fee_head_id', $feeHeadId)->value('ledger_id');
    }

    public function getFundIdFromFeeMap(int $ledgerId): int
    {
        $fundId = 0;

        $feeMap = FeeMap::where('ledger_id', $ledgerId)->first();

        if ($feeMap) {
            $fundId = FeeMapFund::where('fee_map_id', $feeMap->id)->value('fund_id');
        }

        return $fundId;
    }

    public function getTotalPreviousDueForStudentInFeeHead(
        int $studentId,
        int $feeHeadId,
        ?int $sessionId = null
    ) {
        if (! $sessionId) {
            $sessionId = get_option('academic_year');
        }

        return StudentCollectionDetails::where('student_id', $studentId)
            ->where('fee_head_id', $feeHeadId)
            ->where('session_id', $sessionId)
            ->orderBy('id', 'DESC')
            ->value('total_due');
    }

    public function generateCollectionDataFromPayslip(
        array $studentIds,
        array $payslipData
    ): array {
        $collections = [];

        // Check if previous due or attendance fine is enabled.
        $needsCheckPreviousDue = $payslipData['previous_due'] ?? false;
        $needsCheckAttendanceFine = $payslipData['attendance_fine'] ?? false;

        foreach ($studentIds as $studentId) {
            $collectionData = [];

            $feeHeadId = $payslipData['fee_head_id'];
            $collectionData['student_id'] = $studentId;
            $collectionData['session_id'] = $payslipData['session_id'];
            $collectionData['date'] = null;
            $collectionData['ledger_id'] = null;
            $collectionData['fund_id'] = null;
            $collectionAmounts = $this->getCollectionAmountsByFeeHeadAndSubHeads(
                $studentId,
                $feeHeadId,
                $payslipData['fee_sub_head_ids']
            );

            // Check if previous due is enabled.
            $previousDueAmount = 0;
            if ($needsCheckPreviousDue) {
                // Get total previous dues for this student of this fee head and session.
                $previousDueAmount = $this->getTotalPreviousDueForStudentInFeeHead(
                    $studentId,
                    $feeHeadId,
                    $payslipData['session_id']
                );
            }

            $totalPayable = $collectionAmounts['total_payable'] + $previousDueAmount;
            $collectionData['fee_heads'][$feeHeadId] = [
                'fee_head_id' => $feeHeadId,
                'sub_head_ids' => $payslipData['fee_sub_head_ids'],
                'total_paid' => 0, // As for payslip, we've handle it with total_paid = 0;
                'waiver' => $collectionAmounts['waiver'],
                'fine_payable' => $collectionAmounts['fine_payable'],
                'fee_payable' => $collectionAmounts['fee_payable'],
                'fee_and_fine_payable' => $collectionAmounts['fee_and_fine_payable'],
                'fee_and_fine_paid' => 0, // As for payslip, we've handle it with fee_and_fine_paid = 0;
                'previous_due_payable' => 0,
                'previous_due_paid' => 0,
                'total_payable' => $totalPayable,
            ];

            $collectionData['total_due'] = 0;
            $collectionData['total_paid'] = 0;
            $collectionData['total_payable'] = $collectionData['fee_heads'][$feeHeadId]['total_payable'];
            $collectionData['note'] = null;

            $collections[] = $collectionData;
        }

        return $collections;
    }

    public function generateCollectionDataFormat(
        array $payslipData
    ): array {
        $collectionData = [];

        $collectionData['session_id'] = intval($payslipData['session_id']);
        $collectionData['id'] = intval($payslipData['collection_id']);
        $collectionData['invoice_date'] = $payslipData['date'] ?? Carbon::now();
        $collectionData['ledger_id'] = intval($payslipData['ledger_id']);
        $collectionData['details'] = [
            'total_paid' => floatval($payslipData['total_paid']),
            'waiver' => floatval($payslipData['waiver']),
            'fee_and_fine_payable' => floatval($payslipData['total_payable']) + floatval($payslipData['attendance_fine']),
            'fee_and_fine_paid' => floatval($payslipData['total_paid']) - floatval($payslipData['waiver']),
            'total_payable' => floatval($payslipData['total_payable']),
        ];

        $collectionData['total_due'] = 0;
        $collectionData['total_paid'] = floatval($payslipData['total_paid']);
        $collectionData['total_payable'] = floatval($payslipData['total_payable']);
        $collectionData['note'] = $payslipData['note'];

        return $collectionData;
    }

    public function createCollection(array $data): ?StudentCollection
    {
        $model_id = auth()->user()->id;

        try {
            DB::beginTransaction();
            $studentId = $data['student_id'];

            $student = Student::find($studentId);

            if (! $student || empty($student->studentSession)) {
                throw new StudentCollectionException(_lang('Student not found.'));
            }

            $feeHeads = $data['fee_heads'];
            // filter out which feeHeads has fee_head_id
            // In quick collection, we've a checkbox to handle this.
            $feeHeads = array_filter($feeHeads, function ($feeHead) {
                return ! empty($feeHead['fee_head_id']);
            });

            if (! count($feeHeads)) {
                throw new StudentCollectionException(_lang('No fee heads found.'));
            }

            // First ledger_id based on fee_heads.
            $ledgerId = $this->getLedgerIdFromFeeHead(array_key_first($feeHeads));

            // Get fund id from first ledger from fee_maps and fee_map_fund.
            $fundId = null;
            if (! empty($data['ledger_id'])) {
                $fundId = $this->getFundIdFromFeeMap($ledgerId);
            }

            // Create a new student collection data.
            $studentCollection = [
                'institute_id' => get_institute_id(),
                'branch_id' => get_branch_id(),
                'student_id' => $studentId,
                'class_id' => $student->studentSession->class_id,
                'invoice_id' => $this->generateCollectionInvoiceNo(),
                'invoice_date' => $data['date'],
                'session_id' => $data['session_id'] ?? get_option('academic_year'),
                'attendance_fine' => floatval($data['attendance_fine']),
                'quiz_fine' => floatval($data['quiz_fine']),
                'lab_fine' => floatval($data['lab_fine']),
                'tc_amount' => floatval($data['tc_amount']),
                'total_payable' => floatval($data['total_payable']),
                'total_paid' => floatval($data['total_paid']),
                'total_due' => 0,
                'note' => $data['note'],
                'ledger_id' => $ledgerId, // This ledger should be from config.
                'receive_ledger_id' => intval($data['ledger_id']), // This ledger should come from frontend.
                'fund_id' => $fundId,
                'created_by' => auth()->user()->id,
            ];
            $studentCollection = StudentCollection::create($studentCollection);

            if (! $studentCollection) {
                throw new StudentCollectionException(_lang('Student collection could not be created.'));
            }

            // Create student collection details - fee heads.
            $studentCollectionDetails = [];
            $studentCollectionDetailsSubHeadIds = [];

            foreach ($feeHeads as $feeHeadId => $feeHeadData) {
                $studentCollectionDetailsData = [
                    'institute_id' => get_institute_id(),
                    'branch_id' => get_branch_id(),
                    'student_collection_id' => $studentCollection->id,
                    'ledger_id' => $this->getLedgerIdFromFeeHead($feeHeadId),
                    'student_id' => $studentId,
                    'session_id' => get_option('academic_year'),
                    'fee_head_id' => $feeHeadId,
                    'total_paid' => floatval($feeHeadData['total_paid']),
                    'waiver' => floatval($feeHeadData['waiver']),
                    'fine_payable' => floatval($feeHeadData['fine_payable']),
                    'fee_payable' => floatval($feeHeadData['fee_payable']),
                    'fee_and_fine_payable' => floatval($feeHeadData['fee_and_fine_payable']),
                    'fee_and_fine_paid' => floatval($feeHeadData['total_paid']) - floatval($feeHeadData['waiver']),
                    'previous_due_payable' => 0,
                    'previous_due_paid' => 0,
                    'total_payable' => floatval($feeHeadData['total_payable']),
                ];

                $studentCollectionDetails = StudentCollectionDetails::create(
                    $studentCollectionDetailsData
                );

                if (! $studentCollectionDetails) {
                    throw new StudentCollectionException(_lang('Student collection details could not be created.'));
                }

                if (isset($feeHeadData['sub_head_ids'])) {
                    $subHeadIds = $feeHeadData['sub_head_ids'] ?? [];
                    foreach ($subHeadIds as $feeSubHeadId) {
                        $studentCollectionDetailsSubHeadIds[] = [
                            'institute_id' => get_institute_id(),
                            'branch_id' => get_branch_id(),
                            'student_id' => $studentId,
                            'session_id' => $data['session_id'] ?? get_option('academic_year'),
                            'student_collection_id' => $studentCollection->id,
                            'student_collection_details_id' => $studentCollectionDetails->id,
                            'fee_head_id' => $feeHeadId,
                            'sub_head_id' => $feeSubHeadId,
                            'created_at' => now(),
                            'updated_at' => now(),
                        ];
                    }
                }
            }

            if (empty($studentCollectionDetailsSubHeadIds)) {
                throw new StudentCollectionException(
                    _lang('Student collection details sub heads could not be created.')
                );
            }

            $studentCollectionDetailsSubHeadIdsCreated = StudentCollectionDetailsSubHead::insert(
                $studentCollectionDetailsSubHeadIds
            );

            if (! $studentCollectionDetailsSubHeadIdsCreated) {
                throw new StudentCollectionException(
                    _lang('Student collection details sub heads could not be created.')
                );
            }

            // Attendance Data store.
            if (isset($data['selected_month']) && $data['selected_month'] && $studentId) {
                AttendanceFine::create([
                    'student_id' => $studentId,
                    'fine_amount' => $data['selected_month'],
                    'type' => 'attendance_absent_fine',
                ]);
            }

            if (isset($data['selected_month_quiz']) && $data['selected_month_quiz'] && $studentId) {
                AttendanceFine::create([
                    'student_id' => $studentId,
                    'fine_amount' => $data['selected_month_quiz'],
                    'type' => 'attendance_quiz_fine',
                ]);
            }

            if (isset($data['selected_month_lab']) && $data['selected_month_lab'] && $studentId) {
                AttendanceFine::create([
                    'student_id' => $studentId,
                    'fine_amount' => $data['selected_month_lab'],
                    'type' => 'attendance_lab_fine',
                ]);
            }

            // Sync with accounting.
            if ($data['total_paid'] > 0) {
                $data = $this->syncAccountingTransaction($studentCollection->id);
            }

            if (isset($studentCollection->tc_amount) && $studentCollection->tc_amount && $studentCollection->tc_amount == get_option('tc_amount')) {
                $student = Student::where('id', $studentId)->first();
                if (! $student) {
                    throw new StudentCollectionException(_lang('Student could not found.'));
                }

                $student->update([
                    'status' => '0',
                ]);

                $tcAmount = $studentCollection->tc_amount;

                $this->trackAction(
                    UserLogAction::DELETE,
                    Student::class,
                    $model_id,
                    "After collecting TC amount of $tcAmount from quick collection, the student was disabled by user $model_id."
                );
            }

            DB::commit();

            return $studentCollection;
        } catch (\Throwable $th) {
            DB::rollBack();
            throw new StudentCollectionException($th->getMessage());
        }
    }

    // API
    public function createCollectionApi(array $data): ?StudentCollection
    {
        $model_id = auth()->user()->id;

        // try {
        //     DB::beginTransaction();
        $studentId = $data['student_id'];

        $student = Student::find($studentId);

        if (! $student || empty($student->studentSession)) {
            throw new StudentCollectionException(_lang('Student not found.'));
        }

        $feeHeads = $data['fee_heads'];

        // filter out which feeHeads has fee_head_id
        // In quick collection, we've a checkbox to handle this.
        $feeHeads = array_filter($feeHeads, function ($feeHead) {
            return ! empty($feeHead['fee_head_id']);
        });

        if (! count($feeHeads)) {
            throw new StudentCollectionException(_lang('No fee heads found.'));
        }

        // First ledger_id based on fee_heads.
        $ledgerId = 8;

        // Get fund id from first ledger from fee_maps and fee_map_fund.
        $fundId = null;
        if (! empty($data['ledger_id'])) {
            $fundId = $this->getFundIdFromFeeMap($ledgerId);
        }

        // Create a new student collection data.
        $studentCollection = [
            'institute_id' => get_institute_id(),
            'branch_id' => get_branch_id(),
            'student_id' => $studentId,
            'class_id' => $student->studentSession->class_id,
            'invoice_id' => $this->generateCollectionInvoiceNo(),
            'invoice_date' => $data['date'],
            'session_id' => $data['session_id'] ?? get_option('academic_year'),
            'attendance_fine' => floatval($data['attendance_fine']),
            'quiz_fine' => floatval($data['quiz_fine']),
            'lab_fine' => floatval($data['lab_fine']),
            'tc_amount' => floatval($data['tc_amount']),
            'total_payable' => floatval($data['total_payable']),
            'total_paid' => floatval($data['total_paid']),
            'total_due' => 0,
            'note' => $data['note'],
            'ledger_id' => $ledgerId, // This ledger should be from config.
            'receive_ledger_id' => intval($data['ledger_id']), // This ledger should come from frontend.
            'fund_id' => $fundId,
            'created_by' => auth()->user()->id,
        ];
        $studentCollection = StudentCollection::create($studentCollection);

        if (! $studentCollection) {
            throw new StudentCollectionException(_lang('Student collection could not be created.'));
        }

        // Create student collection details - fee heads.
        $studentCollectionDetails = [];
        $studentCollectionDetailsSubHeadIds = [];

        foreach ($feeHeads as $feeHeadData) {
            $studentCollectionDetailsData = [
                'institute_id' => get_institute_id(),
                'branch_id' => get_branch_id(),
                'student_collection_id' => $studentCollection->id,
                'ledger_id' => $this->getLedgerIdFromFeeHead($feeHeadData['fee_head_id']),
                'student_id' => $studentId,
                'session_id' => get_option('academic_year'),
                'fee_head_id' => $feeHeadData['fee_head_id'],
                'total_paid' => floatval($feeHeadData['total_paid']),
                'waiver' => floatval($feeHeadData['waiver']),
                'fine_payable' => floatval($feeHeadData['fine_payable']),
                'fee_payable' => floatval($feeHeadData['fee_payable']),
                'fee_and_fine_payable' => floatval($feeHeadData['fee_and_fine_payable']),
                'fee_and_fine_paid' => floatval($feeHeadData['total_paid']) - floatval($feeHeadData['waiver']),
                'previous_due_payable' => 0,
                'previous_due_paid' => 0,
                'total_payable' => floatval($feeHeadData['total_payable']),
            ];

            $studentCollectionDetails = StudentCollectionDetails::create(
                $studentCollectionDetailsData
            );

            if (! $studentCollectionDetails) {
                throw new StudentCollectionException(_lang('Student collection details could not be created.'));
            }

            if (isset($feeHeadData['sub_head_ids'])) {
                $subHeadIds = $feeHeadData['sub_head_ids'] ?? [];
                foreach ($subHeadIds as $feeSubHeadId) {
                    $studentCollectionDetailsSubHeadIds[] = [
                        'institute_id' => get_institute_id(),
                        'branch_id' => get_branch_id(),
                        'student_id' => $studentId,
                        'session_id' => $data['session_id'] ?? get_option('academic_year'),
                        'student_collection_id' => $studentCollection->id,
                        'student_collection_details_id' => $studentCollectionDetails->id,
                        'fee_head_id' => $feeHeadData['fee_head_id'],
                        'sub_head_id' => $feeSubHeadId,
                        'created_at' => now(),
                        'updated_at' => now(),
                    ];
                }
            }
        }

        if (empty($studentCollectionDetailsSubHeadIds)) {
            throw new StudentCollectionException(
                _lang('Student collection details sub heads could not be created.')
            );
        }

        $studentCollectionDetailsSubHeadIdsCreated = StudentCollectionDetailsSubHead::insert(
            $studentCollectionDetailsSubHeadIds
        );

        if (! $studentCollectionDetailsSubHeadIdsCreated) {
            throw new StudentCollectionException(
                _lang('Student collection details sub heads could not be created.')
            );
        }

        // Attendance Data store.
        if (isset($data['selected_month']) && $data['selected_month'] && $studentId) {
            AttendanceFine::create([
                'institute_id' => get_institute_id(),
                'branch_id' => get_branch_id(),
                'student_id' => $studentId,
                'fine_amount' => $data['selected_month'],
                'type' => 'attendance_absent_fine',
            ]);
        }

        if (isset($data['selected_month_quiz']) && $data['selected_month_quiz'] && $studentId) {
            AttendanceFine::create([
                'institute_id' => get_institute_id(),
                'branch_id' => get_branch_id(),
                'student_id' => $studentId,
                'fine_amount' => $data['selected_month_quiz'],
                'type' => 'attendance_quiz_fine',
            ]);
        }

        if (isset($data['selected_month_lab']) && $data['selected_month_lab'] && $studentId) {
            AttendanceFine::create([
                'institute_id' => get_institute_id(),
                'branch_id' => get_branch_id(),
                'student_id' => $studentId,
                'fine_amount' => $data['selected_month_lab'],
                'type' => 'attendance_lab_fine',
            ]);
        }

        // Sync with accounting.
        if ($data['total_paid'] > 0) {
            $data = $this->syncAccountingTransaction($studentCollection->id);
        }

        if (isset($studentCollection->tc_amount) && $studentCollection->tc_amount && $studentCollection->tc_amount == get_option('tc_amount')) {
            $student = Student::where('id', $studentId)->first();
            if (! $student) {
                throw new StudentCollectionException(_lang('Student could not found.'));
            }

            $student->update([
                'status' => '0',
            ]);

            $tcAmount = $studentCollection->tc_amount;
            $this->trackAction(
                UserLogAction::DELETE,
                Student::class,
                $model_id,
                "After collecting TC amount of $tcAmount from quick collection, the student was disabled by user $model_id."
            );
        }

        // DB::commit();

        return $studentCollection;
        // } catch (\Throwable $th) {
        //     DB::rollBack();
        //     throw new StudentCollectionException($th->getMessage());
        // }
    }

    /**
     * Update Single collection.
     *
     * @return int
     */
    public function updateCollection(array $data)
    {
        try {
            DB::beginTransaction();
            // Update student collection data.
            $studentCollection = [
                'invoice_date' => $data['invoice_date'],
                'attendance_fine' => floatval($data['attendance_fine']),
                'total_payable' => floatval($data['total_payable']),
                'total_paid' => floatval($data['total_paid']),
                'total_due' => 0,
                'note' => $data['note'] ?? null,
                'receive_ledger_id' => $data['ledger_id'],
                'updated_by' => auth()->user()->id,
            ];

            $studentCollection = StudentCollection::where('id', $data['id'])
                ->update($studentCollection);

            if (! $studentCollection) {
                throw new StudentCollectionException(_lang('Student collection could not be updated.'));
            }

            $studentCollectionDetailsData = [
                'student_collection_id' => $data['id'],
                'session_id' => $data['session_id'] ?? get_option('academic_year'),
                'total_paid' => floatval($data['details']['total_paid']),
                'waiver' => floatval($data['details']['waiver']),
                'fee_and_fine_payable' => floatval($data['total_payable']),
                'fee_and_fine_paid' => floatval($data['details']['total_paid']) - floatval($data['details']['waiver']),
                'total_payable' => floatval($data['details']['total_payable']),
            ];

            $studentCollectionDetails = StudentCollectionDetails::where('student_collection_id', $data['id'])->update(
                $studentCollectionDetailsData
            );

            if (! $studentCollectionDetails) {
                throw new StudentCollectionException(_lang('Student collection details could not be updated.'));
            }

            // Sync with accounting.
            if ($data['total_paid'] > 0) {
                $this->syncAccountingTransaction(
                    $data['id'],
                    'Student Payslip Collection'
                );
            }

            DB::commit();

            return $studentCollection;
        } catch (\Throwable $th) {
            DB::rollBack();
            throw new StudentCollectionException($th->getMessage());
        }
    }

    public function syncAccountingTransaction($studentCollectionId, $description = 'Student Quick Collection')
    {
        $studentCollection = StudentCollection::find($studentCollectionId);
        if (! $studentCollection) {
            throw new StudentCollectionException(_lang('Student collection could not be found.'));
        }

        // If no receive ledger id, then no need to sync with accounting.
        if (empty($studentCollection->receive_ledger_id)) {
            return;
        }

        $accountingCategory = AccountingLedger::where('id', $studentCollection->ledger_id)->first();

        foreach ($studentCollection->details as $studentCollectionDetail) {
            $data = [
                'institute_id' => get_institute_id(),
                'branch_id' => get_branch_id(),
                'category_id' => $accountingCategory->accounting_category_id ?? 1,
                'type' => VoucherType::RECEIPT,
                'transaction_date' => $studentCollection->invoice_date,
                'voucher_id' => $studentCollection->invoice_id,
                'fund_id' => $studentCollection->fund_id,
                'fund_to_id' => null,
                'payment_method_id' => $studentCollectionDetail->ledger_id,
                'payment_method_to_id' => null,
                'reference' => null,
                'description' => $description,

                'details' => [
                    [
                        'fund_id' => $studentCollection->fund_id,
                        'fund_to_id' => null,
                        'ledger_id' => $studentCollectionDetail->ledger_id,
                        'transaction_date' => $studentCollection->invoice_date,
                        'payment_method_id' => $studentCollectionDetail->ledger_id,
                        'payment_method_to_id' => null,
                        'debit' => 0,
                        'credit' => $studentCollectionDetail->total_paid,
                    ],
                ],
            ];

            $this->createAccountingTransaction(
                $data
            );

            $cashLedgerAccount = AccountingLedger::where('ledger_name', 'Cash')->where('id', 1)->first();
            $cashLedgerAccount->update(['balance' => $cashLedgerAccount->balance + $studentCollectionDetail->total_paid]);

            $generalFund = AccountingFund::where('name', 'General Fund')->where('id', 1)->first();
            $generalFund->update(['balance' => $generalFund->balance + $studentCollectionDetail->total_paid]);

            $model_id = auth()->user()->id;
            $studentRollOrID = $studentCollection->student->studentSession->roll ?? $studentCollection->student_id;
            $this->trackAction(
                UserLogAction::COLLECT,
                StudentCollection::class,
                $model_id,
                "Collected a paid amount of $studentCollectionDetail->total_paid from quick collection for Student Roll $studentRollOrID by staff with ID $model_id."
            );
        }
    }
}
