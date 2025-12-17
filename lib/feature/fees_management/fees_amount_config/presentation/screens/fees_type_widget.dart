import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_contaner.dart';
import 'package:mighty_school/feature/fees_management/fees_amount_config/controller/fees_controller.dart';
import 'package:mighty_school/util/dimensions.dart';

class FeesTypeWidget extends StatelessWidget {
  const FeesTypeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FeesController>(
        builder: (feesController) {
          return Row(children: [
            CustomContainer(color: Colors.transparent,borderRadius: Dimensions.paddingSizeExtraSmall, showShadow: false,
              onTap: () => feesController.setSelectedFeesTypeIndex(0),
              border: Border.all(color: feesController.feesTypeIndex == 0? Theme.of(context).hintColor : Colors.transparent),
              borderColor: feesController.feesTypeIndex == 0? Theme.of(context).hintColor : null,
              child: Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall, vertical: Dimensions.paddingSizeExtraSmall),
                child: Text("fee_amount".tr),),),
            const SizedBox(width: Dimensions.paddingSizeDefault,),

            CustomContainer(color: Colors.transparent,borderRadius: Dimensions.paddingSizeExtraSmall, showShadow: false,
              onTap: () => feesController.setSelectedFeesTypeIndex(1),
              border: Border.all(color: feesController.feesTypeIndex == 1? Theme.of(context).hintColor : Colors.transparent),
              borderColor: feesController.feesTypeIndex == 1? Theme.of(context).hintColor : null,
              child: Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall, vertical: Dimensions.paddingSizeExtraSmall),
                child: Text("absent_fine_amount".tr),),),

          ],);
        }
    );
  }
}
