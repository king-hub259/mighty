<?php

namespace Modules\Authentication\Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class UtilitySeeder extends Seeder
{
    public function run()
    {
        // Default s_a_a_s_settings
        DB::table('s_a_a_s_settings')->insert([
            [
                'type' => 'general',
                'name' => 'site_name',
                'value' => 'SAAS Site',
            ],
            [
                'type' => 'general',
                'name' => 'site_title',
                'value' => 'SAAS Title',
            ],
            [
                'type' => 'general',
                'name' => 'phone',
                'value' => '',
            ],
            [
                'type' => 'general',
                'name' => 'office_phone',
                'value' => '',
            ],
            [
                'type' => 'general',
                'name' => 'email',
                'value' => '',
            ],
            [
                'type' => 'general',
                'name' => 'language',
                'value' => 'en',
            ],
            [
                'type' => 'general',
                'name' => 'google_map',
                'value' => '',
            ],
            [
                'type' => 'general',
                'name' => 'address',
                'value' => '',
            ],
            [
                'type' => 'general',
                'name' => 'on_google_map',
                'value' => '',
            ],
            [
                'type' => 'general',
                'name' => 'currency_symbol',
                'value' => '$',
            ],
            [
                'type' => 'general',
                'name' => 'logo',
                'value' => 'logo.png',
            ],
            [
                'type' => 'general',
                'name' => 'disabled_website',
                'value' => 'no',
            ],
            [
                'type' => 'general',
                'name' => 'copyright_text',
                'value' => '&copy; Copyright 2025. All Rights Reserved by FueDevs LTD',
            ],
            [
                'type' => 'general',
                'name' => 'facebook_link',
                'value' => 'https://www.facebook.com/',
            ],
            [
                'type' => 'general',
                'name' => 'google_plus_link',
                'value' => 'https://www.google.com/',
            ],
            [
                'type' => 'general',
                'name' => 'youtube_link',
                'value' => 'https://www.youtube.com/',
            ],
            [
                'type' => 'general',
                'name' => 'whats_app_link',
                'value' => '',
            ],
            [
                'type' => 'general',
                'name' => 'twitter_link',
                'value' => 'https://www.twitter.com',
            ],
            [
                'type' => 'general',
                'name' => 'header_notice',
                'value' => '',
            ],
            [
                'type' => 'general',
                'name' => 'app_version',
                'value' => '1.0.0',
            ],
            [
                'type' => 'general',
                'name' => 'app_url',
                'value' => 'drive-link',
            ],
        ]);

        // Default s_a_a_s_settings
        DB::table('s_a_a_s_settings')->insert([
            // Payment Gateway
            // [
            //     'type' => 'payment_config',
            //     'mode' => 'test',
            //     'status' => '0',
            //     'name' => 'bkash',
            //     'payment_info' => json_encode([
            //         'app_key' => '',
            //         'app_secret' => '',
            //         'username' => 'sandboxTokenizedUser02',
            //         'password' => 'sandboxTokenizedUser02@12345',
            //     ]),
            // ],
            [
                'type' => 'payment_config',
                'mode' => 'test',
                'status' => '0',
                'name' => 'paystack',
                'payment_info' => json_encode([
                    'public_key' => '',
                    'secret_key' => '',
                    'merchant_email' => '',
                    'callback_url' => 'https:\/\/api.paystack.co',
                ]),
            ],
            [
                'type' => 'payment_config',
                'mode' => 'test',
                'status' => '0',
                'name' => 'razor_pay',
                'payment_info' => json_encode([
                    'api_key' => '',
                    'api_secret' => '',
                ]),
            ],
            [
                'type' => 'payment_config',
                'mode' => 'test',
                'status' => '0',
                'name' => 'stripe',
                'payment_info' => json_encode([
                    'published_key' => '',
                    'api_key' => '',
                    'mode' => 'test',
                    'other_config_key' => 'test_value',
                ]),
            ],
            [
                'type' => 'payment_config',
                'mode' => 'test',
                'status' => '0',
                'name' => 'ssl_commerz',
                'payment_info' => json_encode([
                    'store_id' => '',
                    'store_password' => '',
                ]),
            ],
            [
                'type' => 'payment_config',
                'mode' => 'test',
                'status' => '0',
                'name' => 'pvit',
                'payment_info' => json_encode([
                    'mc_tel_merchant' => '',
                    'access_token' => '',
                    'mc_merchant_code' => 'RA5118',
                ]),
            ],
            [
                'type' => 'payment_config',
                'mode' => 'test',
                'status' => '0',
                'name' => 'paypal',
                'payment_info' => json_encode([
                    'client_id' => '',
                    'client_secret' => '',
                ]),
            ],
            [
                'type' => 'payment_config',
                'mode' => 'test',
                'status' => '0',
                'name' => 'paymob_accept',
                'payment_info' => json_encode([
                    'api_key' => '',
                    'integration_id' => '',
                    'iframe_id' => '',
                    'hmac_secret' => '',
                    'supported_country' => 'EG',
                ]),
            ],
            [
                'type' => 'payment_config',
                'mode' => 'test',
                'status' => '0',
                'name' => 'flutterwave',
                'payment_info' => json_encode([
                    'public_key' => '',
                    'secret_key' => '',
                    'encryption_key' => '',
                ]),
            ],
            [
                'type' => 'payment_config',
                'mode' => 'test',
                'status' => '0',
                'name' => 'senang_pay',
                'payment_info' => json_encode([
                    'merchant_id' => '',
                    'secret_key' => '',
                ]),
            ],
            [
                'type' => 'payment_config',
                'mode' => 'test',
                'status' => '0',
                'name' => 'paytm',
                'payment_info' => json_encode([
                    'merchant_id' => '',
                    'merchant_key' => '',
                    'merchant_website_link' => '',
                    'refund_url' => 'https://securegw-stage.paytm.in/refund/apply',
                ]),
            ],
        ]);

        // Default Settings
        DB::table('settings')->insert([
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'type' => 'general',
                'name' => 'school_name',
                'value' => 'Demo Collage',
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'type' => 'general',
                'name' => 'site_title',
                'value' => 'Demo Title',
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'type' => 'general',
                'name' => 'phone',
                'value' => '',
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'type' => 'general',
                'name' => 'email',
                'value' => '',
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'type' => 'general',
                'name' => 'language',
                'value' => 'en',
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'type' => 'general',
                'name' => 'google_map',
                'value' => '',
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'type' => 'general',
                'name' => 'address',
                'value' => '',
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'type' => 'general',
                'name' => 'on_google_map',
                'value' => '',
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'type' => 'general',
                'name' => 'institute_code',
                'value' => '',
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'type' => 'general',
                'name' => 'timezone',
                'value' => 'Asia/Dhaka',
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'type' => 'general',
                'name' => 'academic_year',
                'value' => '1',
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'type' => 'general',
                'name' => 'currency_symbol',
                'value' => '$',
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'type' => 'general',
                'name' => 'mail_type',
                'value' => 'mail',
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'type' => 'general',
                'name' => 'logo',
                'value' => 'logo.png',
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'type' => 'general',
                'name' => 'disabled_website',
                'value' => 'no',
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'type' => 'general',
                'name' => 'copyright_text',
                'value' => '&copy; Copyright 2025. All Rights Reserved by FueDevs LTD',
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'type' => 'general',
                'name' => 'exam_result_phone',
                'value' => '',
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'type' => 'general',
                'name' => 'tuition_fee_phone',
                'value' => '',
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'type' => 'general',
                'name' => 'facebook_link',
                'value' => 'https://www.facebook.com/',
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'type' => 'general',
                'name' => 'google_plus_link',
                'value' => 'https://www.google.com/',
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'type' => 'general',
                'name' => 'youtube_link',
                'value' => 'https://www.youtube.com/',
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'type' => 'general',
                'name' => 'whats_app_link',
                'value' => '',
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'type' => 'general',
                'name' => 'twitter_link',
                'value' => 'https://www.twitter.com',
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'type' => 'general',
                'name' => 'eiin_code',
                'value' => '',
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'type' => 'general',
                'name' => 'sms_gateway',
                'value' => 'twilio',
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'type' => 'general',
                'name' => 'bulk_sms_api_key',
                'value' => '',
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'type' => 'general',
                'name' => 'bulk_sms_sender_id',
                'value' => '',
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'type' => 'general',
                'name' => 'twilio_sid',
                'value' => '',
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'type' => 'general',
                'name' => 'twilio_token',
                'value' => '',
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'type' => 'general',
                'name' => 'twilio_from_number',
                'value' => '',
            ],

            [
                'institute_id' => 1,
                'branch_id' => 1,
                'type' => 'general',
                'name' => 'zoom_account_id',
                'value' => '',
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'type' => 'general',
                'name' => 'zoom_client_key',
                'value' => '',
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'type' => 'general',
                'name' => 'zoom_client_secret',
                'value' => '',
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'type' => 'general',
                'name' => 'header_notice',
                'value' => '',
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'type' => 'general',
                'name' => 'exam_result_status',
                'value' => 'no',
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'type' => 'general',
                'name' => 'admission_display_status',
                'value' => 'no',
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'type' => 'general',
                'name' => 'tc_amount',
                'value' => 00,
            ],
        ]);

        // Default Settings
        DB::table('settings')->insert([
            // Payment Gateway
            // [
            //     'institute_id' => 1,
            //     'branch_id' => 1,
            //     'type' => 'payment_config',
            //     'mode' => 'test',
            //     'status' => '0',
            //     'name' => 'bkash',
            //     'payment_info' => json_encode([
            //         'app_key' => '',
            //         'app_secret' => '',
            //         'username' => '',
            //         'password' => '',
            //     ]),
            // ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'type' => 'payment_config',
                'mode' => 'test',
                'status' => '0',
                'name' => 'paystack',
                'payment_info' => json_encode([
                    'public_key' => '',
                    'secret_key' => '',
                    'merchant_email' => '',
                    'callback_url' => 'https:\/\/api.paystack.co',
                ]),
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'type' => 'payment_config',
                'mode' => 'test',
                'status' => '0',
                'name' => 'razor_pay',
                'payment_info' => json_encode([
                    'api_key' => '',
                    'api_secret' => '',
                ]),
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'type' => 'payment_config',
                'mode' => 'test',
                'status' => '0',
                'name' => 'stripe',
                'payment_info' => json_encode([
                    'published_key' => '',
                    'api_key' => '',
                    'mode' => '',
                    'other_config_key' => '',
                ]),
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'type' => 'payment_config',
                'mode' => 'test',
                'status' => '0',
                'name' => 'ssl_commerz',
                'payment_info' => json_encode([
                    'store_id' => '',
                    'store_password' => '',
                ]),
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'type' => 'payment_config',
                'mode' => 'test',
                'status' => '0',
                'name' => 'pvit',
                'payment_info' => json_encode([
                    'mc_tel_merchant' => '',
                    'access_token' => '',
                    'mc_merchant_code' => '',
                ]),
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'type' => 'payment_config',
                'mode' => 'test',
                'status' => '0',
                'name' => 'paypal',
                'payment_info' => json_encode([
                    'client_id' => '',
                    'client_secret' => '',
                ]),
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'type' => 'payment_config',
                'mode' => 'test',
                'status' => '0',
                'name' => 'paymob_accept',
                'payment_info' => json_encode([
                    'api_key' => '',
                    'integration_id' => '',
                    'iframe_id' => '',
                    'hmac_secret' => '',
                    'supported_country' => 'EG',
                ]),
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'type' => 'payment_config',
                'mode' => 'test',
                'status' => '0',
                'name' => 'flutterwave',
                'payment_info' => json_encode([
                    'public_key' => '',
                    'secret_key' => '',
                    'encryption_key' => '',
                ]),
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'type' => 'payment_config',
                'mode' => 'test',
                'status' => '0',
                'name' => 'senang_pay',
                'payment_info' => json_encode([
                    'merchant_id' => '',
                    'secret_key' => '',
                ]),
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'type' => 'payment_config',
                'mode' => 'test',
                'status' => '0',
                'name' => 'paytm',
                'payment_info' => json_encode([
                    'merchant_id' => '',
                    'merchant_key' => '',
                    'merchant_website_link' => '',
                    'refund_url' => 'https://securegw-stage.paytm.in/refund/apply',
                ]),
            ],
        ]);

        $days = [
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'day' => 'SATURDAY',
                'is_active' => 1,
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'day' => 'SUNDAY',
                'is_active' => 1,
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'day' => 'MONDAY',
                'is_active' => 1,
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'day' => 'TUESDAY',
                'is_active' => 1,
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'day' => 'WEDNESDAY',
                'is_active' => 1,
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'day' => 'THURSDAY',
                'is_active' => 1,
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'day' => 'FRIDAY',
                'is_active' => 1,
            ],
        ];
        DB::table('class_days')->insert($days);

        $academicYears = [
            [
                'id' => 1,
                'session' => 2024,
                'year' => 2024 . '-' . 2025,
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'id' => 2,
                'session' => 2025,
                'year' => 2025 . '-' . 2026,
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'id' => 3,
                'session' => 2026,
                'year' => 2026 . '-' . 2027,
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'id' => 4,
                'session' => 2027,
                'year' => 2027 . '-' . 2028,
                'created_at' => now(),
                'updated_at' => now(),
            ],
        ];
        DB::table('academic_years')->insert($academicYears);

        // Payroll Accounting Mappings
        DB::table('payroll_accounting_mappings')->insert([
            'ledger_id' => 56,
            'fund_id' => 1,
        ]);
    }
}
