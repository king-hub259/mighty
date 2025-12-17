<?php

namespace App\Imports;

use Illuminate\Support\Collection;
use Maatwebsite\Excel\Concerns\ToCollection;
use Maatwebsite\Excel\Concerns\WithHeadingRow;

class StudentsImport implements ToCollection, WithHeadingRow
{
    public $data = [];

    public function collection(Collection $rows)
    {
        foreach ($rows as $row) {
            if (
                $row['roll_no'] ||
                $row['name'] ||
                $row['email'] ||
                $row['phone'] ||
                $row['password'] ||
                $row['gender'] ||
                $row['religion'] ||
                $row['fathers_name'] ||
                $row['mothers_name']
            ) {
                $this->data[] = [
                    'roll_no' => $row['roll_no'],
                    'name' => $row['name'],
                    'email' => $row['email'],
                    'phone' => $row['phone'],
                    'password' => $row['password'],
                    'gender' => $row['gender'],
                    'religion' => $row['religion'],
                    'fathers_name' => $row['fathers_name'],
                    'mothers_name' => $row['mothers_name'],
                ];
            }
        }
    }
}
