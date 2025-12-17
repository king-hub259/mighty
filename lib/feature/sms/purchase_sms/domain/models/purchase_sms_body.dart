class PurchaseSmsBody {
  String? noOfSms;
  String? amount;
  String? transactionDate;
  String? maskingType;
  String? smsGateway;

  PurchaseSmsBody(
      {this.noOfSms,
        this.amount,
        this.transactionDate,
        this.maskingType,
        this.smsGateway});

  PurchaseSmsBody.fromJson(Map<String, dynamic> json) {
    noOfSms = json['no_of_sms'];
    amount = json['amount'];
    transactionDate = json['transaction_date'];
    maskingType = json['masking_type'];
    smsGateway = json['sms_gateway'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['no_of_sms'] = noOfSms;
    data['amount'] = amount;
    data['transaction_date'] = transactionDate;
    data['masking_type'] = maskingType;
    data['sms_gateway'] = smsGateway;
    return data;
  }
}
