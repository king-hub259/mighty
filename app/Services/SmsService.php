<?php

namespace App\Services;

use Exception;
use GuzzleHttp\Client;
use Twilio\Rest\Client as TwilioClient;

class SmsService
{
    protected $gateway;

    protected $apiKey;

    protected $senderId;

    protected $twilioSid;

    protected $twilioToken;

    protected $twilioNumber;

    public function __construct()
    {
        // Fetch settings from the database
        $this->gateway = get_option('sms_gateway'); // 'twilio' or 'bulksmsbd'
        $this->apiKey = get_option('bulk_sms_api_key');
        $this->senderId = get_option('bulk_sms_sender_id');
        $this->twilioSid = get_option('twilio_sid');
        $this->twilioToken = get_option('twilio_token');
        $this->twilioNumber = get_option('twilio_from_number');
    }

    public function sendSMS($receiverNumber, $message)
    {
        if ($this->gateway == 'twilio') {
            return $this->sendViaTwilio($receiverNumber, $message);
        } elseif ($this->gateway == 'bulksmsbd') {
            return $this->sendViaBulkSmsBD($receiverNumber, $message);
        }

        return ['success' => false, 'error' => 'Invalid SMS Gateway'];
    }

    private function sendViaTwilio($receiverNumber, $message)
    {
        try {
            $client = new TwilioClient($this->twilioSid, $this->twilioToken);
            $client->messages->create($receiverNumber, [
                'from' => $this->twilioNumber,
                'body' => $message,
            ]);

            return ['success' => true, 'message' => 'SMS Sent via Twilio Successfully.'];
        } catch (Exception $e) {
            return ['success' => false, 'error' => $e->getMessage()];
        }
    }

    private function sendViaBulkSmsBD($receiverNumber, $message)
    {
        try {
            $client = new Client;
            $url = "http://bulksmsbd.net/api/smsapi?api_key={$this->apiKey}&type=text&number={$receiverNumber}&senderid={$this->senderId}&message=".urlencode($message);
            $response = $client->get($url);
            $responseData = json_decode($response->getBody(), true);

            if ($responseData['response_code'] == 202) {
                return ['success' => true, 'message' => 'SMS Sent via BulkSMSBD Successfully.'];
            } else {
                return ['success' => false, 'error' => $responseData['error_message']];
            }
        } catch (Exception $e) {
            return ['success' => false, 'error' => $e->getMessage()];
        }
    }
}
