
import 'dart:developer';

import 'package:get/get.dart';
import 'package:mighty_school/api_handle/api_checker.dart';
import 'package:mighty_school/common/widget/custom_snackbar.dart';
import 'package:mighty_school/feature/administrator/system_settings/controller/system_settngs_controller.dart';
import 'package:mighty_school/feature/academic_configuration/session/domain/models/session_model.dart';
import 'package:mighty_school/feature/academic_configuration/session/domain/repository/session_repository.dart';
import 'package:mighty_school/util/app_constants.dart';

class SessionController extends GetxController implements GetxService{
  final SessionRepository sessionRepository;
  SessionController({required this.sessionRepository});




  bool isLoading = false;
  SessionModel? sessionModel;
  Future<void> getSessionList(int offset) async {
    Response? response = await sessionRepository.getSessionList(offset);
    if (response?.statusCode == 200) {
      if(offset == 1){
        sessionModel = SessionModel.fromJson(response?.body);
      }else{
        sessionModel?.data?.data?.addAll(SessionModel.fromJson(response?.body).data!.data!);
        sessionModel?.data?.currentPage = SessionModel.fromJson(response?.body).data?.currentPage;
        sessionModel?.data?.total = SessionModel.fromJson(response?.body).data?.total;
      }
      isLoading = false;
      if (sessionModel != null && Get.find<SystemSettingsController>().currentSessionId != null) {
        getSessionNameFromSessionId(int.parse(Get.find<SystemSettingsController>().currentSessionId!));
      }
    }else{
      isLoading = false;
      ApiChecker.checkApi(response!);
    }
    update();
  }

  // need to return the session name from the session id

  String? sessionName;
  getSessionNameFromSessionId(int id){
    if(sessionModel?.data?.data != null && sessionModel!.data!.data!.isNotEmpty) {
      sessionName = sessionModel?.data?.data?.firstWhere((element) => element.id == id).year;
    }
    log("Session name: $sessionName");
    update();
  }



  Future<void> createNewSession( String name, String description,) async {
    isLoading = true;
    update();
    Response? response = await sessionRepository.createNewSession(name, description );
    if(response!.statusCode == 200){
      isLoading = false;
      Get.back();
      showCustomSnackBar("added_successfully".tr, isError: false);
      getSessionList(1);
    }else{
      ApiChecker.checkApi(response);
    }
    isLoading = false;
    update();

  }

  Future<void> updateSession( String name, String description, int id) async {
    isLoading = true;
    update();
    Response? response = await sessionRepository.updateSession(name, description, id);
    if(response!.statusCode == 200){
      isLoading = false;
      Get.back();
      showCustomSnackBar("updated_successfully".tr, isError: false);
      getSessionList(1);
    }else{
      ApiChecker.checkApi(response);
    }
    isLoading = false;
    update();

  }


  Future<void> deleteSession(int id) async {
    isLoading = true;
    Response? response = await sessionRepository.deleteSession(id);
    if (response?.statusCode == 200) {
      showCustomSnackBar("deleted_successfully".tr, isError: false);
      getSessionList(1);
      isLoading = false;
    }else{
      isLoading = false;
      ApiChecker.checkApi(response!);
    }
    update();
  }

  Future<void> changeSession(int id) async {
    isLoading = true;
    Response? response = await sessionRepository.changeSession(id);
    if (response?.statusCode == 200) {
      showCustomSnackBar("updated_successfully".tr, isError: false);
      isLoading = false;
    }else{
      isLoading = false;
     ApiChecker.checkApi(response!);
    }
    update();
  }



  SessionItem? selectedSessionItem;
  void selectSession(SessionItem item, {bool change = false}){
    if(AppConstants.demo == true && change){
      showCustomSnackBar("Changes are disabled in the demo version.");
    }else{
      selectedSessionItem = item;
      if(change){
        changeSession(item.id!);
      }
    }
    update();
  }


}