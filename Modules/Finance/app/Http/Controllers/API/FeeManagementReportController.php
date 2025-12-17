<?php

namespace Modules\Finance\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Traits\StudentCollectionTrait;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Modules\Academic\Models\Student;
use Modules\Academic\Models\StudentSession;
use Modules\Academic\Services\SectionService;
use Modules\Finance\Models\Fee;
use Modules\Finance\Models\StudentCollection;
use Modules\Finance\Models\StudentCollectionDetailsSubHead;

class FeeManagementReportController extends Controller
{
    use StudentCollectionTrait;

    public function __construct(
        private readonly SectionService $sectionService,
    ) {}

    public function getMonthlyPaidInfo(Request $request): JsonResponse
    {
        $year = $request->year;
        $month = $request->month;

        $studentDetails = StudentCollection::select(
            'students.id as student_id',
            'student_sessions.roll',
            'students.first_name',
            'student_collections.invoice_id',
            'student_collections.invoice_date',
            DB::raw('GROUP_CONCAT(fee_heads.name, ": ", student_collection_details.fee_and_fine_paid) as details'),
            DB::raw('SUM(student_collection_details.fee_and_fine_paid) as total_amount')
        )
            ->leftJoin('students', 'students.id', '=', 'student_collections.student_id')
            ->leftJoin('student_collection_details', 'student_collections.id', '=', 'student_collection_details.student_collection_id')
            ->leftJoin('fee_heads', 'fee_heads.id', '=', 'student_collection_details.fee_head_id')
            ->leftJoin('student_sessions', 'student_collections.session_id', '=', 'student_sessions.id')
            ->where('student_collections.institute_id', get_institute_id())
            ->where('student_collections.branch_id', get_branch_id())
            ->whereYear('student_collections.invoice_date', $year)
            ->whereMonth('student_collections.invoice_date', date('m', strtotime($month)))
            ->groupBy('students.id', 'students.first_name', 'student_collections.invoice_id', 'student_collections.invoice_date')
            ->get();

        return $this->responseSuccess(
            $studentDetails,
            _lang('Fee Head has been fetched successfully.')
        );
    }

    public function getClassWisePaymentSummary(Request $request): JsonResponse
    {
        $feeHeads = $request->fee_heads;
        $year = $request->year;

        if (! empty($request->fee_heads)) {
            $monthlyData = DB::table('student_collections as sc')
                ->where('sc.institute_id', get_institute_id())
                ->where('sc.branch_id', get_branch_id())
                ->join('student_collection_details as scd', 'sc.id', '=', 'scd.student_collection_id')
                ->join('classes', 'sc.class_id', '=', 'classes.id')
                ->whereIn('scd.fee_head_id', function ($query) use ($feeHeads) {
                    $query->select('id')
                        ->from('fee_heads')
                        ->whereIn('id', $feeHeads);
                })
                ->whereYear('sc.invoice_date', $year)
                ->select(
                    'sc.class_id',
                    'classes.class_name',
                    DB::raw('SUM(CASE WHEN MONTH(sc.invoice_date) = 1 THEN scd.fee_and_fine_payable ELSE 0 END) as January'),
                    DB::raw('SUM(CASE WHEN MONTH(sc.invoice_date) = 2 THEN scd.fee_and_fine_payable ELSE 0 END) as February'),
                    DB::raw('SUM(CASE WHEN MONTH(sc.invoice_date) = 3 THEN scd.fee_and_fine_payable ELSE 0 END) as March'),
                    DB::raw('SUM(CASE WHEN MONTH(sc.invoice_date) = 4 THEN scd.fee_and_fine_payable ELSE 0 END) as April'),
                    DB::raw('SUM(CASE WHEN MONTH(sc.invoice_date) = 5 THEN scd.fee_and_fine_payable ELSE 0 END) as May'),
                    DB::raw('SUM(CASE WHEN MONTH(sc.invoice_date) = 6 THEN scd.fee_and_fine_payable ELSE 0 END) as June'),
                    DB::raw('SUM(CASE WHEN MONTH(sc.invoice_date) = 7 THEN scd.fee_and_fine_payable ELSE 0 END) as July'),
                    DB::raw('SUM(CASE WHEN MONTH(sc.invoice_date) = 8 THEN scd.fee_and_fine_payable ELSE 0 END) as August'),
                    DB::raw('SUM(CASE WHEN MONTH(sc.invoice_date) = 9 THEN scd.fee_and_fine_payable ELSE 0 END) as September'),
                    DB::raw('SUM(CASE WHEN MONTH(sc.invoice_date) = 10 THEN scd.fee_and_fine_payable ELSE 0 END) as October'),
                    DB::raw('SUM(CASE WHEN MONTH(sc.invoice_date) = 11 THEN scd.fee_and_fine_payable ELSE 0 END) as November'),
                    DB::raw('SUM(CASE WHEN MONTH(sc.invoice_date) = 12 THEN scd.fee_and_fine_payable ELSE 0 END) as December')
                )
                ->groupBy('sc.class_id')
                ->get();

            return $this->responseSuccess(
                $monthlyData,
                _lang('Fee Head has been fetched successfully.')
            );
        }

        return $this->responseSuccess(
            [],
            _lang('Fee Head has been fetched successfully.')
        );
    }

    public function getUnpaidFeeInfo(Request $request): JsonResponse
    {
        $sessionId = (int) $request->session_id;
        $sectionId = (int) $request->section_id;

        $students = Student::query()
            ->select('users.id', 'users.name', 'users.email', 'users.phone', 'users.image', 'users.role_id', 'users.status', 'users.user_status', 'users.user_type', 'student_sessions.roll', 'classes.class_name', 'sections.section_name', 'students.id as id', 'student_groups.group_name', 'students.student_category_id', 'students.status as student_status')
            ->join('users', 'users.id', '=', 'students.user_id')
            ->join('student_sessions', 'students.id', '=', 'student_sessions.student_id')
            ->leftJoin('classes', 'classes.id', '=', 'student_sessions.class_id')
            ->leftJoin('sections', 'sections.id', '=', 'student_sessions.section_id')
            ->leftJoin('student_groups', 'students.group', '=', 'student_groups.id')
            ->where('student_sessions.session_id', $sessionId)
            ->where('student_sessions.institute_id', get_institute_id())
            ->where('student_sessions.branch_id', get_branch_id())
            ->where('users.user_type', 'Student')
            ->where('student_sessions.section_id', $sectionId)
            ->orderBy('student_sessions.roll', 'ASC')
            ->get();

        $studentDatas = [];
        foreach ($students as $s_key => $student) {
            $id = $student->id;
            $session = StudentSession::where('student_id', $id)->first();
            $amountConfig = Fee::where('section_id', $session->section_id)
                ->where('class_id', $session->class_id)
                ->with('feeHead')
                ->get();
            $feeHeads = [];
            $total_paid_amount = 0;
            foreach ($amountConfig as $config) {
                $feeHeads[] = $config->feeHead;
                $feeHeads = array_unique($feeHeads);
            }

            // Check the fee subheads if already added and remove them from the feeHeads array.
            foreach ($feeHeads as $key => $feeHead) {
                $feeSubHeads = $feeHead->feeSubHeads;
                $updatedFeeSubHeads = [];

                $amount = [];
                foreach ($feeSubHeads as $skey => $feeSubHead) {
                    $studentCollectionDetailsSubHead = StudentCollectionDetailsSubHead::where('student_id', $id)
                        ->where('session_id', $session->session_id)
                        ->where('fee_head_id', $feeHead->id)
                        ->where('sub_head_id', $feeSubHead->id)
                        ->first();

                    if (! $studentCollectionDetailsSubHead || $studentCollectionDetailsSubHead->collectionDetail->total_paid === 0) {
                        array_push(
                            $updatedFeeSubHeads,
                            $feeSubHead
                        );
                        $payable_amount = $this->getCollectionAmountsByFeeHeadAndSubHeads(
                            $id,
                            $feeHead->id,
                            (array) $feeSubHead->id
                        );
                        $amount[$feeSubHead->id] = $payable_amount;
                        $total_paid_amount += $payable_amount['fee_and_fine_payable'];
                    }
                }

                $feeHeads[$key]->feeSubHeads = $updatedFeeSubHeads;
                $feeHeads[$key]->amount = $amount;
            }
            $studentDatas[$s_key] = $student;
            $studentDatas[$s_key]['feeHeads'] = $feeHeads;
            $studentDatas[$s_key]['total_paid_amount'] = $total_paid_amount;
        }

        return $this->responseSuccess(
            $studentDatas,
            _lang('Student has been fetched successfully.')
        );
    }

    public function getPaymentRatioInfo(Request $request): JsonResponse
    {
        $year = $request->year;
        $feeHead = $request->fee_head;
        $payments = [];

        if (! empty($year)) {
            $query = DB::table('classes')
                ->select(
                    'classes.class_name',
                    DB::raw('COUNT(students.id) as total_students'),
                    DB::raw('COUNT(DISTINCT CASE WHEN student_collection_details.total_paid > 0 THEN students.id END) as paid_students'),
                    DB::raw('CONCAT(ROUND(COUNT(DISTINCT CASE WHEN student_collection_details.total_paid > 0 THEN students.id END) / COUNT(students.id) * 100, 2), "%") as paid_percentage'),
                    DB::raw('COUNT(DISTINCT CASE WHEN student_collection_details.total_paid = 0 THEN students.id END) as unpaid_students'),
                    DB::raw('CONCAT(ROUND(COUNT(DISTINCT CASE WHEN student_collection_details.total_paid = 0 THEN students.id END) / COUNT(students.id) * 100, 2), "%") as unpaid_percentage')
                )
                ->leftJoin('student_collections', 'student_collections.class_id', '=', 'classes.id')
                ->leftJoin('student_collection_details', 'student_collections.id', '=', 'student_collection_details.student_collection_id')
                ->leftJoin('students', 'student_collection_details.student_id', '=', 'students.id')
                ->whereYear('student_collections.invoice_date', $year)
                ->where('student_collections.institute_id', get_institute_id())
                ->where('student_collections.branch_id', get_branch_id())
                ->groupBy('classes.class_name');

            if (! empty($feeHead)) {
                $query->where('student_collection_details.fee_head_id', $feeHead);
            }

            $payments = $query->get();
        }

        return $this->responseSuccess(
            $payments,
            _lang('Payment Ratio has been fetched successfully.')
        );
    }

    public function getPaymentInfo(Request $request): JsonResponse
    {
        $from_date = $request->from_date;
        $to_date = $request->to_date;

        $studentCollections = StudentCollection::where('institute_id', get_institute_id())
            ->where('branch_id', get_branch_id())
            ->whereBetween('invoice_date', [$from_date, $to_date])
            ->with(['student', 'details' => function ($q) {
                return $q->with('feeHead', 'subHeads');
            }])
            ->get();

        return $this->responseSuccess(
            $studentCollections,
            _lang('Student Collections has been fetched successfully.')
        );
    }

    public function getHeadWisePayment(Request $request): JsonResponse
    {
        $section = $request->section_id;
        $year = $request->year;

        $headWisePayment = Student::join('student_collections', 'students.id', '=', 'student_collections.student_id')
            ->join('student_sessions', 'student_sessions.id', '=', 'student_collections.session_id')
            ->join('student_collection_details', 'student_collection_details.student_id', '=', 'students.id')
            ->join('fee_heads', 'student_collection_details.fee_head_id', '=', 'fee_heads.id')
            ->select(
                'students.id as student_id',
                'students.first_name',
                'students.last_name',
                DB::raw('MAX(student_sessions.roll) as roll'), // Use aggregate for roll
                DB::raw('SUM(student_collections.total_paid) as total_paid'), // Aggregate total_paid
                DB::raw('MAX(student_collections.invoice_id) as invoice_id'), // Use MAX for non-grouped columns
                DB::raw('MAX(student_collections.invoice_date) as invoice_date'), // Use MAX for dates
                'fee_heads.name as fee_head_name',
                DB::raw('SUM(student_collection_details.total_paid) as fee_total_paid') // Aggregate fee_total_paid
            )
            ->where('student_collections.institute_id', get_institute_id())
            ->where('student_collections.branch_id', get_branch_id())
            ->whereYear('student_collections.invoice_date', $year)
            ->where('student_sessions.section_id', $section) // Adjusted for AND condition
            ->groupBy('students.id', 'fee_heads.name', 'students.first_name', 'students.last_name')
            ->get();

        return $this->responseSuccess(
            $headWisePayment,
            _lang('Head Wise Payment has been fetched successfully.')
        );
    }

    public function getUnpaidFeeSummery(Request $request): JsonResponse
    {
        $year = (int) $request->year;
        $section = (int) $request->section;

        if (! empty($year)) {
            $dues = Student::select(
                'students.id as student_id',
                'students.first_name',
                'student_sessions.roll',
                DB::raw('GROUP_CONCAT(
                    DISTINCT
                    CASE
                        WHEN (student_collection_details.total_payable - student_collection_details.total_paid) <> 0
                        THEN CONCAT(fee_heads.name, " : ", fee_sub_heads.name, "(", student_collection_details.total_paid - student_collection_details.total_payable, ")")
                    END
                    ORDER BY fee_sub_heads.id ASC
                    SEPARATOR ", "
                ) as due_details'),
                DB::raw('SUM(student_collection_details.fee_and_fine_payable - student_collection_details.fee_and_fine_paid) as total_fee_due'),
                DB::raw('SUM(student_collection_details.previous_due_payable - student_collection_details.previous_due_paid) as total_slip_due'),
                DB::raw('SUM(student_collection_details.total_payable - student_collection_details.total_paid) as total_due')
            )
                ->where('student_collection_details.institute_id', get_institute_id())
                ->where('student_collection_details.branch_id', get_branch_id())
                ->where('student_collection_details.total_payable', '>=', 'student_collection_details.total_paid')
                ->leftJoin('student_sessions', 'students.id', '=', 'student_sessions.student_id')
                ->leftJoin('student_collections', 'student_collections.student_id', '=', 'students.id')
                ->leftJoin('student_collection_details', 'student_collections.id', '=', 'student_collection_details.student_collection_id')
                ->leftJoin('fee_heads', 'student_collection_details.fee_head_id', '=', 'fee_heads.id')
                ->leftJoin('student_collection_details_sub_heads as scds', 'student_collection_details.id', '=', 'scds.student_collection_details_id')
                ->leftJoin('fee_sub_heads', 'scds.sub_head_id', '=', 'fee_sub_heads.id')
                ->whereYear('student_collections.invoice_date', $year)
                ->groupBy('students.id', 'student_sessions.roll');

            if (! empty($section)) {
                $dues->where('student_sessions.section_id', $section);
            }

            $unpaidInfos = $dues->get();
        }

        return $this->responseSuccess(
            $unpaidInfos,
            _lang('Unpaid Infos has been fetched successfully.')
        );
    }

    public function getPaidFees(Request $request): JsonResponse
    {
        $year = (int) $request->year;
        $section = (int) $request->section_id;
        $fromDate = $request->fromDate;
        $toDate = $request->toDate;
        $result = [];

        if (! empty($year)) {
            $invoiceData = DB::table('student_collections')
                ->join('students', 'student_collections.student_id', '=', 'students.id')
                ->join('student_collection_details', 'student_collections.id', '=', 'student_collection_details.student_collection_id')
                ->join('fee_heads', 'student_collection_details.fee_head_id', '=', 'fee_heads.id')
                ->join('student_sessions', 'student_collections.session_id', '=', 'student_sessions.id')
                ->leftJoin('student_collection_details_sub_heads', 'student_collection_details.id', '=', 'student_collection_details_sub_heads.student_collection_details_id')
                ->leftJoin('fee_sub_heads', 'student_collection_details_sub_heads.sub_head_id', '=', 'fee_sub_heads.id')
                ->leftJoin('accounting_ledgers', 'student_collections.ledger_id', '=', 'accounting_ledgers.id')
                ->select(
                    'student_collections.invoice_id',
                    DB::raw('CONCAT(students.first_name, " ", students.last_name) as student_name'),
                    'students.roll_no as roll',
                    DB::raw('MAX(fee_heads.name) as fee_head_name'), // Aggregated
                    DB::raw('MAX(fee_sub_heads.name) as fee_sub_head_name'), // Aggregated
                    DB::raw('MAX(accounting_ledgers.ledger_name) as ledger_name'), // Aggregated
                    DB::raw('YEAR(student_collections.invoice_date) as year'), // Aggregated for clarity
                    'student_collections.invoice_date',
                    'student_sessions.section_id',
                    DB::raw('SUM(student_collections.total_payable) as payable_amount'), // Aggregated
                    DB::raw('SUM(student_collections.total_paid) as paid_amount'), // Aggregated
                    DB::raw('SUM(student_collections.total_due) as due_amount') // Aggregated
                )
                ->where('student_collections.institute_id', get_institute_id())
                ->where('student_collections.branch_id', get_branch_id());

            // Apply filters
            if ($year) {
                $invoiceData->whereYear('student_collections.invoice_date', $year);
            }
            if ($fromDate) {
                $invoiceData->where('student_collections.invoice_date', '>=', $fromDate);
            }
            if ($toDate) {
                $invoiceData->where('student_collections.invoice_date', '<=', $toDate);
            }
            if ($section) {
                $invoiceData->where('student_sessions.section_id', $section);
            }

            $result = $invoiceData->groupBy('student_collections.invoice_id')->get();
        }

        return $this->responseSuccess(
            $result,
            _lang('Head Wise Payment has been fetched successfully.')
        );
    }

    public function getSubHeadWisePayment(Request $request): JsonResponse
    {
        $section = (int) $request->section_id;
        $year = (int) $request->year;
        $fee_head = (int) $request->fee_head_id;

        $headWiseDue = Student::join('student_collections', 'students.id', '=', 'student_collections.student_id')
            ->join('student_sessions', 'student_sessions.id', '=', 'student_collections.session_id')
            ->join('student_collection_details', 'student_collection_details.student_id', '=', 'students.id')
            ->join('student_collection_details_sub_heads as scds', 'scds.student_id', '=', 'students.id')
            ->join('fee_heads', 'student_collection_details.fee_head_id', '=', 'fee_heads.id')
            ->join('fee_sub_heads', 'scds.sub_head_id', '=', 'fee_sub_heads.id')
            ->select(
                'students.id as student_id',
                'students.first_name',
                'students.last_name',
                DB::raw('MAX(student_sessions.roll) as roll'), // Aggregated roll
                DB::raw('MAX(student_collections.id) as collection_id'), // Aggregated collection ID
                'fee_sub_heads.name as fee_sub_head_name',
                'fee_sub_heads.id as sub_id'
            )
            ->where('student_collections.institute_id', get_institute_id())
            ->where('student_collections.branch_id', get_branch_id())
            ->whereYear('student_collections.invoice_date', $year)
            ->where('student_sessions.section_id', $section) // Ensures filtering is properly applied
            ->where('fee_heads.id', $fee_head)
            ->groupBy('fee_sub_heads.id', 'students.id', 'fee_sub_heads.name', 'students.first_name', 'students.last_name') // Grouping by relevant columns
            ->get();

        // Additional processing if needed for 'due'
        $headWiseDue->transform(function ($data) {
            $due = StudentCollection::find($data->collection_id); // Fetch only necessary data
            $data->due = $due ? $due->total_due : 0; // Example field 'total_due', adjust as needed

            return $data;
        });

        return $this->responseSuccess(
            $headWiseDue,
            _lang('Head Wise Due has been fetched successfully.')
        );
    }
}
