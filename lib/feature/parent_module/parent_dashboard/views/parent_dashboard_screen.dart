
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/animated_custom_dialog.dart';
import 'package:mighty_school/common/widget/confirmation_dialog_widget.dart';
import 'package:mighty_school/feature/dashboard/model/navigation_model.dart';
import 'package:mighty_school/feature/dashboard/widget/custom_menu_item.dart';
import 'package:mighty_school/feature/parent_module/parent_dashboard/controller/parent_dashboard_controller.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/images.dart';



class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});
  @override
  DashboardScreenState createState() => DashboardScreenState();
}

class DashboardScreenState extends State<DashboardScreen> {
  final PageStorageBucket bucket = PageStorageBucket();


  @override
  void initState() {
    Get.find<ParentDashboardController>().setTabIndex(0);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return PopScope(canPop: false,
      onPopInvokedWithResult: (didPop, dynamic) async {
        _onWillPop(context);
        return;
      },
      child: GetBuilder<ParentDashboardController>(builder: (menuController) {
        return Scaffold(resizeToAvoidBottomInset: false,
          body: PageStorage(bucket: bucket, child: menuController.item[menuController.currentTab].screen),
          bottomNavigationBar: SafeArea(
            top: false,
            child: Container(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
              decoration: BoxDecoration(color: Theme.of(context).cardColor,
                boxShadow: [BoxShadow(offset: const Offset(1,1), blurRadius: 5, spreadRadius: 1, color: Theme.of(context).hintColor.withValues(alpha :.5))]),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: generateBottomNavigationItems(menuController, menuController.item)),
            ),
          ),
        );
      }),
    );
  }

  List<Widget> generateBottomNavigationItems(ParentDashboardController menuController, List<NavigationModel> item) {
    List<Widget> items = [];
    for(int index = 0; index < item.length; index++) {
      items.add(Expanded(child: CustomMenuItem(
        isSelected: menuController.currentTab == index,
        name: item[index].name,
        activeIcon: item[index].activeIcon,
        inActiveIcon: item[index].inactiveIcon,
        onTap: () => menuController.setTabIndex(index),
      )));
    }
    return items;
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


