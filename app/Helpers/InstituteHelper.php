<?php

namespace App\Helpers;

use Illuminate\Support\Facades\DB;

class InstituteHelper
{
    /**
     * Get institute ID based on the domain.
     *
     * @return mixed
     */
    public static function getInstituteIdByDomain(string $domain)
    {
        // Check if domain is provided
        if (empty($domain)) {
            return [
                'error' => 'Domain is required.',
                'status' => false,
            ];
        }

        // Check if domain format is valid (e.g., example.com)
        if (! filter_var($domain, FILTER_VALIDATE_DOMAIN, FILTER_FLAG_HOSTNAME)) {
            return [
                'error' => 'Invalid domain format.',
                'status' => false,
            ];
        }

        // Fetch the institute based on the domain
        $institute = DB::table('institutes')
            ->where('domain', $domain)
            ->select('id')
            ->first();

        // If no matching institute is found
        if (! $institute) {
            return [
                'error' => 'Institute not found for the provided domain.',
                'status' => false,
            ];
        }

        // Return the institute ID
        return [
            'institute_id' => $institute->id,
            'status' => true,
        ];
    }
}
