import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_contaner.dart';
import 'package:mighty_school/feature/fees_management/fees_mapping/controller/fees_mapping_controller.dart';
import 'package:mighty_school/util/dimensions.dart';

class FeesMappingTypeWidget extends StatelessWidget {
  const FeesMappingTypeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FeesMappingController>(
        builder: (feesController) {
          return Row(children: [
            CustomContainer(color: Colors.transparent,borderRadius: Dimensions.paddingSizeExtraSmall, showShadow: false,
              onTap: () => feesController.setSelectedTypeIndex(0),
              border: Border.all(color: feesController.feesStartupTypeIndex == 0? Theme.of(context).hintColor : Colors.transparent),
              borderColor: feesController.feesStartupTypeIndex == 0? Theme.of(context).hintColor : null,
              child: Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall, vertical: Dimensions.paddingSizeExtraSmall),
                child: Text("fee_mapping".tr),),),
            const SizedBox(width: Dimensions.paddingSizeDefault,),

            CustomContainer(color: Colors.transparent,borderRadius: Dimensions.paddingSizeExtraSmall, showShadow: false,
              onTap: () => feesController.setSelectedTypeIndex(1),
              border: Border.all(color: feesController.feesStartupTypeIndex == 1? Theme.of(context).hintColor : Colors.transparent),
              borderColor: feesController.feesStartupTypeIndex == 1? Theme.of(context).hintColor : null,
              child: Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall, vertical: Dimensions.paddingSizeExtraSmall),
                child: Text("fee_fine_mapping".tr),),),

          ],);
        }
    );
  }
}
