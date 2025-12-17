class GeneralSettingModel {
  bool? status;
  String? message;
  SettingItem? data;


  GeneralSettingModel({this.status, this.message, this.data});

  GeneralSettingModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? SettingItem.fromJson(json['data']) : null;

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }

    return data;
  }
}

class SettingItem {
  String? schoolName;
  String? siteTitle;
  String? phone;
  String? email;
  String? language;
  String? googleMap;
  String? address;
  String? onGoogleMap;
  String? instituteCode;
  String? timezone;
  String? academicYear;
  String? currencySymbol;
  String? mailType;
  String? logo;
  String? disabledWebsite;
  String? copyrightText;
  String? examResultPhone;
  String? tuitionFeePhone;
  String? facebookLink;
  String? googlePlusLink;
  String? youtubeLink;
  String? whatsAppLink;
  String? twitterLink;
  String? eiinCode;
  String? apiKey;
  String? senderId;
  String? smsApi;
  String? defaultSmsGateway;
  String? smsTestMode;
  String? smsType;
  String? headerNotice;
  String? examResultStatus;
  String? admissionDisplayStatus;
  String? tcAmount;
  String? appVersion;
  String? appUrl;
  String? sidebarColor;
  String? sidebarTextColor;
  String? zoomAccountId;
  String? zoomClientKey;
  String? zoomClientSecret;


  SettingItem(
      {this.schoolName,
        this.siteTitle,
        this.phone,
        this.email,
        this.language,
        this.googleMap,
        this.address,
        this.onGoogleMap,
        this.instituteCode,
        this.timezone,
        this.academicYear,
        this.currencySymbol,
        this.mailType,
        this.logo,
        this.disabledWebsite,
        this.copyrightText,
        this.examResultPhone,
        this.tuitionFeePhone,
        this.facebookLink,
        this.googlePlusLink,
        this.youtubeLink,
        this.whatsAppLink,
        this.twitterLink,
        this.eiinCode,
        this.apiKey,
        this.senderId,
        this.smsApi,
        this.defaultSmsGateway,
        this.smsTestMode,
        this.smsType,
        this.headerNotice,
        this.examResultStatus,
        this.admissionDisplayStatus,
        this.tcAmount,
        this.appVersion,
        this.appUrl,
        this.sidebarColor,
        this.sidebarTextColor,
        this.zoomAccountId,
        this.zoomClientKey,
        this.zoomClientSecret
      });

  SettingItem.fromJson(Map<String, dynamic> json) {
    schoolName = json['school_name'];
    siteTitle = json['site_title'];
    phone = json['phone'];
    email = json['email'];
    language = json['language'];
    googleMap = json['google_map'];
    address = json['address'];
    onGoogleMap = json['on_google_map'];
    instituteCode = json['institute_code'];
    timezone = json['timezone'];
    academicYear = json['academic_year'].toString();
    currencySymbol = json['currency_symbol'];
    mailType = json['mail_type'];
    logo = json['logo'];
    disabledWebsite = json['disabled_website'];
    copyrightText = json['copyright_text'];
    examResultPhone = json['exam_result_phone'];
    tuitionFeePhone = json['tuition_fee_phone'];
    facebookLink = json['facebook_link'];
    googlePlusLink = json['google_plus_link'];
    youtubeLink = json['youtube_link'];
    whatsAppLink = json['whats_app_link'];
    twitterLink = json['twitter_link'];
    eiinCode = json['eiin_code'];
    apiKey = json['api_key'];
    senderId = json['sender_id'];
    smsApi = json['sms_api'];
    defaultSmsGateway = json['default_sms_gateway'];
    smsTestMode = json['sms_test_mode'];
    smsType = json['sms_type'];
    headerNotice = json['header_notice'];
    examResultStatus = json['exam_result_status'];
    admissionDisplayStatus = json['admission_display_status'];
    tcAmount = json['tc_amount'];
    appVersion = json['app_version'];
    appUrl = json['app_url'];
    sidebarColor = json['sidebar_color'];
    sidebarTextColor = json['sidebar_text_color'];
    zoomAccountId = json['zoom_account_id'];
    zoomClientKey = json['zoom_client_key'];
    zoomClientSecret = json['zoom_client_secret'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['school_name'] = schoolName;
    data['site_title'] = siteTitle;
    data['phone'] = phone;
    data['email'] = email;
    data['language'] = language;
    data['google_map'] = googleMap;
    data['address'] = address;
    data['on_google_map'] = onGoogleMap;
    data['institute_code'] = instituteCode;
    data['timezone'] = timezone;
    data['academic_year'] = academicYear;
    data['currency_symbol'] = currencySymbol;
    data['mail_type'] = mailType;
    data['logo'] = logo;
    data['disabled_website'] = disabledWebsite;
    data['copyright_text'] = copyrightText;
    data['exam_result_phone'] = examResultPhone;
    data['tuition_fee_phone'] = tuitionFeePhone;
    data['facebook_link'] = facebookLink;
    data['google_plus_link'] = googlePlusLink;
    data['youtube_link'] = youtubeLink;
    data['whats_app_link'] = whatsAppLink;
    data['twitter_link'] = twitterLink;
    data['eiin_code'] = eiinCode;
    data['api_key'] = apiKey;
    data['sender_id'] = senderId;
    data['sms_api'] = smsApi;
    data['default_sms_gateway'] = defaultSmsGateway;
    data['sms_test_mode'] = smsTestMode;
    data['sms_type'] = smsType;
    data['header_notice'] = headerNotice;
    data['exam_result_status'] = examResultStatus;
    data['admission_display_status'] = admissionDisplayStatus;
    data['tc_amount'] = tcAmount;
    data['app_version'] = appVersion;
    data['app_url'] = appUrl;
    data['sidebar_color'] = sidebarColor;
    data['sidebar_text_color'] = sidebarTextColor;
    data['zoom_account_id'] = zoomAccountId;
    data['zoom_client_key'] = zoomClientKey;
    data['zoom_client_secret'] = zoomClientSecret;
    return data;
  }
}
