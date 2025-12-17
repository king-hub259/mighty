<?php

namespace Modules\Payroll\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Carbon\Carbon;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Modules\Authentication\Models\User;
use Modules\Payroll\Models\UserPayroll;

class PayrollReportController extends Controller
{
    public function salaryStatementReport(Request $request): JsonResponse
    {
        $year = intval($request->year);
        $month = intval($request->month);
        if (! $year || ! $month) {
            return $this->responseError([], 'Invalid year or month.');
        }

        try {
            $data = UserPayroll::select('payslip_salaries.*', 'user_payrolls.*', 'payments.*')
                ->join('payslip_salaries', 'payslip_salaries.user_id', 'user_payrolls.user_id')
                ->join('payments', 'payments.user_id', 'user_payrolls.user_id')
                ->whereYear('payment_date', $year)
                ->whereMonth('payment_date', $month)
                ->with('user')
                ->get();

            if ($data && count($data) > 0) {
                return $this->responseSuccess($data, _lang('Payroll report successfully.'));
            }

            return $this->responseError([], 'No Data Found', 404);
        } catch (\Exception $e) {
            return $this->responseError([], 'Something went wrong.');
        }
    }

    public function getPaymentInfo(Request $request): JsonResponse
    {
        $fromDate = $request->from_date ?? date('Y-m-01');
        $toDate = $request->to_date ?? date('Y-m-t');

        if (! $fromDate || ! $toDate) {
            return $this->responseError([], 'Please provide valid From date and To date.');
        }
        $fromDate = Carbon::createFromFormat('Y-m-d', $fromDate)->startOfDay();
        $toDate = Carbon::createFromFormat('Y-m-d', $toDate)->endOfDay();

        $hrPaymentsQuery = User::whereIn('user_type', ['Staff', 'Admin'])
            ->join('user_payrolls', 'users.id', '=', 'user_payrolls.user_id')
            ->leftJoin('payslip_salaries', function ($join) use ($fromDate, $toDate) {
                $join->on('users.id', '=', 'payslip_salaries.user_id')
                    ->whereBetween('payslip_salaries.payment_date', [$fromDate, $toDate]);
            })
            ->leftJoin('payments', function ($join) use ($fromDate, $toDate) {
                $join->on('users.id', '=', 'payments.user_id')
                    ->whereBetween('payments.created_at', [$fromDate, $toDate]);
            })
            ->leftJoin('payslip_invoices', 'payslip_salaries.id', '=', 'payslip_invoices.payslip_salary_id')
            ->select([
                'users.id as hr_id',
                'users.name as hr_name',
                'payslip_invoices.invoice_id as invoice_id',
                'payslip_salaries.is_paid',
                'payments.type as payment_type',
                'user_payrolls.net_salary',
                DB::raw('user_payrolls.net_salary - IF(payslip_salaries.paid_amount IS NOT NULL, payslip_salaries.paid_amount, 0) as payable_salary'),
                DB::raw('IF(payslip_salaries.paid_amount IS NOT NULL, payslip_salaries.paid_amount, 0) as paid'),
                'user_payrolls.current_due as due',
                'user_payrolls.current_advance as advance',
                'payslip_salaries.payment_date',
            ]);

        try {
            $hrPayments = $hrPaymentsQuery->get();

            if ($hrPayments && count($hrPayments) > 0) {
                return $this->responseSuccess(
                    $hrPayments,
                    _lang('HR Payments fetch successfully.')
                );
            }

            return $this->responseError([], 'No Data Found', 404);
        } catch (\Exception $e) {
            return $this->responseError([], 'Something went wrong.');
        }
    }
}
