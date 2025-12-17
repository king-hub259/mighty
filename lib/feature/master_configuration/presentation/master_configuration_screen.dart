import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/common/widget/sub_menu_item_widget.dart';
import 'package:mighty_school/feature/administrator/system_settings/presentation/screens/system_setting_screen.dart';
import 'package:mighty_school/feature/master_configuration/employee/presentation/screens/employee_screen.dart';
import 'package:mighty_school/feature/master_configuration/role/presentation/screens/role_screen.dart';
import 'package:mighty_school/feature/menu_section/controller/menu_type_controller.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/images.dart';


class MasterConfigurationScreen extends StatefulWidget {
  const MasterConfigurationScreen({super.key});

  @override
  State<MasterConfigurationScreen> createState() => _MasterConfigurationScreenState();
}

class _MasterConfigurationScreenState extends State<MasterConfigurationScreen> {
  List<MainMenuModel> studentInformationItems = [
    MainMenuModel(icon: Images.purchase, title: 'system_settings', widget:  const SystemSettingScreen()),
    MainMenuModel(icon: Images.productReturn, title: 'roles', widget:  const RoleManagementScreen()),
    MainMenuModel(icon: Images.productReturn, title: 'users', widget:  const EmployeeScreen()),

  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(title: "master_configuration".tr,),
        body: CustomWebScrollView(slivers: [
          SliverToBoxAdapter(child:Padding(padding: const EdgeInsets.only(top: Dimensions.paddingSizeDefault),
            child: ListView.builder(
                itemCount: studentInformationItems.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                itemBuilder: (context, index){
                  return InkWell(onTap: ()=> Get.to(studentInformationItems[index].widget),
                      child: SubMenuItemWidget(icon: studentInformationItems[index].icon, title: studentInformationItems[index].title)
                  );
                }),
          ),)
        ],)
    );
  }
}
