<?php

namespace Modules\Authentication\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Carbon\Carbon;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Modules\Academic\Models\StaffAttendance;
use Modules\Academic\Models\Student;
use Modules\Academic\Models\StudentAttendance;
use Modules\Accounting\Models\AccountTransactionDetail;
use Modules\Authentication\Http\Requests\Settings\SettingUpdateRequest;
use Modules\Authentication\Models\Institute;
use Modules\Authentication\Models\Plan;
use Modules\Authentication\Models\SAASSetting;
use Modules\Authentication\Models\User;
use Modules\Library\Models\Book;

class DashboardController extends Controller
{
    public function index(Request $request): JsonResponse
    {
        $today = Carbon::now()->toDateString();
        // Collecting counts of different entities efficiently
        $fromDate = $request->from_date ?? date('Y-m-01');
        $toDate = $request->to_date ?? date('Y-m-t');

        // Fetch total income and expense
        $totals = AccountTransactionDetail::select([
            DB::raw('SUM(CASE WHEN credit > debit THEN credit ELSE 0 END) as total_income'),
            DB::raw('SUM(CASE WHEN debit > credit THEN debit ELSE 0 END) as total_expense'),
        ])
            ->join('accounting_ledgers', 'account_transaction_details.ledger_id', '=', 'accounting_ledgers.id')
            ->where('account_transaction_details.institute_id', get_institute_id())
            ->where('account_transaction_details.branch_id', get_branch_id())
            ->whereBetween('account_transaction_details.transaction_date', [$fromDate, $toDate])
            ->first();

        // Get today's date
        $today = Carbon::today()->toDateString();
        $today_expense_income = AccountTransactionDetail::select([
            DB::raw('SUM(CASE WHEN credit > debit THEN credit ELSE 0 END) as today_income'),
            DB::raw('SUM(CASE WHEN debit > credit THEN debit ELSE 0 END) as today_expense'),
        ])
            ->join('accounting_ledgers', 'account_transaction_details.ledger_id', '=', 'accounting_ledgers.id')
            ->where('account_transaction_details.institute_id', get_institute_id())
            ->where('account_transaction_details.branch_id', get_branch_id())
            ->whereDate('account_transaction_details.transaction_date', $today) // Filter for today only
            ->first();

        $totalStudents = Student::where('institute_id', get_institute_id())->where('branch_id', get_branch_id())->count();
        $totalMaleStudents = Student::where('institute_id', get_institute_id())->where('branch_id', get_branch_id())->where('gender', 'Male')->count();
        $totalFemaleStudents = Student::where('institute_id', get_institute_id())->where('branch_id', get_branch_id())->where('gender', 'Female')->count();
        $data = [
            'fees_awaiting_payment' => [
                'total' => 59,
                'waiting' => 8,
            ],

            'converted_leads' => [
                'total' => 10,
                'waiting' => 2,
            ],

            'staff_present_today' => [
                'attendance_count' => User::where('institute_id', get_institute_id())->where('branch_id', get_branch_id())->where('user_type', 'Staff')->count(),
                'present_count' => StaffAttendance::where('institute_id', get_institute_id())->where('branch_id', get_branch_id())->where('type', 'Staff')->where('date', $today)->count(),
            ],

            'student_present_today' => [
                'attendance_count' => User::where('institute_id', get_institute_id())->where('branch_id', get_branch_id())->where('user_type', 'Student')->count(),
                'present_count' => StudentAttendance::where('institute_id', get_institute_id())->where('branch_id', get_branch_id())->where('period_id', 1)->where('attendance', 1)->where('date', $today)->count(),
            ],

            'fees_overview' => [
                'unpaid' => 41,
                'partial' => 10,
                'paid' => 8,
            ],

            'enquiry_overview' => [
                'active_student' => User::where('institute_id', get_institute_id())->where('branch_id', get_branch_id())->where('user_type', 'Student')->where('user_status', '1')->count(),
                'own_student' => 2,
                'passive' => 1,
                'lost' => User::where('institute_id', get_institute_id())->where('branch_id', get_branch_id())->where('user_type', 'Student')->where('user_status', '0')->count(),
                'dead' => 1,
            ],

            'library_overview' => [
                'due_for_return' => 34,
                'returned' => 11,
                'issued_out_of' => 33,
                'available_for_out' => 497,
                'books' => Book::count(),
            ],

            'student_today_present' => [
                'present' => $presentCount = StudentAttendance::where('institute_id', get_institute_id())->where('branch_id', get_branch_id())->where('period_id', 1)
                    ->where('attendance', 1)
                    ->where('date', $today)
                    ->count(),
                'present_percentage' => $presentCount > 0
                    ? round(($presentCount / max(1, User::where('institute_id', get_institute_id())->where('branch_id', get_branch_id())->where('user_type', 'Student')->count())) * 100, 2)
                    : 0,

                'absent' => $absentCount = StudentAttendance::where('institute_id', get_institute_id())->where('branch_id', get_branch_id())->where('period_id', 1)
                    ->where('attendance', 2)
                    ->where('date', $today)
                    ->count(),
                'absent_percentage' => $absentCount > 0
                    ? round(($absentCount / max(1, User::where('institute_id', get_institute_id())->where('branch_id', get_branch_id())->where('user_type', 'Student')->count())) * 100, 2)
                    : 0,
            ],

            'student_info' => [
                'total_students' => $totalStudents,
                'total_male_students' => $totalMaleStudents,
                'male_percentage' => $totalStudents > 0 ? round(($totalMaleStudents / $totalStudents) * 100, 2) : 0,
                'total_female_students' => $totalFemaleStudents,
                'female_percentage' => $totalStudents > 0 ? round(($totalFemaleStudents / $totalStudents) * 100, 2) : 0,
            ],

            'today_income' => $today_expense_income->today_income ?? 0,
            'today_expense' => $today_expense_income->today_expense ?? 0,
            'monthly_income' => $totals->total_income ?? 0,
            'monthly_expense' => $totals->total_expense ?? 0,

            'admins' => User::where('institute_id', get_institute_id())->where('branch_id', get_branch_id())->where('user_type', 'Admin')->count(),
            'staffs' => User::where('institute_id', get_institute_id())->where('branch_id', get_branch_id())->where('user_type', 'Staff')->count(),
            'teachers' => User::where('institute_id', get_institute_id())->where('branch_id', get_branch_id())->where('user_type', 'Teacher')->count(),
            'students' => User::where('institute_id', get_institute_id())->where('branch_id', get_branch_id())->where('user_type', 'Student')->count(),
        ];

        return $this->responseSuccess(
            $data,
            _lang('Dashboard data has been fetched successfully.')
        );
    }

    public function studentAttendanceSummary(Request $request): JsonResponse
    {
        $instituteId = get_institute_id();
        $branchId = get_branch_id();
        $type = $request->type; // weekly, half_month, monthly
        $today = Carbon::today();

        // Determine the date range based on type
        if ($type === 'weekly') {
            $startDate = $today->copy()->startOfWeek();
            $endDate = $today->copy()->endOfWeek();
        } elseif ($type === 'half_month') {
            $startDate = $today->day <= 15 ? $today->copy()->startOfMonth() : $today->copy()->startOfMonth()->addDays(15);
            $endDate = $today->day <= 15 ? $startDate->copy()->addDays(14) : $today->copy()->endOfMonth();
        } else { // Monthly
            $startDate = $today->copy()->startOfMonth();
            $endDate = $today->copy()->endOfMonth();
        }

        // Get total students count (to calculate percentage)
        $totalStudents = User::where('institute_id', $instituteId)
            ->where('branch_id', $branchId)
            ->where('user_type', 'Student')
            ->count();

        // Fetch attendance data
        $attendanceData = StudentAttendance::where('institute_id', $instituteId)
            ->where('branch_id', $branchId)
            ->whereBetween('date', [$startDate, $endDate])
            ->select(
                DB::raw('DATE(date) as attendance_date'),
                DB::raw('SUM(attendance = "1") as present_count'),
                DB::raw('SUM(attendance = "2") as absent_count')
            )
            ->groupBy('attendance_date')
            ->orderBy('attendance_date', 'asc')
            ->get()
            ->keyBy('attendance_date');

        // Generate response with all dates
        $result = [];
        for ($date = $startDate->copy(); $date->lte($endDate); $date->addDay()) {
            $dateStr = $date->format('Y-m-d');
            $data = $attendanceData->get($dateStr);

            $present = $data->present_count ?? 0;
            $absent = $data->absent_count ?? 0;

            $result[] = [
                'date' => $dateStr,
                'present' => $present,
                'present_percentage' => $totalStudents > 0 ? round(($present / $totalStudents) * 100, 2) : 0,
                'absent' => $absent,
                'absent_percentage' => $totalStudents > 0 ? round(($absent / $totalStudents) * 100, 2) : 0,
            ];
        }

        return $this->responseSuccess($result, _lang('Attendance report generated successfully.'));
    }

    public function saasDashboardData(Request $request): JsonResponse
    {
        $year = (int) $request->year ?? now()->year;

        $totalInstitutesCount = Institute::count();
        $totalPackages = Plan::count();
        $totalActiveInstitute = Institute::where('status', 1)->count();
        $totalInactiveInstitute = Institute::where('status', 2)->count();

        // Monthly transaction collection for current year
        $monthlyData = DB::table('subscription_items')
            ->selectRaw('MONTH(created_at) as month, SUM(amount_paid) as total_paid')
            ->whereYear('created_at', $year)
            ->whereNull('deleted_at')
            ->groupBy(DB::raw('MONTH(created_at)'))
            ->pluck('total_paid', 'month');

        $monthlyReport = collect(range(1, 12))->map(function ($month) use ($monthlyData) {
            return [
                'month' => Carbon::create()->month($month)->format('F'),
                'total_paid' => $monthlyData->get($month, 0),
            ];
        });

        // Total unique institutes with active subscriptions
        $totalInstitutes = DB::table('subscriptions')
            ->where('status', 'active')
            ->whereNull('deleted_at')
            ->distinct('institute_id')
            ->count('institute_id');

        // Plan usage with percentages
        $planUsage = DB::table('subscriptions')
            ->join('plans', 'subscriptions.plan_id', '=', 'plans.id')
            ->where('subscriptions.status', 'active')
            ->whereNull('subscriptions.deleted_at')
            ->select('plans.id as plan_id', 'plans.name as plan_name', DB::raw('COUNT(DISTINCT subscriptions.institute_id) as institute_count'))
            ->groupBy('plans.id', 'plans.name')
            ->get()
            ->map(function ($item) use ($totalInstitutes) {
                return [
                    'plan_id' => $item->plan_id,
                    'plan_name' => $item->plan_name,
                    'institute_count' => $item->institute_count,
                    'usage_percent' => $totalInstitutes > 0
                        ? round(($item->institute_count / $totalInstitutes) * 100, 2)
                        : 0,
                ];
            });

        return $this->responseSuccess([
            'total_institutes' => $totalInstitutesCount,
            'total_packages' => $totalPackages,
            'total_active_institute' => $totalActiveInstitute,
            'total_inactive_institute' => $totalInactiveInstitute,
            'transactions' => $monthlyReport,
            'package_report' => $planUsage,
        ], _lang('SaaS Dashboard data has been fetched successfully.'));
    }

    public function getSAASSettings(Request $request)
    {
        $saas_settings = DB::table('s_a_a_s_settings')->pluck('value', 'name')->toArray();

        return $this->responseSuccess($saas_settings, _lang('SaaS settings fetched successfully.'));
    }

    public function sAASSettingsUpdate(SettingUpdateRequest $request): JsonResponse
    {
        try {
            // If POST request, update or create settings
            DB::beginTransaction();
            foreach ($request->validated() as $key => $value) {
                if ($key === '_token') {
                    continue;
                }

                SAASSetting::updateOrInsert(
                    [
                        'name' => $key,
                    ],
                    [
                        'value' => $value,
                        'updated_at' => now(),
                        'created_at' => now(),
                    ]
                );
            }
            DB::commit();

            return $this->responseSuccess([], _lang('SAAS Settings have been successfully updated.'));
        } catch (\Exception $e) {
            DB::rollBack();

            return $this->responseError(['error' => $e->getMessage()], _lang('Failed to store records unsuccessfully.'));
        }
    }

    public function uploadLogo(Request $request): JsonResponse
    {
        $request->validate([
            'logo' => 'required|image|mimes:jpeg,png,jpg|max:8192',
        ]);

        $image = $request->file('logo');
        $name = 'logo.'.$image->getClientOriginalExtension();
        $destinationPath = public_path('/uploads/saas_logos');
        $image->move($destinationPath, $name);

        $data = [];
        $data['value'] = $name;
        $data['updated_at'] = Carbon::now();

        if (SAASSetting::where('name', 'logo')->exists()) {
            SAASSetting::where('name', '=', 'logo')->update($data);
        } else {
            $data['name'] = 'logo';
            $data['created_at'] = Carbon::now();
            SAASSetting::insert($data);
        }

        return $this->responseSuccess(
            [],
            _lang('SAAS settings logo have been successfully updated')
        );
    }
}
