import 'package:get/get.dart';
import 'package:mighty_school/api_handle/api_checker.dart';
import 'package:mighty_school/feature/parent_module/parent_profile/domain/model/parent_dashboard_data_model.dart';
import 'package:mighty_school/feature/parent_module/parent_profile/domain/model/parent_profile_model.dart';
import 'package:mighty_school/feature/parent_module/parent_profile/domain/repository/parent_profile_repository.dart';
import 'package:mighty_school/feature/sidebar/controller/side_menu_bar_controller.dart';

class ParentProfileController extends GetxController implements GetxService{
  final ParentProfileRepository profileRepository;
  ParentProfileController({required this.profileRepository});


  bool isLoading = false;
  ParentProfileModel? profileModel;
  Future<Response> getProfileInfo() async {
    Response? response = await profileRepository.getProfileInfo();
    if (response?.statusCode == 200) {
      profileModel = ParentProfileModel.fromJson(response?.body);
      Get.find<SideMenuBarController>().updateParentSideMenuItems();
    }else{
      ApiChecker.checkApi(response!);
    }
    update();
    return response!;
  }

  ParentDashboardDataModel? dashboardDataModel;
  Future<void> getDashboardData() async {
    Response? response = await profileRepository.getDashboardData();
    if (response?.statusCode == 200) {
      dashboardDataModel = ParentDashboardDataModel.fromJson(response?.body);
    }else{
      ApiChecker.checkApi(response!);
    }
    update();
  }

}