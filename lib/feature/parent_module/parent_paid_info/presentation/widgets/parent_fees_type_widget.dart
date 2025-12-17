import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_type_button_widget.dart';
import 'package:mighty_school/feature/parent_module/parent_paid_info/controller/parent_paid_info_controller.dart';
import 'package:mighty_school/util/dimensions.dart';


class ParentFeesTypeWidget extends StatelessWidget {
  const ParentFeesTypeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ParentPaidInfoController>(
        builder: (paidInfoController) {
          return Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
            child: Row(spacing: Dimensions.paddingSizeSmall, children: [
              Expanded(child: CustomTypeButtonWidget(onTap: ()=> paidInfoController.setSelectedFeesTypeIndex(0),
                  title: "paid_fees".tr, selected: paidInfoController.selectedFeesTypeIndex == 0)),

              Expanded(child: CustomTypeButtonWidget(onTap: ()=> paidInfoController.setSelectedFeesTypeIndex(1),
                  title: "unpaid_fees".tr, selected: paidInfoController.selectedFeesTypeIndex == 1)),
            ]),
          );
        }
    );
  }
}
