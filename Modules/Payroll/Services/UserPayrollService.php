<?php

declare(strict_types=1);

namespace Modules\Payroll\Services;

use Illuminate\Contracts\Pagination\LengthAwarePaginator;
use Illuminate\Support\Facades\DB;
use Modules\Payroll\Models\PayslipSalary;
use Modules\Payroll\Models\UserPayroll;
use Modules\Payroll\Repositories\UserPayrollRepository;

class UserPayrollService
{
    public function __construct(
        private readonly UserPayrollRepository $userPayrollRepository,
        private readonly PayslipSalaryHeadService $payslipSalaryHeadService,
        private readonly PayslipInvoiceService $payslipInvoiceService,
    ) {}

    public function getUserPayrolls(array $filter = [], int $perPage = 100): LengthAwarePaginator
    {
        return $this->userPayrollRepository->paginate($perPage, $filter);
    }

    public function findUserPayrollById(int $id): ?UserPayroll
    {
        return $this->userPayrollRepository->show($id);
    }

    public function createUserPayroll(array $data): ?UserPayroll
    {
        $data['institute_id'] = get_institute_id();
        $data['branch_id'] = get_branch_id();

        return $this->userPayrollRepository->create($data);
    }

    public function updateUserPayroll(array $data, int $id): mixed
    {
        return $this->userPayrollRepository->update($data, $id);
    }

    public function deleteUserPayrollById(int $id): int
    {
        return $this->userPayrollRepository->delete($id);
    }

    public function findByUserId(int $userId): ?UserPayroll
    {
        return UserPayroll::where('user_id', intval($userId))->first();
    }

    public function createPayslipSalariesAndHeads($requestData)
    {
        $userIds = $requestData['user_id'];
        $year = $requestData['year'];
        $month = $requestData['month'];

        DB::beginTransaction();
        try {
            foreach ($userIds as $userId) {
                $existingPayslipSalary = $this->getPayslipSalary(intval($userId), $year, $month);
                if ($existingPayslipSalary) {
                    continue;
                }

                if (isset($requestData['payroll_heads'][$userId])) {
                    $salaryHeadsData = $requestData['payroll_heads'][$userId];
                    foreach ($salaryHeadsData as $id => $salaryHeads) {
                        foreach ($salaryHeads as $salaryHeadId => $salaryHeadAmount) {
                            $payslipSalaryHeadData = [
                                'user_payroll_id' => intval($id),
                                'salary_head_id' => $salaryHeadId,
                                'amount' => $salaryHeadAmount,
                            ];

                            $this->payslipSalaryHeadService->createPayslipSalaryHead($payslipSalaryHeadData);
                        }

                        $payslipSalary = new PayslipSalary;
                        $payslipSalary->user_id = intval($userId);
                        $payslipSalary->year = $year;
                        $payslipSalary->month = $month;

                        if ($payslipSalary->save()) {
                            $payslipInvoiceData = [
                                'invoice_id' => $payslipSalary->id.rand(100000, 999999),
                                'payslip_salary_id' => $payslipSalary->id,
                                'created_at' => now(),
                            ];

                            $this->payslipInvoiceService->createPayslipInvoice($payslipInvoiceData);
                        }
                    }
                }
            }

            DB::commit();

            return ['success' => true, 'message' => 'Salary create successfully.'];
        } catch (\Exception $e) {
            DB::rollback();

            return ['error' => true, 'message' => 'Salary create unsuccessfully'];
        }
    }

    public function createPayslipSalariesAndHeadsAPI($requestData)
    {
        $users = $requestData['users'];
        $year = $requestData['year'];
        $month = $requestData['month'];

        DB::beginTransaction();
        try {
            foreach ($users as $user) {
                $userId = intval($user['user_id']);

                // Check if payslip salary already exists for the user, year, and month
                $existingPayslipSalary = $this->getPayslipSalary($userId, $year, $month);
                if ($existingPayslipSalary) {
                    continue;
                }

                // Process salary heads for the user
                if (isset($user['salary_heads']) && is_array($user['salary_heads'])) {
                    // Create PayslipSalary record
                    $payslipSalary = new PayslipSalary;
                    $payslipSalary->user_id = $userId;
                    $payslipSalary->year = $year;
                    $payslipSalary->month = $month;

                    if ($payslipSalary->save()) {
                        // Save each salary head
                        foreach ($user['salary_heads'] as $salaryHead) {
                            $payslipSalaryHeadData = [
                                'user_payroll_id' => $payslipSalary->id,
                                'salary_head_id' => intval($salaryHead['salary_head_id']),
                                'amount' => floatval($salaryHead['amount']),
                            ];

                            $this->payslipSalaryHeadService->createPayslipSalaryHead($payslipSalaryHeadData);
                        }

                        // Create PayslipInvoice record
                        $payslipInvoiceData = [
                            'invoice_id' => $payslipSalary->id.rand(100000, 999999),
                            'payslip_salary_id' => $payslipSalary->id,
                            'created_at' => now(),
                        ];

                        $this->payslipInvoiceService->createPayslipInvoice($payslipInvoiceData);
                    }
                }
            }

            DB::commit();

            return ['success' => true, 'message' => 'Salary created successfully.'];
        } catch (\Exception $e) {
            DB::rollback();

            return ['error' => true, 'message' => 'Salary creation failed.'];
        }
    }

    // public function createPayslipSalariesAndHeadsAPI($requestData)
    // {
    //     $userIds = $requestData['user_id'];
    //     $year = $requestData['year'];
    //     $month = $requestData['month'];

    //     DB::beginTransaction();
    //     try {
    //         foreach ($userIds as $userId) {
    //             $existingPayslipSalary = $this->getPayslipSalary(intval($userId), $year, $month);
    //             if ($existingPayslipSalary) {
    //                 continue;
    //             }

    //             if (isset($requestData['payroll_heads'][$userId])) {
    //                 $salaryHeadsData = $requestData['payroll_heads'][$userId];
    //                 foreach ($salaryHeadsData as $id => $salaryHeads) {
    //                     foreach ($salaryHeads as $salaryHeadId => $salaryHeadAmount) {
    //                         $payslipSalaryHeadData = [
    //                             'user_payroll_id' => intval($id),
    //                             'salary_head_id' => $salaryHeadId,
    //                             'amount' => $salaryHeadAmount,
    //                         ];

    //                         $this->payslipSalaryHeadService->createPayslipSalaryHead($payslipSalaryHeadData);
    //                     }

    //                     $payslipSalary = new PayslipSalary;
    //                     $payslipSalary->user_id = intval($userId);
    //                     $payslipSalary->year = $year;
    //                     $payslipSalary->month = $month;

    //                     if ($payslipSalary->save()) {
    //                         $payslipInvoiceData = [
    //                             'invoice_id' => $payslipSalary->id . rand(100000, 999999),
    //                             'payslip_salary_id' => $payslipSalary->id,
    //                             'created_at' => now(),
    //                         ];

    //                         $this->payslipInvoiceService->createPayslipInvoice($payslipInvoiceData);
    //                     }
    //                 }
    //             }
    //         }

    //         DB::commit();

    //         return ['success' => true, 'message' => 'Salary create successfully.'];
    //     } catch (\Exception $e) {
    //         DB::rollback();

    //         return ['error' => true, 'message' => 'Salary create unsuccessfully'];
    //     }
    // }

    public function getPayslipSalary(int $userId, $year, $month)
    {
        return PayslipSalary::where([
            'user_id' => intval($userId),
            'year' => $year,
            'month' => $month,
        ])->first();
    }
}
