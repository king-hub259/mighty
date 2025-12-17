class SaasPaymentGatewayModel {
  bool? status;
  String? message;
  List<PaymentGatewayItem>? data;

  SaasPaymentGatewayModel({this.status, this.message, this.data});

  SaasPaymentGatewayModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <PaymentGatewayItem>[];
      json['data'].forEach((v) {
        data!.add(PaymentGatewayItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PaymentGatewayItem {
  int? id;
  String? name;
  PaymentInfo? paymentInfo;
  String? type;
  String? mode;
  String? status;

  PaymentGatewayItem(
      {this.id,
        this.name,
        this.paymentInfo,
        this.type,
        this.mode,
        this.status});

  PaymentGatewayItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    paymentInfo = json['payment_info'] != null ? PaymentInfo.fromJson(json['payment_info']) : null;
    type = json['type'];
    mode = json['mode'];
    status = json['status'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    if (paymentInfo != null) {
      data['payment_info'] = paymentInfo!.toJson();
    }
    data['type'] = type;
    data['mode'] = mode;
    data['status'] = status;
    return data;
  }
}

class PaymentInfo {
  String? appKey;
  String? appSecret;
  String? username;
  String? password;
  String? publicKey;
  String? secretKey;
  String? merchantEmail;
  String? callbackUrl;
  String? apiKey;
  String? apiSecret;
  String? publishedKey;
  String? mode;
  String? otherConfigKey;
  String? storeId;
  String? storePassword;
  String? mcTelMerchant;
  String? accessToken;
  String? mcMerchantCode;
  String? clientId;
  String? clientSecret;
  String? integrationId;
  String? iframeId;
  String? hmacSecret;
  String? supportedCountry;
  String? encryptionKey;
  String? merchantId;
  String? merchantKey;
  String? merchantWebsiteLink;
  String? refundUrl;

  PaymentInfo(
      {this.appKey,
        this.appSecret,
        this.username,
        this.password,
        this.publicKey,
        this.secretKey,
        this.merchantEmail,
        this.callbackUrl,
        this.apiKey,
        this.apiSecret,
        this.publishedKey,
        this.mode,
        this.otherConfigKey,
        this.storeId,
        this.storePassword,
        this.mcTelMerchant,
        this.accessToken,
        this.mcMerchantCode,
        this.clientId,
        this.clientSecret,
        this.integrationId,
        this.iframeId,
        this.hmacSecret,
        this.supportedCountry,
        this.encryptionKey,
        this.merchantId,
        this.merchantKey,
        this.merchantWebsiteLink,
        this.refundUrl});

  PaymentInfo.fromJson(Map<String, dynamic> json) {
    appKey = json['app_key'];
    appSecret = json['app_secret'];
    username = json['username'];
    password = json['password'];
    publicKey = json['public_key'];
    secretKey = json['secret_key'];
    merchantEmail = json['merchant_email'];
    callbackUrl = json['callback_url'];
    apiKey = json['api_key'];
    apiSecret = json['api_secret'];
    publishedKey = json['published_key'];
    mode = json['mode'];
    otherConfigKey = json['other_config_key'];
    storeId = json['store_id'];
    storePassword = json['store_password'];
    mcTelMerchant = json['mc_tel_merchant'];
    accessToken = json['access_token'];
    mcMerchantCode = json['mc_merchant_code'];
    clientId = json['client_id'];
    clientSecret = json['client_secret'];
    integrationId = json['integration_id'];
    iframeId = json['iframe_id'];
    hmacSecret = json['hmac_secret'];
    supportedCountry = json['supported_country'];
    encryptionKey = json['encryption_key'];
    merchantId = json['merchant_id'];
    merchantKey = json['merchant_key'];
    merchantWebsiteLink = json['merchant_website_link'];
    refundUrl = json['refund_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['app_key'] = appKey;
    data['app_secret'] = appSecret;
    data['username'] = username;
    data['password'] = password;
    data['public_key'] = publicKey;
    data['secret_key'] = secretKey;
    data['merchant_email'] = merchantEmail;
    data['callback_url'] = callbackUrl;
    data['api_key'] = apiKey;
    data['api_secret'] = apiSecret;
    data['published_key'] = publishedKey;
    data['mode'] = mode;
    data['other_config_key'] = otherConfigKey;
    data['store_id'] = storeId;
    data['store_password'] = storePassword;
    data['mc_tel_merchant'] = mcTelMerchant;
    data['access_token'] = accessToken;
    data['mc_merchant_code'] = mcMerchantCode;
    data['client_id'] = clientId;
    data['client_secret'] = clientSecret;
    data['integration_id'] = integrationId;
    data['iframe_id'] = iframeId;
    data['hmac_secret'] = hmacSecret;
    data['supported_country'] = supportedCountry;
    data['encryption_key'] = encryptionKey;
    data['merchant_id'] = merchantId;
    data['merchant_key'] = merchantKey;
    data['merchant_website_link'] = merchantWebsiteLink;
    data['refund_url'] = refundUrl;
    return data;
  }
}
