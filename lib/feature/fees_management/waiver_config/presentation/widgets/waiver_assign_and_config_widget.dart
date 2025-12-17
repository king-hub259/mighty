import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_contaner.dart';
import 'package:mighty_school/feature/fees_management/waiver_config/controller/waiver_config_controller.dart';
import 'package:mighty_school/util/dimensions.dart';

class WaiverAssignAndConfigTypeWidget extends StatelessWidget {
  const WaiverAssignAndConfigTypeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return  GetBuilder<WaiverConfigController>(
        builder: (waiverConfigController) {
          return Row(children: [
            CustomContainer(color: Colors.transparent,borderRadius: Dimensions.paddingSizeExtraSmall, showShadow: false,
              onTap: () => waiverConfigController.setSelectedWaiverConfigTypeIndex(0),
              border: Border.all(color: waiverConfigController.waiverConfigTypeIndex == 0? Theme.of(context).hintColor : Colors.transparent),
              borderColor: waiverConfigController.waiverConfigTypeIndex == 0? Theme.of(context).hintColor : null,
              child: Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall, vertical: Dimensions.paddingSizeExtraSmall),
                child: Text("assign".tr),),),
            const SizedBox(width: Dimensions.paddingSizeDefault,),

            CustomContainer(color: Colors.transparent,borderRadius: Dimensions.paddingSizeExtraSmall, showShadow: false,
              onTap: () => waiverConfigController.setSelectedWaiverConfigTypeIndex(1),
              border: Border.all(color: waiverConfigController.waiverConfigTypeIndex == 1? Theme.of(context).hintColor : Colors.transparent),
              borderColor: waiverConfigController.waiverConfigTypeIndex == 1? Theme.of(context).hintColor : null,
              child: Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall, vertical: Dimensions.paddingSizeExtraSmall),
                child: Text("waiver_config_list".tr),),),
            const SizedBox(width: Dimensions.paddingSizeDefault,),

          ],);
        }
    );
  }
}
