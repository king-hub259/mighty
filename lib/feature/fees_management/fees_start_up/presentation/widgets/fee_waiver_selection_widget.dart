import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_contaner.dart';
import 'package:mighty_school/feature/fees_management/fees_start_up/controller/fees_management_controller.dart';
import 'package:mighty_school/helper/responsive_helper.dart';
import 'package:mighty_school/util/dimensions.dart';

class FeeWaiverSelectionWidget extends StatelessWidget {
  const FeeWaiverSelectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return  GetBuilder<FeesManagementController>(
      builder: (feesController) {
        return Row(spacing: ResponsiveHelper.isDesktop(context)? Dimensions.paddingSizeDefault : 0, children: [
          CustomContainer(color: Colors.transparent,borderRadius: Dimensions.paddingSizeExtraSmall, showShadow: false,
            onTap: () => feesController.setSelectedTypeIndex(0),
            border: Border.all(color: feesController.feesStartupTypeIndex == 0? Theme.of(context).hintColor : Colors.transparent),
            borderColor: feesController.feesStartupTypeIndex == 0? Theme.of(context).hintColor : null,

            child: Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall, vertical: Dimensions.paddingSizeExtraSmall),
              child: Text("fee_head".tr),),),

          CustomContainer(color: Colors.transparent,borderRadius: Dimensions.paddingSizeExtraSmall, showShadow: false,
            onTap: () => feesController.setSelectedTypeIndex(1),
            border: Border.all(color: feesController.feesStartupTypeIndex == 1? Theme.of(context).hintColor : Colors.transparent),
            borderColor: feesController.feesStartupTypeIndex == 1? Theme.of(context).hintColor : null,
            child: Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall, vertical: Dimensions.paddingSizeExtraSmall),
              child: Text("fee_sub_head".tr),),),

          CustomContainer(color: Colors.transparent,borderRadius: Dimensions.paddingSizeExtraSmall, showShadow: false,
            onTap: () => feesController.setSelectedTypeIndex(2),
            border: Border.all(color: feesController.feesStartupTypeIndex == 2? Theme.of(context).hintColor : Colors.transparent),
            borderColor: feesController.feesStartupTypeIndex == 2? Theme.of(context).hintColor : null,
            child: Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall, vertical: Dimensions.paddingSizeExtraSmall),
              child: Text("fee_waiver".tr),),),
        ],);
      }
    );
  }
}
