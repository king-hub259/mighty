import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marquee/marquee.dart';
import 'package:mighty_school/common/widget/custom_image.dart';
import 'package:mighty_school/common/widget/side_sheet_widget.dart';
import 'package:mighty_school/common/widget/text_hover.dart';
import 'package:mighty_school/feature/landing_page/logic/landing_page_controller.dart';
import 'package:mighty_school/feature/landing_page/presentation/widgets/announcement_widget.dart';
import 'package:mighty_school/helper/responsive_helper.dart';
import 'package:mighty_school/localization/localization_controller.dart';
import 'package:mighty_school/util/app_constants.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/images.dart';
import 'package:mighty_school/util/styles.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';


class LandingPageAppBar extends StatelessWidget implements PreferredSizeWidget {
  final ItemScrollController itemScrollController;
  const LandingPageAppBar({super.key, required this.itemScrollController});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocalizationController>(
        builder: (languageController) {
          log("current_language:===>${AppConstants.languages[languageController.selectIndex].languageName}");
          return GetBuilder<LandingPageController>(
            builder: (landingPageController) {
              return AppBar(toolbarHeight: 100, titleSpacing: 0, backgroundColor: Theme.of(context).primaryColor,
                title: Container(decoration: BoxDecoration(boxShadow: ThemeShadow.getShadow(), color: Theme.of(context).cardColor),
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    const AnnouncementWidget(),

                    Center(child: Padding(
                      padding:  EdgeInsets.symmetric(vertical: 5, horizontal: ResponsiveHelper.isDesktop(context)? 0 : Dimensions.paddingSizeDefault),
                      child: SizedBox(width: Dimensions.webMaxWidth,
                        child: Row(spacing: Dimensions.paddingSizeSmall, mainAxisSize: MainAxisSize.min, children: [
                          InkWell(onTap: (){
                            itemScrollController.scrollTo(
                                index: 0,
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeInOutCubic);
                          }, child: CustomImage(image: Images.logo, localAsset: true, height: ResponsiveHelper.isDesktop(Get.context!)? 50 : 40)),
                          const Spacer(),

                          ResponsiveHelper.isDesktop(context)?
                          SizedBox(height: 50,
                            child: ListView.builder(
                                itemCount: landingPageController.menuList.length,
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index){
                                  return MenuButtonWeb(onTap: (){
                                    itemScrollController.scrollTo(
                                        index: index,
                                        duration: const Duration(milliseconds: 500),
                                        curve: Curves.easeInOutCubic);
                                  },
                                      title: landingPageController.menuList[index].tr);
                                }),
                          ):
                          InkWell(onTap: (){

                            showModalSideSheet(context,
                                barrierDismissible: true,
                                addBackIconButton: false,
                                addActions: false,
                                addDivider: false,
                                body: ListView.builder(
                                    itemCount: landingPageController.menuList.length,
                                    padding: const EdgeInsets.symmetric(horizontal: 10),
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index){
                                      return MenuButtonWeb(onTap: (){
                                        Get.back();
                                        itemScrollController.scrollTo(
                                            index: index,
                                            duration: const Duration(milliseconds: 500),
                                            curve: Curves.easeInOutCubic);
                                      },
                                          title: landingPageController.menuList[index].tr);
                                    }),
                                header: AppConstants.appName);
                          },
                              child: const CustomImage(image: Images.menuIcon, localAsset: true, height: 20)),
                        ]),
                      ),
                    )),
                  ],
                  ),
                ),
              );
            }
          );
        }
    );
  }




  @override
  Size get preferredSize => Size(Dimensions.webMaxWidth, ResponsiveHelper.isDesktop(Get.context!)? 100 : 90);
}


class MenuButtonWeb extends StatelessWidget {
  final String? title;
  final Function() onTap;
  const MenuButtonWeb({super.key, @required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return TextHover(builder: (hovered){
      return Container(
        decoration: BoxDecoration(color:hovered ? Theme.of(context).colorScheme.primary.withValues(alpha: .1) : Colors.transparent,
            borderRadius: const BorderRadius.all(Radius.circular(Dimensions.radiusSmall))),
        child: InkWell(hoverColor: Colors.transparent,
          onTap: onTap,
          child: Padding(padding: const EdgeInsets.symmetric(vertical:Dimensions.paddingSizeSmall,
              horizontal: Dimensions.paddingSizeDefault),
              child: Text(title!, style: textMedium.copyWith(fontSize: Dimensions.fontSizeExtraLarge))),
        ),
      );
    },
    );
  }
}



