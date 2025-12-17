<?php

namespace App\Imports;

use Illuminate\Support\Collection;
use Maatwebsite\Excel\Concerns\ToCollection;
use Maatwebsite\Excel\Concerns\WithHeadingRow;

class TeachersImport implements ToCollection, WithHeadingRow
{
    public $data = [];

    public function collection(Collection $rows)
    {
        foreach ($rows as $row) {
            if (
                $row['roll_no'] ||
                $row['name'] ||
                $row['gender'] ||
                $row['religion'] ||
                $row['phone']
            ) {
                $this->data[] = [
                    'roll_no' => $row['roll_no'],
                    'name' => $row['name'],
                    'gender' => $row['gender'],
                    'religion' => $row['religion'],
                    'phone' => $row['phone'],
                ];
            }
        }
    }
}
