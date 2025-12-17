
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/model/popup_menu_model.dart';
import 'package:mighty_school/feature/administrator/notice/presentation/screens/notice_screen.dart';
import 'package:mighty_school/feature/dashboard/model/navigation_model.dart';
import 'package:mighty_school/feature/fees_management/presentation/fees_managment_screen.dart';
import 'package:mighty_school/feature/home/presentation/home_screen.dart';
import 'package:mighty_school/feature/parent_module/parent_class_routine/presentation/screens/parent_class_routine_screen.dart';
import 'package:mighty_school/feature/parent_module/parent_home/presentation/parent_home_screen.dart';
import 'package:mighty_school/feature/parent_module/parent_paid_info/presentation/screens/parent_fees_screen.dart';
import 'package:mighty_school/feature/parent_module/parents/presentation/widget/menu_dialog.dart';
import 'package:mighty_school/feature/profile/logic/profile_controller.dart';
import 'package:mighty_school/feature/student_module/student_class_routine/presentation/screens/student_class_routine_screen.dart';
import 'package:mighty_school/feature/student_module/student_home/presentation/student_home_screen.dart';
import 'package:mighty_school/feature/students_information/student/presentation/screens/add_new_student_screen.dart';
import 'package:mighty_school/helper/responsive_helper.dart';
import 'package:mighty_school/util/app_constants.dart';
import 'package:mighty_school/util/images.dart';

class DashboardController extends GetxController implements GetxService{
  int _currentTab = 0;
  int get currentTab => _currentTab;

  void resetNavBar() {
    _currentTab = 0;
  }

  void setTabIndex(int index) {

    if(index == 3 && Get.find<ProfileController>().profileModel?.data?.role?.toLowerCase() == AppConstants.parent.toLowerCase() && ResponsiveHelper.isMobile(Get.context!)){
      Get.bottomSheet(const DashboardMenuDialog(), isScrollControlled: true);
    }else if(index == 4){
      Get.bottomSheet(const DashboardMenuDialog(), isScrollControlled: true);
    }
    else {
      _currentTab = index;
    }
    if(!ResponsiveHelper.isDesktop(Get.context!)) {
      update();
    }
  }


  final ScrollController scrollController = ScrollController();

  final List<NavigationModel> item = [
    NavigationModel(name: 'dashboard'.tr, activeIcon: Images.homeActive, inactiveIcon: Images.home, screen: const HomeScreen()),
    NavigationModel(name: 'fees'.tr, activeIcon: Images.fees, inactiveIcon: Images.fees, screen: const FeesManagementScreen()),
    NavigationModel(name: 'student'.tr, activeIcon: Images.add, inactiveIcon: Images.add, screen: const AddNewStudentScreen()),
    NavigationModel(name: 'notice'.tr, activeIcon: Images.notice, inactiveIcon: Images.notice, screen: const NoticeScreen()),
    NavigationModel(name: 'menu'.tr, activeIcon: Images.menuIcon, inactiveIcon: Images.menuIcon, screen: const SizedBox()),

  ];

  final List<NavigationModel> parentsItem = [
    NavigationModel(name: 'dashboard'.tr, activeIcon: Images.homeRouteIcon, inactiveIcon: Images.homeRouteIcon, screen: const ParentHomeScreen()),
    NavigationModel(name: 'routine'.tr, activeIcon: Images.routine, inactiveIcon: Images.routine, screen: const ParentClassRoutineScreen()),
    NavigationModel(name: 'fees'.tr, activeIcon: Images.fees, inactiveIcon: Images.fees, screen: const ParentFeesScreen()),
    NavigationModel(name: 'menu'.tr, activeIcon: Images.menuIcon, inactiveIcon: Images.menuIcon, screen: const SizedBox()),
  ];

  final List<NavigationModel> studentsItem = [
    NavigationModel(name: 'dashboard'.tr, activeIcon: Images.homeRouteIcon, inactiveIcon: Images.homeRouteIcon, screen: const StudentHomeScreen()),
    NavigationModel(name: 'routine'.tr, activeIcon: Images.routine, inactiveIcon: Images.routine, screen: const StudentClassRoutineScreen()),
    NavigationModel(name: 'fees'.tr, activeIcon: Images.fees, inactiveIcon: Images.fees, screen: const ParentFeesScreen()),
    NavigationModel(name: 'menu'.tr, activeIcon: Images.menuIcon, inactiveIcon: Images.menuIcon, screen: const SizedBox()),
  ];

  List<PopupMenuModel> getPopupMenuList({bool editDelete = false, bool invoice = false}) {
    if(editDelete){
      return [
        PopupMenuModel(title: "edit".tr, icon: Icons.edit),
        PopupMenuModel(title: "delete".tr, icon: Icons.delete_forever),
      ];

    } else if(invoice){
      return [
        PopupMenuModel(title: "view".tr, icon: Icons.remove_red_eye_outlined),
        PopupMenuModel(title: "download_pdf".tr, icon: Icons.download),
        PopupMenuModel(title: "send_remainder".tr, icon: Icons.send),
        PopupMenuModel(title: "edit".tr, icon: Icons.edit),
        PopupMenuModel(title: "delete".tr, icon: Icons.delete_forever),
      ];

    }else {
      return [
        PopupMenuModel(title: "payment".tr, icon: Icons.monetization_on_outlined),
        PopupMenuModel(title: "attendance".tr, icon: Icons.check_circle_outline),
        PopupMenuModel(title: "print_details".tr, icon: Icons.print),
      ];
    }

  }
}
