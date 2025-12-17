
import 'package:get/get.dart';
import 'package:mighty_school/api_handle/api_checker.dart';
import 'package:mighty_school/common/widget/custom_snackbar.dart';
import 'package:mighty_school/feature/branch/controller/branch_controller.dart';
import 'package:mighty_school/feature/profile/domain/model/profile_model.dart';
import 'package:mighty_school/feature/profile/domain/repository/profile_repository.dart';
import 'package:mighty_school/feature/sidebar/controller/side_menu_bar_controller.dart';
import 'package:mighty_school/util/app_constants.dart';

class ProfileController extends GetxController implements GetxService{
  final ProfileRepository profileRepository;
  ProfileController({required this.profileRepository});


  bool isLoading = false;
  ProfileModel? profileModel;
  String? currentBranch;
  Future<Response> getProfileInfo() async {
    isLoading = true;
    profileModel = null;
    Response? response = await profileRepository.getProfileInfo();
    if (response?.statusCode == 200) {
      profileModel = ProfileModel.fromJson(response?.body);
      currentBranch = profileModel?.data?.branchId.toString();
      String? role = profileModel?.data?.role;
      Get.find<BranchController>().getBranchNameFromId(int.parse(currentBranch!));
      isLoading = false;
      if(role == "SAAS Admin"){
        Get.find<SideMenuBarController>().updateSaasSideMenuItems();
      }else if(role == "Super Admin"){
        Get.find<SideMenuBarController>().updateSideMenuItems();
      }
      else if(role == AppConstants.parent){
        Get.find<SideMenuBarController>().updateParentSideMenuItems();
      } else if(role == AppConstants.studentType){
        Get.find<SideMenuBarController>().updateStudentSideMenuItems();
      }
     else {
        Get.find<SideMenuBarController>().updateSideMenuItems();
      }
    }else{
      isLoading = false;
      ApiChecker.checkApi(response!);
    }
    update();
    return response!;
  }

  bool hasPermission(String permission) {
    return profileModel?.data?.permissions?.contains(permission) ?? false;
  }

  String userType() {
    return profileModel?.data?.role ?? "";
  }

  List<String> roles = [
    "Super Admin",
    "Saas Admin",
    "Branch Admin",
    "Teacher",
    "Student",
    "Parent",
  ];

  Future<void> updateProfile(String name, String email) async {
    isLoading = true;
    Response? response = await profileRepository.updateProfile(name, email);
    if (response?.statusCode == 200) {
      showCustomSnackBar("profile_updated_successfully".tr, isError: false);
     getProfileInfo();
      isLoading = false;
    }else{
      isLoading = false;
      ApiChecker.checkApi(response!);
    }
    update();
  }

  Future<void> changePassword(String oldPassword, String newPassword) async {
    isLoading = true;
    Response? response = await profileRepository.changePassword(oldPassword, newPassword);
    if (response?.statusCode == 200) {
      showCustomSnackBar("password_changed_successfully".tr, isError: false);
      getProfileInfo();
      isLoading = false;
    }else{
      isLoading = false;
      ApiChecker.checkApi(response!);
    }
    update();
  }


}