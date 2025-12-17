import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/feature/sidebar/controller/side_menu_bar_controller.dart';
import 'package:mighty_school/helper/route_helper.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/images.dart';

class SideMenuTitle extends StatelessWidget {
  const SideMenuTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SideMenuBarController>(
      builder: (homeController) {
        return InkWell(onTap: (){
          homeController.sideMenu.changePage(0);
          Get.offAllNamed(RouteHelper.getDashboardRoute());
        },
          child: Padding(padding: const EdgeInsets.all( Dimensions.paddingSizeDefault),
            child: Image.asset(Images.logoWithName, height: 50, width:230, color: Theme.of(context).primaryColor)),
        );
      }
    );
  }
}
