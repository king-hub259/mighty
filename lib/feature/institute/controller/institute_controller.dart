
import 'dart:developer';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mighty_school/api_handle/api_checker.dart';
import 'package:mighty_school/common/widget/custom_snackbar.dart';
import 'package:mighty_school/feature/authentication/logic/authentication_controller.dart';
import 'package:mighty_school/feature/institute/domain/models/institute_body_model.dart';
import 'package:mighty_school/feature/institute/domain/models/institute_model.dart';
import 'package:mighty_school/feature/institute/domain/models/onboarding_model.dart';
import 'package:mighty_school/feature/institute/domain/models/pending_institute_model.dart';
import 'package:mighty_school/feature/institute/domain/repository/institute_repository.dart';
import 'package:mighty_school/feature/institute/presentation/widgets/purchase_subscription_plan_widget.dart';
import 'package:mighty_school/feature/profile/logic/profile_controller.dart';
import 'package:mighty_school/helper/image_size_checker.dart';
import 'package:mighty_school/helper/route_helper.dart';

class InstituteController extends GetxController implements GetxService{
  final InstituteRepository instituteRepository;
  InstituteController({required this.instituteRepository});




  bool isLoading = false;
  InstituteModel? instituteModel;
  Future<void> getInstituteList(int offset) async {
    Response? response = await instituteRepository.getInstituteList(offset);
    if (response?.statusCode == 200) {
      if(offset == 1){
        instituteModel = InstituteModel.fromJson(response?.body);
      }else{
        instituteModel?.data?.data?.addAll(InstituteModel.fromJson(response?.body).data!.data!);
        instituteModel?.data?.currentPage = InstituteModel.fromJson(response?.body).data?.currentPage;
        instituteModel?.data?.total = InstituteModel.fromJson(response?.body).data?.total;
      }

    }else{
      isLoading = false;
      ApiChecker.checkApi(response!);
    }
    update();
  }

  PendingInstituteModel? pendingInstituteModel;
  Future<void> getPendingInstituteList(int offset) async {
    Response? response = await instituteRepository.pendingInstituteList(offset);
    if (response?.statusCode == 200) {
      if(offset == 1){
        pendingInstituteModel = PendingInstituteModel.fromJson(response?.body);
      }else{
        pendingInstituteModel?.data?.data?.addAll(PendingInstituteModel.fromJson(response?.body).data!.data!);
        pendingInstituteModel?.data?.currentPage = PendingInstituteModel.fromJson(response?.body).data?.currentPage;
        pendingInstituteModel?.data?.total = PendingInstituteModel.fromJson(response?.body).data?.total;
      }

    }else{
      isLoading = false;
      ApiChecker.checkApi(response!);
    }
    update();
  }

  XFile? thumbnail;
  XFile? userImage;
  XFile? pickedImage;
  void pickImage({bool user = false}) async {
    log("message you are in pick image");
    pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    log("message you are in pick image");
    double imageSizeIs = await ImageSize.getImageSize(pickedImage!);
    log("Here is image size ==> $imageSizeIs");
    if(imageSizeIs > 1){
      showCustomSnackBar("please_choose_image_size_less_than_2_mb".tr);
    }else{
      if(user){
        userImage = pickedImage;
      }else {
        thumbnail = pickedImage;
      }
    }
    update();
  }


  InstituteBodyModel? instituteBodyModel;
  OnboardingModel? onboardingModel;
  Future<void> createInstitute(InstituteBodyModel body) async {
    isLoading = true;
    update();
    Response? response = await instituteRepository.applyInstitute(body, thumbnail, userImage);
    if (response?.statusCode == 200) {
      onboardingModel = OnboardingModel.fromJson(response?.body);
      instituteBodyModel = body;
      isLoading = false;
      Get.find<AuthenticationController>().setUserToken(response?.body['data']['access_token']);
      Get.find<ProfileController>().getProfileInfo().then((val){
        if(val.statusCode == 200){
          Get.dialog(const PurchaseSubscriptionPlanWidget());
        }
      });
    } else {
      isLoading = false;
      ApiChecker.checkApi(response!);
    }
    update();
  }

  Future<void> updateSubscriptionPlan(int planId, int instituteId, {bool fromUpdate = false}) async {
    isLoading = true;
    Response? response = await instituteRepository.subscriptionPlanUpdate(planId, instituteId);
    if (response?.statusCode == 200) {
      if (fromUpdate) {
        showCustomSnackBar("subscription_plan_updated".tr, isError: false);
      } else{
        if (planId == 1) {
        showCustomSnackBar(
            "trial_subscription_is_activated".tr, isError: false);
      } else {
        showCustomSnackBar("subscription_plan_updated".tr, isError: false);
      }
      isLoading = false;
      Get.toNamed(RouteHelper.getDashboardRoute());
    }
    }else{
      isLoading = false;
      ApiChecker.checkApi(response!);
    }
    update();
  }


  Future<void> approveInstituteRequest(int id) async {
    isLoading = true;
    Response? response = await instituteRepository.approveInstituteRequest(id);
    if (response?.statusCode == 200) {
      showCustomSnackBar("approved_successfully".tr, isError: false);
      getPendingInstituteList(1);
      getInstituteList(1);

      isLoading = false;
    }else{
      isLoading = false;
      ApiChecker.checkApi(response!);
    }
    update();
  }

}