<?php

namespace Modules\Payroll\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Modules\Academic\Services\UserService;
use Modules\Payroll\Models\PayrollAccountingMapping;
use Modules\Payroll\Models\SalaryHeadUserPayroll;
use Modules\Payroll\Models\UserPayroll;
use Modules\Payroll\Services\PaymentService;
use Modules\Payroll\Services\PayslipSalaryService;
use Modules\Payroll\Services\SalaryHeadService;
use Modules\Payroll\Services\UserPayrollService;

class PayrollController extends Controller
{
    public const USER_TYPE = 'Student';

    public function __construct(
        private readonly SalaryHeadService $salaryHeadService,
        private readonly UserPayrollService $userPayrollService,
        private readonly UserService $userService,
        private readonly PaymentService $paymentService,
        private readonly PayslipSalaryService $salaryPaymentService,
    ) {}

    public function index(): JsonResponse
    {
        // Get common data: users, salary heads, and user payroll data
        [$users, $salaryHeads, $salaryHeadUserPayrolls] = $this->commonData();

        // Convert $salaryHeadUserPayrolls to a collection if it is not already
        $salaryHeadUserPayrolls = collect($salaryHeadUserPayrolls);

        // Map each user with their salary heads and payrolls
        $mappedData = $users->map(function ($user) use ($salaryHeads, $salaryHeadUserPayrolls) {
            // Filter salary heads and payrolls for the current user
            $userSalaryHeads = $salaryHeads; // Modify if necessary
            $userPayrolls = $salaryHeadUserPayrolls->where('user_id', $user->id); // Now works since it's a collection

            return [
                'user' => $user,
                'salary_heads' => $userSalaryHeads->values(),
                'salary_head_user_payrolls' => $userPayrolls->values(), // Reset keys if needed
            ];
        });

        return $this->responseSuccess(
            $mappedData,
            _lang('Payroll Assign fetch successfully.')
        );
    }

    public function create(Request $request): JsonResponse
    {
        $result = $this->salaryHeadService->updatePayrollsAPI($request->all());

        if (! $result) {
            return $this->responseError([], $result['message']);
        }

        return $this->responseSuccess(
            [],
            _lang($result['message'])
        );
    }

    public function salaryCreateGet(Request $request): JsonResponse
    {
        $year = (int) $request->year;
        $month = $request->month;

        // Get common data: users, salary heads, and user payroll data
        [$users, $salaryHeads, $salaryHeadUserPayrolls] = $this->commonData();

        // Convert $salaryHeadUserPayrolls to a collection if it is not already
        $salaryHeadUserPayrolls = collect($salaryHeadUserPayrolls);

        // Map each user with their salary heads and payrolls
        $mappedData = $users->map(function ($user) use ($salaryHeads, $salaryHeadUserPayrolls) {
            // Filter salary heads and payrolls for the current user
            $userSalaryHeads = $salaryHeads; // Modify if necessary
            $userPayrolls = $salaryHeadUserPayrolls->where('user_id', $user->id); // Now works since it's a collection

            return [
                'user' => $user,
                'salary_heads' => $userSalaryHeads->values(),
                'salary_head_user_payrolls' => $userPayrolls->values(), // Reset keys if needed
            ];
        });

        return $this->responseSuccess(
            [
                'year' => $year,
                'month' => $month,
                'salary_slips' => $mappedData,
            ],
            _lang('Payroll Create fetch successfully.')
        );
    }

    public function salaryCreate(Request $request): JsonResponse
    {
        $result = $this->userPayrollService->createPayslipSalariesAndHeadsAPI($request->all());

        if (! $result) {
            return $this->responseError([], $result['message']);
        }

        return $this->responseSuccess(
            [],
            _lang('Payslip Create successfully.')
        );
    }

    public function salaryPaymentProcess(Request $request): JsonResponse
    {
        $year = intval($request->year);
        $month = intval($request->month);

        // Get common data: users, salary heads, and user payroll data
        [$users, $salaryHeads, $salaryHeadUserPayrolls] = $this->commonData();

        // Convert $salaryHeadUserPayrolls to a collection if it is not already
        $salaryHeadUserPayrolls = collect($salaryHeadUserPayrolls);

        // Filter users with valid payslipSalary for the given year and month
        $filteredUsers = $users->filter(function ($user) use ($year, $month) {
            return isset($user->payslipSalary) &&
                $user->payslipSalary->some(fn ($payslip) => $payslip->year == $year && $payslip->month == $month && $payslip->is_paid !== '1');
        });

        // Map filtered users with their respective salary heads and payroll data
        $mappedData = $filteredUsers->map(function ($user) use ($salaryHeads, $salaryHeadUserPayrolls) {
            $userPayrollId = $user->userPayroll->id ?? null;

            // Filter salary head user payrolls for the current user
            $userSalaryHeadUserPayrolls = $salaryHeadUserPayrolls->filter(function ($item) use ($userPayrollId) {
                return $item->user_payroll_id === $userPayrollId;
            });

            // Calculate due amount and payable amount
            $currentDue = $user->userPayroll->current_due ?? 0;
            $currentAdvance = $user->userPayroll->current_advance ?? 0;
            $netSalary = $user->userPayroll->net_salary ?? 0;

            $dueAmount = $currentDue - $currentAdvance;
            $payableAmount = $netSalary + $dueAmount;

            return [
                'user' => $user,
                'salary_heads' => $salaryHeads->values(),
                'salary_head_user_payrolls' => $userSalaryHeadUserPayrolls->values(),
                'due_amount' => $dueAmount,
                'net_salary' => $netSalary,
                'payable_amount' => $payableAmount,
                'salary_slips' => $payableAmount,
            ];
        });

        return $this->responseSuccess(
            [
                'year' => $year,
                'month' => $month,
                'salary_slips' => $mappedData->values(),
            ],
            _lang('Payroll Create fetch successfully.')
        );
    }

    public function salaryPayment(Request $request): JsonResponse
    {
        $result = $this->salaryPaymentService->processSalaryPayment($request);

        if (! $result) {
            return $this->responseError([], $result['message']);
        }

        return $this->responseSuccess(
            [],
            _lang('Salary Payment successfully.')
        );
    }

    public function advanceSalaryPayment(Request $request): JsonResponse
    {
        $request->validate([
            'user_id' => 'required',
        ]);

        [$user, $userPayroll] = $this->getUserAndUserPayroll($request->user_id);

        return $this->responseSuccess(
            [
                'user' => $user,
                'userPayroll' => $userPayroll,
            ],
            _lang('Staff Found for advance payment.')
        );
    }

    public function advanceSalaryPay(Request $request): JsonResponse
    {
        $result = $this->paymentService->processPayment($request->all());

        return $this->responseSuccess(
            $result,
            _lang('Advance Payment pay successfully.')
        );
    }

    public function dueSalaryPayment(Request $request): JsonResponse
    {
        $request->validate([
            'user_id' => 'required',
        ]);

        [$user, $userPayroll] = $this->getUserAndUserPayroll($request->user_id);

        return $this->responseSuccess(
            [
                'user' => $user,
                'userPayroll' => $userPayroll,
            ],
            _lang('Staff Found for advance payment.')
        );
    }

    public function dueSalaryPay(Request $request): JsonResponse
    {
        $result = $this->paymentService->processPayment($request->all());

        return $this->responseSuccess(
            $result,
            _lang('Due payment return successfully.')
        );
    }

    public function returnSalaryPayment(Request $request): JsonResponse
    {
        $request->validate([
            'user_id' => 'required',
        ]);

        [$user, $userPayroll] = $this->getUserAndUserPayroll($request->user_id);

        return $this->responseSuccess(
            [
                'user' => $user,
                'userPayroll' => $userPayroll,
            ],
            _lang('Staff Found for advance payment.')
        );
    }

    public function returnSalaryPay(Request $request): JsonResponse
    {
        $result = $this->paymentService->processPayment($request->all());

        return $this->responseSuccess(
            $result,
            _lang('Return payment successfully.')
        );
    }

    public function mapping(): JsonResponse
    {
        $data = PayrollAccountingMapping::with('ledger', 'fund')->get();

        return $this->responseSuccess(
            $data,
            _lang('Payroll Mapping data fetch successfully.')
        );
    }

    public function mappingStore(Request $request): JsonResponse
    {
        $data = PayrollAccountingMapping::first();

        if ($request->ledger_id != null && $request->fund_id != null) {
            if (isset($data)) {
                $mapping = PayrollAccountingMapping::where('id', $data->id)->update([
                    'ledger_id' => $request->ledger_id,
                    'fund_id' => $request->fund_id,
                ]);
            } else {
                $mapping = PayrollAccountingMapping::create([
                    'ledger_id' => $request->ledger_id,
                    'fund_id' => $request->fund_id,
                ]);
            }
        }

        if (isset($mapping)) {

            return $this->responseSuccess(
                $data,
                _lang('Payroll Configured.')
            );
        } else {
            return $this->responseError([], _lang('Something Went Wrong'));
        }
    }

    public function staffSalaryConfig(): JsonResponse
    {
        [$users, $salaryHeads, $salaryHeadUserPayrolls] = $this->commonData();

        return $this->responseSuccess(
            [
                'users' => $users,
                'salary_heads' => $salaryHeads,
                'salary_head_user_payrolls' => $salaryHeadUserPayrolls,
            ],
            _lang('Staff Salary config successfully.')
        );
    }

    public function staffSalaryConfigCreate(Request $request): JsonResponse
    {
        $salaryHeads = $request->salary_heads;

        foreach ($request->staff_ids as $staffId) {
            if ($request->has('net_salary')) {
                $netSalary = $request->net_salary;
                if (isset($netSalary)) {
                    $userPayroll = UserPayroll::updateOrCreate(
                        ['user_id' => $staffId],
                        ['net_salary' => $netSalary]
                    );

                    if ($userPayroll) {
                        if (isset($salaryHeads[$staffId]) && is_array($salaryHeads[$staffId])) {
                            foreach ($salaryHeads[$staffId] as $salaryHeadId => $amount) {
                                SalaryHeadUserPayroll::updateOrCreate(
                                    [
                                        'user_payroll_id' => $userPayroll->id,
                                        'salary_head_id' => $salaryHeadId,
                                    ],
                                    ['amount' => $amount]
                                );
                            }
                        }
                    }
                }
            }
        }

        return $this->responseSuccess(
            [],
            _lang('Payroll Configured.')
        );
    }

    private function commonData(): array
    {
        $users = $this->userService->getUsersByExcludedType(self::USER_TYPE);
        $salaryHeadUserPayrolls = $this->salaryHeadService->getSalaryHeadUserPayrollsForUsers($users->pluck('id')->toArray());
        $salaryHeads = $this->salaryHeadService->getSalaryHeads();

        return [$users, $salaryHeads, $salaryHeadUserPayrolls];
    }

    private function getUserAndUserPayroll(int $userId): array
    {
        $user = $this->userService->findUserById(intval($userId));
        $userPayroll = $this->userPayrollService->findByUserId(intval($userId));

        return [$user, $userPayroll];
    }
}
