import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/coutom_royte_path/custom_route_path_widget.dart';
import 'package:mighty_school/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/feature/administrator/system_settings/controller/system_settngs_controller.dart';
import 'package:mighty_school/feature/administrator/system_settings/presentation/screens/system_settings_widget.dart';
import 'package:mighty_school/feature/administrator/system_settings/presentation/widgets/select_logo_widget.dart';
import 'package:mighty_school/feature/administrator/system_settings/presentation/widgets/style_widget.dart';
import 'package:mighty_school/feature/administrator/system_settings/presentation/widgets/system_settings_heading_section_widget.dart';
import 'package:mighty_school/util/dimensions.dart';

class SystemSettingScreen extends StatefulWidget {
  const SystemSettingScreen({super.key});

  @override
  State<SystemSettingScreen> createState() => _SystemSettingScreenState();
}

class _SystemSettingScreenState extends State<SystemSettingScreen> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: CustomAppBar(title: "system_setting".tr),
      body: CustomWebScrollView(slivers: [

         SliverToBoxAdapter(child: GetBuilder<SystemSettingsController>(
           builder: (systemSettingsController) {

             return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

              Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                child: CustomRoutePathWidget(title: "master_configuration".tr),
              ),
              const SystemSettingsHeadingSectionWidget(),
              if(systemSettingsController.settingsTypeIndex == 0)
              const SystemSettingWidget(),

               if(systemSettingsController.settingsTypeIndex == 1)
                 const SelectLogoWidget(),

               if(systemSettingsController.settingsTypeIndex == 2)
               Column(spacing: Dimensions.paddingSizeSmall, children: [
                 ColorPickerField(
                   initialColor: systemSettingsController.sidebarColor,
                   label: 'primary_color'.tr,
                   onChanged: (val){
                     int hexInt = val.toARGB32();
                     String hexColor = '0x${hexInt.toRadixString(16).padLeft(8, '0').toUpperCase()}';
                     log("Primary Color is ==> $hexColor");
                     systemSettingsController.updatePrimaryColor(hexColor);
                   },
                 ),
                 ColorPickerField(
                   initialColor: systemSettingsController.sidebarColor,
                   label: 'sidebar_color'.tr,
                   onChanged: (val){
                      int hexInt = val.toARGB32();
                      String hexColor = '0x${hexInt.toRadixString(16).padLeft(8, '0').toUpperCase()}';
                      log("Sidebar Color is ==> $hexColor");
                      systemSettingsController.updateSidebarColor(hexColor);
                   },
                 ),
                 ColorPickerField(
                   initialColor: systemSettingsController.sidebarTextColor,
                   label: 'sidebar_text_color'.tr,
                   onChanged: (val){
                      int hexInt = val.toARGB32();
                      String hexColor = '0x${hexInt.toRadixString(16).padLeft(8, '0').toUpperCase()}';
                      log("Sidebar Text Color is ==> $hexColor");
                      systemSettingsController.updateSidebarTextColor(hexColor);
                   },
                 ),
               ],),


             ],);
           }
         ),)
      ],),
    );
  }
}
