<?php

namespace App\Imports;

use Illuminate\Support\Collection;
use Maatwebsite\Excel\Concerns\ToCollection;
use Maatwebsite\Excel\Concerns\WithHeadingRow;

class ExamImport implements ToCollection, WithHeadingRow
{
    public $data = [];

    public function collection(Collection $rows)
    {
        foreach ($rows as $row) {
            if (
                isset($row['student_roll']) && $row['student_roll']
            ) {
                $this->data[] = [
                    'student_roll' => $this->convertToUTF8($row['student_roll']),
                ];
            }
        }
    }

    protected function convertToUTF8($value)
    {
        return mb_convert_encoding($value, 'UTF-8', 'auto');
    }
}
