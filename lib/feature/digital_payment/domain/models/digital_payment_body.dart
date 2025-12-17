class DigitalPaymentBody {
  String? paymentMethod;
  String? paymentType;
  double? amount;
  String? currency;
  String? name;
  String? phone;
  String? email;
  String? planId;
  String? paymentPlatform;
  String? externalRedirectLink;
  String? successHook;
  String? failureHook;

  DigitalPaymentBody(
      {this.paymentMethod,
        this.paymentType,
        this.amount,
        this.currency,
        this.name,
        this.phone,
        this.email,
        this.planId,
        this.paymentPlatform,
        this.externalRedirectLink,
        this.successHook,
        this.failureHook});

  DigitalPaymentBody.fromJson(Map<String, dynamic> json) {
    paymentMethod = json['payment_method'];
    paymentType = json['payment_type'];
    amount = json['amount'];
    currency = json['currency'];
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    planId = json['plan_id'];
    paymentPlatform = json['payment_platform'];
    externalRedirectLink = json['external_redirect_link'];
    successHook = json['success_hook'];
    failureHook = json['failure_hook'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['payment_method'] = paymentMethod;
    data['payment_type'] = paymentType;
    data['amount'] = amount;
    data['currency'] = currency;
    data['name'] = name;
    data['phone'] = phone;
    data['email'] = email;
    data['plan_id'] = planId;
    data['payment_platform'] = paymentPlatform;
    data['external_redirect_link'] = externalRedirectLink;
    data['success_hook'] = successHook;
    data['failure_hook'] = failureHook;
    return data;
  }
}
