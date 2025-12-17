<?php

namespace Modules\SMS\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Carbon\Carbon;
use Exception;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Modules\Academic\Models\SmsLog;
use Modules\Academic\Services\UserService;

class SmsController extends Controller
{
    public function __construct(
        private readonly UserService $userService
    ) {}

    public function sentSMSReport(Request $request): JsonResponse
    {
        $perPage = (int) $request->per_page ?: 10;

        try {
            // Parse date filters
            $fromDate = $request->from ? Carbon::parse($request->from)->startOfDay() : null;
            $toDate = $request->to ? Carbon::parse($request->to)->endOfDay() : null;

            $smsReportsQuery = SmsLog::where('status', 1);

            // Apply date filters if provided
            if ($fromDate && $toDate) {
                $smsReportsQuery->whereBetween('created_at', [$fromDate, $toDate]);
            }

            // Add user relationship
            $smsReportsQuery->with('user');

            // Apply pagination
            $smsReports = $smsReportsQuery->orderBy('id', 'DESC')->paginate($perPage);

            return $this->responseSuccess($smsReports, 'SMS Reports have been fetched successfully.');
        } catch (Exception $exception) {
            return $this->responseError(
                [],
                $exception->getMessage(),
                $exception->getCode() ?: 500
            );
        }
    }

    public function get_users(Request $request): JsonResponse
    {
        $request->validate([
            'user_type' => 'required|string|in:Student,Teacher,Staff,Admin,Parent',
        ]);

        $userType = $request->user_type;

        if (! $userType) {
            return $this->responseError([], _lang('Something went wrong. User not found.'));
        }

        $users = $this->userService->getUsersByExistType($userType);

        return $this->responseSuccess($users, 'Users fetch successfully.');
    }

    public function send(Request $request): JsonResponse
    {
        @ini_set('max_execution_time', 0);
        @set_time_limit(0);

        $smsType = get_option('sms_type');
        $body = strip_tags($request->body);
        $length = $this->calculateSmsLength($body);

        try {
            if ($request->users != '') {
                foreach ($request->users as $user_id => $mobile_number) {
                    $log = new SmsLog;
                    $log->institute_id = get_institute_id();
                    $log->branch_id = get_branch_id();
                    $log->receiver = $mobile_number;
                    $log->message = $body;
                    $log->user_id = $user_id ?? 0;
                    $log->user_type = $request->user_type;
                    $log->sender_id = Auth::user()->id;
                    $log->status = 0;
                    $log->save();
                }
            } elseif ($request->individual_number != '') {
                $log = new SmsLog;
                $log->institute_id = get_institute_id();
                $log->branch_id = get_branch_id();
                $log->receiver = $request->individual_number;
                $log->message = $body;
                $log->user_id = $user_id ?? 0;
                $log->user_type = 'Individual';
                $log->sender_id = Auth::user()->id;
                $log->status = 0;
                $log->save();
            } else {
                return $this->responseError([], _lang('Invalid mobile number Or Illegal Operation.'));
            }

            return $this->responseSuccess([], 'Message Send Successfully.');
        } catch (Exception $e) {
            return $this->responseError([], $e->getMessage());
        }
    }

    public function calculateSmsLength($message)
    {
        // Count the number of characters in the message
        $messageLength = strlen($message);

        // Check if the message length is within the SMS limit
        if ($messageLength <= 160) {
            // The message fits in a single SMS
            return 1;
        } else {
            // The message needs to be split into multiple SMS messages
            $numberOfSms = ceil($messageLength / 160);

            return $numberOfSms;
        }
    }
}
