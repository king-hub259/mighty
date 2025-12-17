
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/feature/dashboard/model/navigation_model.dart';
import 'package:mighty_school/feature/parent_module/parent_class_routine/presentation/screens/parent_class_routine_screen.dart';
import 'package:mighty_school/feature/parent_module/parent_home/presentation/parent_home_screen.dart';
import 'package:mighty_school/feature/parent_module/parent_paid_info/presentation/screens/parent_fees_screen.dart';
import 'package:mighty_school/feature/parent_module/parents/presentation/widget/menu_dialog.dart';
import 'package:mighty_school/util/images.dart';

class ParentDashboardController extends GetxController implements GetxService{
  int _currentTab = 0;
  int get currentTab => _currentTab;

  void resetNavBar() {
    _currentTab = 0;
  }

  void setTabIndex(int index) {
    if(index == 3){
      Get.bottomSheet(
        const DashboardMenuDialog(),
        isScrollControlled: true,
      );
    }
    else {
      _currentTab = index;
    }

    update();
  }

  final ScrollController scrollController = ScrollController();

  final List<NavigationModel> item = [
    NavigationModel(name: 'dashboard'.tr, activeIcon: Images.homeActive, inactiveIcon: Images.home, screen: const ParentHomeScreen()),
    NavigationModel(name: 'routine'.tr, activeIcon: Images.routine, inactiveIcon: Images.routine, screen: const ParentClassRoutineScreen()),
    NavigationModel(name: 'fees'.tr, activeIcon: Images.feesIcon, inactiveIcon: Images.feesIcon, screen: const ParentFeesScreen()),
    NavigationModel(name: 'menu'.tr, activeIcon: Images.menuIcon, inactiveIcon: Images.menuIcon, screen: const SizedBox()),
  ];
}
