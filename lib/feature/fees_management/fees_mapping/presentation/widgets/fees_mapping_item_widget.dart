import 'package:flutter/material.dart';
import 'package:mighty_school/common/widget/confirmation_dialog.dart';
import 'package:mighty_school/common/widget/custom_image.dart';
import 'package:mighty_school/common/widget/custom_item_text_widget.dart';
import 'package:mighty_school/common/widget/numbering_widget.dart';
import 'package:mighty_school/feature/fees_management/fees_mapping/controller/fees_mapping_controller.dart';
import 'package:mighty_school/feature/fees_management/fees_mapping/domain/model/fees_mapping_model.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/images.dart';
import 'package:get/get.dart';

class FeesMappingItemWidget extends StatelessWidget {
  final FeesMappingItem feesMappingItem;
  final int index;
  const FeesMappingItemWidget({super.key, required this.feesMappingItem, required this.index});

  @override
  Widget build(BuildContext context) {
    return Row(spacing: Dimensions.paddingSizeDefault, children: [
      NumberingWidget(index: index),
      Expanded(child: CustomItemTextWidget(text: '${feesMappingItem.feeHead?.name}')),
      Expanded(child: CustomItemTextWidget(text: '${feesMappingItem.feeLedger?.ledgerName}')),

      IconButton(onPressed: (){
        Get.dialog(ConfirmationDialog(
          title: "fee_mapping".tr,
          content: "fee_mapping".tr,
            onTap: (){
          Get.find<FeesMappingController>().deleteFeesMapping(feesMappingItem.id!);
        }));
      }, icon: const CustomImage(image: Images.deleteIcon, height: 20, width: 20,))

    ],
    );
  }
}
