import 'dart:developer';

import 'package:mighty_school/common/global_widget/logo_section.dart';
import 'package:mighty_school/common/global_widget/sidebar_footer_section_widget.dart';
import 'package:mighty_school/common/widget/side_menu/easy_sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/feature/administrator/system_settings/controller/system_settngs_controller.dart';
import 'package:mighty_school/feature/profile/domain/model/profile_model.dart';
import 'package:mighty_school/feature/profile/logic/profile_controller.dart';
import 'package:mighty_school/feature/sidebar/controller/side_menu_bar_controller.dart';
import 'package:mighty_school/helper/responsive_helper.dart';
import 'package:mighty_school/util/app_constants.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';


class GlobalSideMenu extends StatefulWidget {
  final Widget child;
  const GlobalSideMenu({required this.child, super.key});

  @override
  State<GlobalSideMenu> createState() => _GlobalSideMenuState();
}

class _GlobalSideMenuState extends State<GlobalSideMenu> {
  SideMenuController sideMenu = SideMenuController();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SideMenuBarController>(
      builder: (sideMenuController) {
        return GetBuilder<SystemSettingsController>(
          builder: (systemSettingsController) {

            return Row(children: [
              GetBuilder<ProfileController>(
                builder: (profileController) {
                  ProfileModel? profileModel = profileController.profileModel;
                  String roleType = profileController.profileModel?.data?.role??'';
                  Color sidebarColor = roleType == AppConstants.sassAdmin? Theme.of(context).primaryColorDark: systemSettingsController.sidebarColor;
                  Color textColor =roleType == AppConstants.sassAdmin? Colors.white: systemSettingsController.sidebarTextColor;
                  log("role: ${profileModel?.data?.role}");
                  return  ResponsiveHelper.isDesktop(context)?
                  SideMenu(
                      controller: sideMenuController.sideMenu,
                      style: SideMenuStyle(
                          itemOuterPadding: EdgeInsets.zero,
                          itemBorderRadius: BorderRadius.zero,
                          openSideMenuWidth: sideMenuController.isExpanded ? 265 : 0,
                          selectedTitleTextStyleExpandable: textRegular.copyWith(color: textColor, fontSize: Dimensions.fontSizeDefault),
                          selectedIconColorExpandable: Theme.of(context).primaryColor,
                          unselectedIconColorExpandable: textColor,
                          displayMode: SideMenuDisplayMode.auto,
                          toggleColor: textColor,
                          arrowCollapse: textColor,
                          arrowOpen: Theme.of(context).cardColor,
                          hoverColor: Theme.of(context).colorScheme.secondary,
                          selectedColor: Theme.of(context).primaryColor,
                          selectedTitleTextStyle: textRegular.copyWith(color: textColor, fontSize: Dimensions.fontSizeSmall),
                          selectedIconColor: Theme.of(context).textTheme.displayLarge?.color,
                          unselectedIconColor: textColor,
                          unselectedTitleTextStyle: textRegular.copyWith(color: textColor, fontSize: Dimensions.fontSizeSmall),
                          showHamburger: false,

                          backgroundColor: sidebarColor),
                      title:  LogoSection(roleType:profileModel?.data?.role??''),
                      footer: SidebarFooterSectionWidget(roleType: profileModel?.data?.role??''),
                      items: sideMenuController.sideMenuItems):const SizedBox();
                }
              ),
                Expanded(child: widget.child),
              ],
            );
          }
        );
      },
    );
  }
}