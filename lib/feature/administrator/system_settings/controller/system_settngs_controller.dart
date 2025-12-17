
import 'dart:developer';
import 'dart:ui';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mighty_school/api_handle/api_checker.dart';
import 'package:mighty_school/common/widget/custom_snackbar.dart';
import 'package:mighty_school/feature/academic_configuration/session/controller/session_controller.dart';
import 'package:mighty_school/feature/administrator/system_settings/domain/model/general_settings_model.dart';
import 'package:mighty_school/feature/administrator/system_settings/domain/repository/system_settings_repository.dart';
import 'package:mighty_school/helper/image_size_checker.dart';
import 'package:mighty_school/util/app_constants.dart';

class SystemSettingsController extends GetxController implements GetxService{
  final SystemSettingsRepository systemSettingsRepository;
  SystemSettingsController({required this.systemSettingsRepository});





  Color sidebarColor = const Color(0xFF11152B);
  Color sidebarTextColor = const Color(0xFFFFFFFF);

  bool loading = false;
  String? currentSessionId;
  String logoUrl = "";
  GeneralSettingModel? generalSettingModel;
  Future<void> getGeneralSetting() async {
    log("Current session id: $currentSessionId");
    Response? response = await systemSettingsRepository.getGeneralSetting();
    if (response?.statusCode == 200) {
      generalSettingModel = GeneralSettingModel.fromJson(response?.body);
      if (generalSettingModel != null) {
        log("logo path is : ${AppConstants.baseUrl}/public/uploads/logos/${generalSettingModel?.data?.logo}");
        logoUrl = "${AppConstants.baseUrl}/public/uploads/logos/${generalSettingModel?.data?.logo}";
        sidebarColor = Color(int.parse(generalSettingModel?.data?.sidebarColor ?? "0xFF6750A4"));
        sidebarTextColor = Color(int.parse(generalSettingModel?.data?.sidebarTextColor ?? "0xFFFFFFFF"));
        currentSessionId = generalSettingModel?.data?.academicYear;
        Get.find<SessionController>().getSessionNameFromSessionId(int.parse(currentSessionId!));
      }
      log("Current session id: $currentSessionId");
    }else{
      ApiChecker.checkApi(response!);
    }
    update();
  }


  GeneralSettingModel? generalPublicSettingModel;
  Future<void> getGeneralPublicSetting() async {
    log("Current session id: $currentSessionId");
    Response? response = await systemSettingsRepository.getGeneralPublicSetting();
    if (response?.statusCode == 200) {
      generalPublicSettingModel = GeneralSettingModel.fromJson(response?.body);
    }else{
      ApiChecker.checkApi(response!);
    }
    update();
  }



  Future<void>updateGeneralSetting(SettingItem body) async {
    loading = true;
    update();
    Response? response = await systemSettingsRepository.updateGeneralSetting(body);
    if (response?.statusCode == 200) {
      loading = false;
      getGeneralSetting();
      showCustomSnackBar("updated_successfully".tr, isError: false);
    }else{
      loading = false;
      ApiChecker.checkApi(response!);
    }
    update();
  }

  Future<void> updateSidebarColor(String color) async {
    loading = true;
    update();
    Response? response = await systemSettingsRepository.sideBarColorUpdate(color);
    if (response?.statusCode == 200) {
      loading = false;
      getGeneralSetting();
      showCustomSnackBar("updated_successfully".tr, isError: false);
    }else{
      loading = false;
      ApiChecker.checkApi(response!);
    }
    update();
  }

  Future<void> updateSidebarTextColor(String color) async {
    loading = true;
    update();
    Response? response = await systemSettingsRepository.sideBarTextColorUpdate(color);
    if (response?.statusCode == 200) {
      loading = false;
      getGeneralSetting();
      showCustomSnackBar("updated_successfully".tr, isError: false);
    }else{
      loading = false;
      ApiChecker.checkApi(response!);
    }
    update();
  }


  Future<void> updatePrimaryColor(String color) async {
    loading = true;
    update();
    Response? response = await systemSettingsRepository.primaryColorUpdate(color);
    if (response?.statusCode == 200) {
      loading = false;
      getGeneralSetting();
      showCustomSnackBar("updated_successfully".tr, isError: false);
    }else{
      loading = false;
      ApiChecker.checkApi(response!);
    }
    update();
  }



  Future<void> uploadLogo() async {
    loading = true;
    update();
    Response? response = await systemSettingsRepository.uploadLogo(thumbnail);
    if (response?.statusCode == 200) {
      loading = false;
      getGeneralSetting();
      showCustomSnackBar("logo_uploaded_successfully".tr, isError: false);
    }else{
      loading = false;
      ApiChecker.checkApi(response!);
    }
    update();
  }



  int settingsTypeIndex = 0;
  void setSelectedSettingsTypeIndex(int typeIndex){
    settingsTypeIndex = typeIndex;
    update();
  }


  XFile? thumbnail;
  XFile? pickedImage;
  void pickImage() async {
    pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    double imageSizeIs = await ImageSize.getImageSize(pickedImage!);
    log("Here is image size ==> $imageSizeIs");
    if(imageSizeIs > 1){
      showCustomSnackBar("please_choose_image_size_less_than_2_mb".tr);
    }else{
      thumbnail = pickedImage;
    }
    update();
  }


}