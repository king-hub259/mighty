

import 'package:get/get.dart';
import 'package:mighty_school/api_handle/api_checker.dart';
import 'package:mighty_school/common/widget/custom_snackbar.dart';
import 'package:mighty_school/feature/authentication/domain/authentication_repository.dart';
import 'package:mighty_school/feature/parent_module/parent_profile/logic/parent_profile_controller.dart';
import 'package:mighty_school/feature/profile/logic/profile_controller.dart';
import 'package:mighty_school/feature/sidebar/controller/side_menu_bar_controller.dart';
import 'package:mighty_school/feature/student_module/student_profile/logic/student_profile_controller.dart';
import 'package:mighty_school/helper/route_helper.dart';
import 'package:mighty_school/util/app_constants.dart';

class AuthenticationController extends GetxController implements GetxService{
  final AuthenticationRepository authenticationRepository;
  AuthenticationController({required this.authenticationRepository});


  bool isLoading = false;
  Future<void> login(String email, String password) async {
    isLoading = true;
    update();
    final response = await authenticationRepository.login(email: email, password: password);
    isLoading = false;
    if (response == null) {
      showCustomSnackBar("No response from server");
      update();
      return;
    }

    if (response.statusCode == 200) {
      final data = response.body['data'];
      setUserToken(data['access_token']);
      final role = data['role'];
      Future<Response?>? profileFuture;
      if (role == AppConstants.parent) {
        profileFuture = Get.find<ParentProfileController>().getProfileInfo();
      } else if (role == AppConstants.studentType) {
        profileFuture =
            Get.find<StudentProfileController>().getStudentProfileInfo();
      } else {
        profileFuture = Get.find<ProfileController>().getProfileInfo();
      }

      profileFuture.then((val) {
        if (val?.statusCode == 200) {
          Get.offAllNamed(RouteHelper.getDashboardRoute());
          final sideMenu = Get.find<SideMenuBarController>();
          sideMenu.toggleSideMenu(true);

          if (role == AppConstants.parent) {
            sideMenu.updateParentSideMenuItems();
          } else if (role == AppConstants.student) {
            sideMenu.updateStudentSideMenuItems();
          }
        }
      });
    } else if (response.statusCode == 1) {
      showCustomSnackBar("CORS ERROR");
    } else {
      ApiChecker.checkApi(response);
    }

    update();
  }


  Future <void> setUserToken(String token) async{
    authenticationRepository.saveUserToken(token);
  }

  Future <void> setUserType(String type) async{
    authenticationRepository.setUSerTypeParent(type);
  }

  String getUserType() {
    return authenticationRepository.getUserType();
  }

  bool isLoggedIn() {
    return authenticationRepository.isLoggedIn();
  }

  String getToken() {
    return authenticationRepository.getUserToken();
  }

  bool isActiveRememberMe = false;
  void toggleRememberMe() {
    isActiveRememberMe = !isActiveRememberMe;
    update();
  }

  int selectedIndex = 0;
  void setSelectedIndex(int index) {
    selectedIndex = index;
    update();
  }

  void saveEmailAndPassword(String number, String password) {
    authenticationRepository.saveEmailAndPassword(number, password);
  }
  Future <bool> clearSharedData() async {
    return authenticationRepository.clearSharedData();
  }

}