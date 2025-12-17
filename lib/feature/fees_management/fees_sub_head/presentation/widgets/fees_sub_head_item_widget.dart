import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/confirmation_dialog.dart';
import 'package:mighty_school/common/widget/edit_delete_section.dart';
import 'package:mighty_school/common/widget/numbering_widget.dart';
import 'package:mighty_school/feature/fees_management/fees_sub_head/controller/fees_sub_head_controller.dart';
import 'package:mighty_school/feature/fees_management/fees_sub_head/domain/model/fees_sub_head_model.dart';
import 'package:mighty_school/feature/fees_management/fees_sub_head/presentation/screens/create_new_fees_sub_head_dialog.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';

class FeesSubHeadItemWidget extends StatelessWidget {
  final FeesSubHeadItem feesSubHeadItem;
  final int index;
  const FeesSubHeadItemWidget({super.key, required this.feesSubHeadItem, required this.index});

  @override
  Widget build(BuildContext context) {
    return Row(spacing: Dimensions.paddingSizeDefault, crossAxisAlignment: CrossAxisAlignment.start, children: [
      NumberingWidget(index: index),
      Expanded(child: Text('${feesSubHeadItem.name}', style: textRegular.copyWith())),
      Expanded(child: Text('${feesSubHeadItem.serial}', style: textRegular.copyWith())),
      EditDeleteSection(horizontal: true, onDelete: (){
        Get.dialog(ConfirmationDialog(title: "fees_sub_head", content: "fees_sub_head",
          onTap: (){
            Get.back();
            Get.find<FeesSubHeadController>().deleteFeesSubHead(feesSubHeadItem.id!);
          },));

      }, onEdit: (){
        Get.dialog(CreateNewFeesSubHeadDialog(feesSubHeadItem: feesSubHeadItem));
      },)
    ],
    );
  }
}
