import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_contaner.dart';
import 'package:mighty_school/feature/cms_management/policy_pages/logic/pages_controller.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';

class PolicyPagesTypeWidget extends StatelessWidget {
  const PolicyPagesTypeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PagesController>(
      builder: (pagesController) {
        return Row(spacing: Dimensions.paddingSizeDefault, children: [
          CustomContainer(borderRadius: 5, onTap: (){
            pagesController.setSelectedPageIndex(0);
          }, color: pagesController.selectedPageIndex == 0? Theme.of(context).primaryColor :Theme.of(context).hintColor,
              child: Text("privacy_policy".tr, style: textRegular.copyWith(color : pagesController.selectedPageIndex == 0? Colors.white : null),)),
          CustomContainer(borderRadius: 5,onTap: (){
            pagesController.setSelectedPageIndex(1);
          }, color: pagesController.selectedPageIndex == 1? Theme.of(context).primaryColor :Theme.of(context).hintColor,
              child: Text("cookie_policy".tr, style: textRegular.copyWith(color : pagesController.selectedPageIndex == 0? Colors.white : null))),
          CustomContainer(borderRadius: 5, onTap: (){
            pagesController.setSelectedPageIndex(2);
          }, color: pagesController.selectedPageIndex == 2? Theme.of(context).primaryColor :Theme.of(context).hintColor,
              child: Text("terms_and_condition".tr, style: textRegular.copyWith(color : pagesController.selectedPageIndex == 0? Colors.white : null))),
        ]);
      }
    );
  }
}
