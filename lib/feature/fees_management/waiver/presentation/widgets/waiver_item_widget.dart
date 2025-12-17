import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/confirmation_dialog.dart';
import 'package:mighty_school/common/widget/edit_delete_section.dart';
import 'package:mighty_school/common/widget/numbering_widget.dart';
import 'package:mighty_school/feature/fees_management/waiver/controller/waiver_controller.dart';
import 'package:mighty_school/feature/fees_management/waiver/domain/model/waiver_model.dart';
import 'package:mighty_school/feature/fees_management/waiver/presentation/screens/create_new_waiver_dialog.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';

class WaiverItemWidget extends StatelessWidget {
  final WaiverItem waiverItem;
  final int index;
  const WaiverItemWidget({super.key, required this.waiverItem, required this.index});

  @override
  Widget build(BuildContext context) {
    return Row(spacing: Dimensions.paddingSizeDefault, crossAxisAlignment: CrossAxisAlignment.start, children: [
      NumberingWidget(index: index),
      Expanded(child: Text('${waiverItem.waiver}', style: textRegular.copyWith())),
      EditDeleteSection(horizontal: true, onDelete: (){
        Get.dialog(ConfirmationDialog(title: "waiver", content: "waiver",
          onTap: (){
            Get.back();
            Get.find<WaiverController>().deleteWaiver(waiverItem.id!);
          },));

      }, onEdit: (){
        Get.dialog(CreateNewWaiverDialog(waiverItem: waiverItem));
      },)
    ],
    );
  }
}
