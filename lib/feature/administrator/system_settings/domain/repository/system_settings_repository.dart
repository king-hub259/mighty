import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:mighty_school/api_handle/api_client.dart';
import 'package:mighty_school/feature/administrator/system_settings/domain/model/general_settings_model.dart';
import 'package:mighty_school/util/app_constants.dart';

class SystemSettingsRepository{
  final ApiClient apiClient;
  SystemSettingsRepository({required this.apiClient});


  Future<Response?> getGeneralSetting () async {
    return await apiClient.getData(AppConstants.generalSetting);
  }

    Future<Response?> getGeneralPublicSetting () async {
    return await apiClient.getData(AppConstants.publicSetting);
  }



  Future<Response?> updateGeneralSetting (SettingItem body) async {
    return await apiClient.postData(AppConstants.generalSetting, {
      "school_name" : body.schoolName,
      "site_title" : body.siteTitle,
      "phone" : body.phone,
      "email" : body.email,
      "institute_code" : body.instituteCode,
      "address" : body.address,
      "tuition_fee_phone" : body.tuitionFeePhone,
      "exam_result_phone" : body.examResultPhone,
      "eiin_code" : body.eiinCode,
      "header_notice" : body.headerNotice,
      "tc_amount" : body.tcAmount,
      "app_version" : body.appVersion,
      "app_url" : body.appUrl,
      "exam_result_status": body.examResultStatus,
      "admission_display_status": body.admissionDisplayStatus,

    });
  }

  Future<Response?> sideBarColorUpdate (String color) async {
    return await apiClient.postData(AppConstants.generalSetting, {
      "sidebar_color" : color,
    });
  }


  Future<Response?> sideBarTextColorUpdate (String color) async {
    return await apiClient.postData(AppConstants.generalSetting, {
      "sidebar_text_color" : color,
    });
  }

  Future<Response?> primaryColorUpdate (String color) async {
    return await apiClient.postData(AppConstants.generalSetting, {
      "sidebar_theme_color" : color,
    });
  }



  Future<Response?> uploadLogo (XFile? logo) async {
    return await apiClient.postMultipartData(AppConstants.uploadLogo, {"logo" : "logo"}, [], MultipartBody("logo", logo), []);
  }

}