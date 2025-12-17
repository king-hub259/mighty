

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/animated_custom_dialog.dart';
import 'package:mighty_school/common/widget/confirmation_dialog_widget.dart';
import 'package:mighty_school/feature/authentication/logic/authentication_controller.dart';
import 'package:mighty_school/feature/dashboard/controller/dashboard_controller.dart';
import 'package:mighty_school/feature/dashboard/model/navigation_model.dart';
import 'package:mighty_school/feature/dashboard/widget/custom_navbar_widget.dart';
import 'package:mighty_school/feature/home/presentation/web_hom_screen.dart';
import 'package:mighty_school/feature/profile/logic/profile_controller.dart';
import 'package:mighty_school/helper/responsive_helper.dart';
import 'package:mighty_school/util/app_constants.dart';
import 'package:mighty_school/util/images.dart';



class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});
  @override
  DashboardScreenState createState() => DashboardScreenState();
}

class DashboardScreenState extends State<DashboardScreen> {
  // FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;
  final PageStorageBucket bucket = PageStorageBucket();


  @override
  void initState() {
    Get.find<DashboardController>().setTabIndex(0);
    if(Get.find<ProfileController>().profileModel == null) {
      Get.find<ProfileController>().getProfileInfo();
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return PopScope(canPop: false,
      onPopInvokedWithResult: (didPop, dynamic) async {
        _onWillPop(context);
        return;
      },
      child: GetBuilder<DashboardController>(builder: (menuController) {
        return GetBuilder<AuthenticationController>(
          builder: (authController) {
            return GetBuilder<ProfileController>(
              builder: (profileController) {
                String? userType = profileController.profileModel?.data?.role;

                List<NavigationModel> item = [];
                if(userType?.toLowerCase() == AppConstants.parent.toLowerCase()) {
                  item = menuController.parentsItem;
                } else if(userType?.toLowerCase() == AppConstants.studentType.toLowerCase()){
                  item = menuController.studentsItem;
                }else {
                  item = menuController.item;
                }
                return Scaffold(resizeToAvoidBottomInset: false,
                  body: ResponsiveHelper.isDesktop(context)? const WebHomScreen() : PageStorage(bucket: bucket, child: item[menuController.currentTab].screen),

                  bottomNavigationBar: ResponsiveHelper.isDesktop(context)? const SizedBox() :
                  const CustomNavbarWidget(),

                );
              }
            );
          }
        );
      }),
    );
  }


}
Future<bool> _onWillPop(BuildContext context) async {
  showAnimatedDialog(context,  ConfirmationDialogWidget(icon: Images.logo,
    title: 'exit_app'.tr,
    description: 'do_you_want_to_exit_the_app'.tr, onYesPressed: (){
      SystemNavigator.pop();
    },),isFlip: true);
  return true;
}


