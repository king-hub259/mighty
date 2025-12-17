import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/feature/landing_page/logic/landing_page_controller.dart';
import 'package:mighty_school/util/styles.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class FooterQuickLinkWidget extends StatelessWidget {
  final ItemScrollController itemScrollController;
  const FooterQuickLinkWidget({super.key, required this.itemScrollController});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LandingPageController>(
        builder: (landingPageController) {
          return ListView.builder(
              itemCount: landingPageController.menuList.length,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index){
                return TextButton( onPressed: (){
                  itemScrollController.scrollTo(
                      index: index,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOutCubic);
                },
                    child: Text(landingPageController.menuList[index].tr, style: textRegular.copyWith(color: Colors.white)));
              });
        });
  }
}
