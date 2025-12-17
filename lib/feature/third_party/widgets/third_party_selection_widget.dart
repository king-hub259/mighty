import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_contaner.dart';
import 'package:mighty_school/feature/third_party/logic/third_party_controller.dart';
import 'package:mighty_school/helper/responsive_helper.dart';
import 'package:mighty_school/util/dimensions.dart';

class ThirdPartySelectionWidget extends StatelessWidget {
  const ThirdPartySelectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return  GetBuilder<ThirdPartyController>(
      builder: (thirdPartyController) {
        return Row(spacing: ResponsiveHelper.isDesktop(context)? Dimensions.paddingSizeDefault : 0, children: [
          CustomContainer(color: Colors.transparent,borderRadius: Dimensions.paddingSizeExtraSmall, showShadow: false,
            onTap: () => thirdPartyController.setThirdPartyType(0),
            border: Border.all(color: thirdPartyController.thirdPartyType == 0? Theme.of(context).hintColor : Colors.transparent),
            borderColor: thirdPartyController.thirdPartyType == 0? Theme.of(context).hintColor : null,

            child: Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall, vertical: Dimensions.paddingSizeExtraSmall),
              child: Text("live_class".tr),),),

          CustomContainer(color: Colors.transparent,borderRadius: Dimensions.paddingSizeExtraSmall, showShadow: false,
            onTap: () => thirdPartyController.setThirdPartyType(1),
            border: Border.all(color: thirdPartyController.thirdPartyType == 1? Theme.of(context).hintColor : Colors.transparent),
            borderColor: thirdPartyController.thirdPartyType == 1? Theme.of(context).hintColor : null,
            child: Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall, vertical: Dimensions.paddingSizeExtraSmall),
              child: Text("payment_gateway".tr),),),

          CustomContainer(color: Colors.transparent,borderRadius: Dimensions.paddingSizeExtraSmall, showShadow: false,
            onTap: () => thirdPartyController.setThirdPartyType(2),
            border: Border.all(color: thirdPartyController.thirdPartyType == 2? Theme.of(context).hintColor : Colors.transparent),
            borderColor: thirdPartyController.thirdPartyType == 2? Theme.of(context).hintColor : null,
            child: Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall, vertical: Dimensions.paddingSizeExtraSmall),
              child: Text("sms_gateway".tr),),),
          
        ],);
      }
    );
  }
}
