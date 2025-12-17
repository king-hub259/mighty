import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/confirmation_dialog.dart';
import 'package:mighty_school/common/widget/edit_delete_section.dart';
import 'package:mighty_school/common/widget/numbering_widget.dart';
import 'package:mighty_school/feature/fees_management/fees_head/controller/fees_head_controller.dart';
import 'package:mighty_school/feature/fees_management/fees_head/domain/model/fees_head_model.dart';
import 'package:mighty_school/feature/fees_management/fees_head/presentation/screens/create_new_fees_head_dialog.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';

class FeesHeadItemWidget extends StatelessWidget {
  final FeesHeadItem feesHeadItem;
  final int index;
  const FeesHeadItemWidget({super.key, required this.feesHeadItem, required this.index});

  @override
  Widget build(BuildContext context) {
    return Row(spacing: Dimensions.paddingSizeDefault, crossAxisAlignment: CrossAxisAlignment.start, children: [

      NumberingWidget(index: index),
      Expanded(child: Text('${feesHeadItem.name}', style: textRegular.copyWith())),
      Expanded(child: Text('${feesHeadItem.serial}', style: textRegular.copyWith())),
      EditDeleteSection(horizontal: true, onDelete: (){
        Get.dialog(ConfirmationDialog(title: "fees_head", content: "fees_head",
          onTap: (){
            Get.back();
            Get.find<FeesHeadController>().deleteFeesHead(feesHeadItem.id!);
          },));

      }, onEdit: (){
        Get.dialog(CreateNewFeesHeadDialog(feesHeadItem: feesHeadItem));
      },)
    ],
    );
  }
}
