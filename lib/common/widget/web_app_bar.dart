
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/controller/theme_controller.dart';
import 'package:mighty_school/common/widget/custom_contaner.dart';
import 'package:mighty_school/common/widget/text_hover.dart';
import 'package:mighty_school/feature/authentication/logic/authentication_controller.dart';
import 'package:mighty_school/feature/branch/presentation/widgets/branch_change_widget.dart';
import 'package:mighty_school/feature/academic_configuration/session/presentation/widgets/session_change_widget.dart';
import 'package:mighty_school/feature/language/presentation/screens/select_language_bottom_sheet.dart';
import 'package:mighty_school/feature/profile/logic/profile_controller.dart';
import 'package:mighty_school/feature/profile/presentation/widgets/header_profile_info_dropdown.dart';
import 'package:mighty_school/helper/route_helper.dart';
import 'package:mighty_school/localization/localization_controller.dart';
import 'package:mighty_school/util/app_constants.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/images.dart';
import 'package:mighty_school/util/styles.dart';
import 'package:mighty_school/feature/parent_module/parent_home/widget/appbar_header_widget_home_page.dart';

class WebAppBar extends StatelessWidget implements PreferredSizeWidget {
  const  WebAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(
      builder: (themeController) {
        return GetBuilder<LocalizationController>(
          builder: (localizationController) {
            return GetBuilder<ProfileController>(
              builder: (profileController) {
                String? userType = profileController.profileModel?.data?.role;
                return GetBuilder<AuthenticationController>(
                  builder: (authenticationController) {
                    return CustomContainer(borderRadius: Dimensions.paddingSizeExtraSmall, horizontalPadding: 20,verticalPadding: 20,
                      child: Row(spacing : Dimensions.paddingSizeDefault, children: [
                        const Spacer(),
                        if(userType == AppConstants.parent)...[
                          const ParentHeaderSectionWidget()
                        ],
                        if(userType != "SAAS Admin" && userType != AppConstants.parent && userType != AppConstants.studentType)
                        const SizedBox(width: 250, child: ChangeBranchWidget()),
                        if(userType != "SAAS Admin" && userType != AppConstants.parent && userType != AppConstants.studentType)
                        const SizedBox(width: 200, child: ChangeSessionWidget()),
                        MenuButtonWebIcon( icon: AppConstants.languages[localizationController.selectIndex].imageUrl, onTap: () {
                          showModalBottomSheet(backgroundColor: Colors.transparent,
                              isScrollControlled: true, context: context, builder: (_)=> const SelectLanguageBottomSheet());

                        }),
                        MenuButtonWebIcon( icon: Images.notification, onTap: () {
                         Get.toNamed(RouteHelper.getNoticeRoute());
                        }),
                        MenuButtonWebIcon( icon: Images.themes, onTap: () {
                          themeController.toggleTheme();
                        }),
                        // const SizedBox(width: 200, child: ChangeSessionWidget()),
                        const HeaderProfileInfoMenu()

                      ]),
                    );
                  }
                );
              }
            );
          }
        );
      }
    );
  }




  @override
  Size get preferredSize => const Size(Dimensions.webMaxWidth, 70);
}

class MenuButtonWebIcon extends StatelessWidget {
  final String? icon;
  final String? title;
  final bool isCart;
  final Function() onTap;
  const MenuButtonWebIcon({super.key, @required this.icon, this.isCart = false, required this.onTap, this.title});

  @override
  Widget build(BuildContext context) {
    return InkWell( onTap: onTap,
      child: Row(children: [Stack (clipBehavior: Clip.none, children: [
        if(title != null)
          Text(title!, style: textMedium.copyWith(fontSize: Dimensions.fontSizeSmall)),

        if(icon != null)
        Image.asset(icon!, height: Dimensions.iconSizeDefault)]),
        const SizedBox(width: Dimensions.paddingSizeExtraSmall),
      ]),
    );
  }
}

class MenuButtonWeb extends StatelessWidget {
  final String? title;
  final bool isCart;
  final Function() onTap;
  const MenuButtonWeb({super.key, @required this.title, this.isCart = false, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return TextHover(builder: (hovered){
        return Container(
          decoration: BoxDecoration(color:hovered ? Theme.of(context).colorScheme.primary.withValues(alpha: .1) : Colors.transparent,
            borderRadius: const BorderRadius.all(Radius.circular(Dimensions.radiusDefault))),
          child: InkWell(hoverColor: Colors.transparent,
            onTap: onTap,
            child: Padding(padding: const EdgeInsets.symmetric(vertical:Dimensions.paddingSizeSmall, horizontal: Dimensions.paddingSizeSmall),
              child: Text(title!, style: textMedium.copyWith(fontSize: Dimensions.fontSizeSmall))),
          ),
        );
      },
    );
  }
}



