<?php

namespace Modules\Accounting\Database\Seeders;

use Illuminate\Database\Seeder;
use Modules\Accounting\Models\AccountingLedger;

class AccountingLedgerTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $ledgers = [
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'accounting_category_id' => 1,
                'accounting_group_id' => 1,
                'ledger_name' => 'Cash',
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'accounting_category_id' => 1,
                'accounting_group_id' => 2,
                'ledger_name' => 'Digital Payment',
            ],
            // Liabilities
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'accounting_category_id' => 2,
                'accounting_group_id' => 3,
                'ledger_name' => 'Accounts Payable',
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'accounting_category_id' => 2,
                'accounting_group_id' => 3,
                'ledger_name' => 'Tuition Fee Refund',
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'accounting_category_id' => 3,
                'accounting_group_id' => 4,
                'ledger_name' => 'Director`s Loan ',
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'accounting_category_id' => 4,
                'accounting_group_id' => 5,
                'ledger_name' => 'Opening Balance Equity',
            ],

            // Fees Related Income -> Income From Fees
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'accounting_category_id' => 5,
                'accounting_group_id' => 6,
                'ledger_name' => 'Admission Fees Collection',
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'accounting_category_id' => 5,
                'accounting_group_id' => 6,
                'ledger_name' => 'Board Fees Collection',
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'accounting_category_id' => 5,
                'accounting_group_id' => 6,
                'ledger_name' => 'Dairy And Syllabuss Collection',
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'accounting_category_id' => 5,
                'accounting_group_id' => 6,
                'ledger_name' => 'Exam Fees Collection',
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'accounting_category_id' => 5,
                'accounting_group_id' => 6,
                'ledger_name' => 'Fee Collections Collection',
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'accounting_category_id' => 5,
                'accounting_group_id' => 6,
                'ledger_name' => 'Session Charge Collection',
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'accounting_category_id' => 5,
                'accounting_group_id' => 6,
                'ledger_name' => 'Study Materials Fees Collection',
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'accounting_category_id' => 5,
                'accounting_group_id' => 6,
                'ledger_name' => 'TC Fees Collection',
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'accounting_category_id' => 5,
                'accounting_group_id' => 6,
                'ledger_name' => 'Testimonial Fees Collection',
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'accounting_category_id' => 5,
                'accounting_group_id' => 6,
                'ledger_name' => 'Tie And Id Card Collection',
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'accounting_category_id' => 5,
                'accounting_group_id' => 6,
                'ledger_name' => 'Tuition Fees Collection',
            ],

            // Fees Related Income -> Income From Fine
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'accounting_category_id' => 5,
                'accounting_group_id' => 7,
                'ledger_name' => 'Attendance Fine',
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'accounting_category_id' => 5,
                'accounting_group_id' => 7,
                'ledger_name' => 'Quiz Fine',
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'accounting_category_id' => 5,
                'accounting_group_id' => 7,
                'ledger_name' => 'Lab Fine',
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'accounting_category_id' => 5,
                'accounting_group_id' => 7,
                'ledger_name' => 'Tuition Fee Fin',
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'accounting_category_id' => 5,
                'accounting_group_id' => 7,
                'ledger_name' => 'Late Fine',
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'accounting_category_id' => 5,
                'accounting_group_id' => 7,
                'ledger_name' => 'Attendance Make up Fine',
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'accounting_category_id' => 5,
                'accounting_group_id' => 7,
                'ledger_name' => 'Laboratories Class Fine',
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'accounting_category_id' => 5,
                'accounting_group_id' => 7,
                'ledger_name' => 'ID Card Fine',
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'accounting_category_id' => 5,
                'accounting_group_id' => 7,
                'ledger_name' => 'Discipline Fine',
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'accounting_category_id' => 5,
                'accounting_group_id' => 7,
                'ledger_name' => 'Library Fine',
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'accounting_category_id' => 5,
                'accounting_group_id' => 7,
                'ledger_name' => 'Miscellaneous Fine',
            ],

            // Others Income
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'accounting_category_id' => 6,
                'accounting_group_id' => 8,
                'ledger_name' => 'House Rent(Cr)',
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'accounting_category_id' => 6,
                'accounting_group_id' => 9,
                'ledger_name' => 'Old Paper Sells',
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'accounting_category_id' => 6,
                'accounting_group_id' => 10,
                'ledger_name' => 'Online Apply Fee',
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'accounting_category_id' => 6,
                'accounting_group_id' => 11,
                'ledger_name' => 'Opening Balance',
            ],

            // General Expenses
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'accounting_category_id' => 7,
                'accounting_group_id' => 12,
                'ledger_name' => 'Advertisement',
            ],

            [
                'institute_id' => 1,
                'branch_id' => 1,
                'accounting_category_id' => 7,
                'accounting_group_id' => 13,
                'ledger_name' => 'Anual Sports',
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'accounting_category_id' => 7,
                'accounting_group_id' => 13,
                'ledger_name' => 'National Day &amp; Fastival Expanse',
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'accounting_category_id' => 7,
                'accounting_group_id' => 13,
                'ledger_name' => 'Ocation',
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'accounting_category_id' => 7,
                'accounting_group_id' => 13,
                'ledger_name' => 'Study Tour',
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'accounting_category_id' => 7,
                'accounting_group_id' => 14,
                'ledger_name' => 'Bank Charges',
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'accounting_category_id' => 7,
                'accounting_group_id' => 15,
                'ledger_name' => 'Board Fee',
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'accounting_category_id' => 7,
                'accounting_group_id' => 15,
                'ledger_name' => 'Miscellaneous Exp.',
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'accounting_category_id' => 7,
                'accounting_group_id' => 15,
                'ledger_name' => 'Office Expense',
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'accounting_category_id' => 7,
                'accounting_group_id' => 16,
                'ledger_name' => 'Conveyance Expenses',
            ],

            // 17
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'accounting_category_id' => 7,
                'accounting_group_id' => 17,
                'ledger_name' => 'Electricity Bill',
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'accounting_category_id' => 7,
                'accounting_group_id' => 17,
                'ledger_name' => 'Internet Bill',
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'accounting_category_id' => 7,
                'accounting_group_id' => 17,
                'ledger_name' => 'Mobile Recharge Exp.',
            ],

            // 18
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'accounting_category_id' => 7,
                'accounting_group_id' => 18,
                'ledger_name' => 'Entertainment Exp.',
            ],

            // 19
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'accounting_category_id' => 7,
                'accounting_group_id' => 19,
                'ledger_name' => 'Exam Centre Fee',
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'accounting_category_id' => 7,
                'accounting_group_id' => 19,
                'ledger_name' => 'Exam Expenses',
            ],

            // 20
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'accounting_category_id' => 7,
                'accounting_group_id' => 20,
                'ledger_name' => 'House Rent',
            ],

            // 21
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'accounting_category_id' => 7,
                'accounting_group_id' => 21,
                'ledger_name' => 'Netizen Bill Payment',
            ],

            // 22
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'accounting_category_id' => 7,
                'accounting_group_id' => 22,
                'ledger_name' => 'Office Stationary',
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'accounting_category_id' => 7,
                'accounting_group_id' => 22,
                'ledger_name' => 'Printing & Stationary Expense',
            ],

            // 23
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'accounting_category_id' => 7,
                'accounting_group_id' => 23,
                'ledger_name' => 'Repair Expenses',
            ],

            // 24
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'accounting_category_id' => 7,
                'accounting_group_id' => 24,
                'ledger_name' => 'Salary & Honorarium (Bank Payment)',
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'accounting_category_id' => 7,
                'accounting_group_id' => 24,
                'ledger_name' => 'Salary & Honorarium (Cash Payment)',
            ],
        ];

        AccountingLedger::insert($ledgers);
    }
}
