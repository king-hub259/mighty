import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/edit_delete_section.dart';
import 'package:mighty_school/common/widget/numbering_widget.dart';
import 'package:mighty_school/feature/academic_configuration/shift/controller/shift_controller.dart';
import 'package:mighty_school/feature/academic_configuration/shift/domain/models/shift_model.dart';
import 'package:mighty_school/feature/academic_configuration/shift/presentation/screens/create_new_shift_screen.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';

class ShiftItemWidget extends StatelessWidget {
  final ShiftItem? shiftItem;
  final int index;
  const ShiftItemWidget({super.key, this.shiftItem, required this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault, vertical: Dimensions.paddingSizeSeven),
      child: Row(spacing: Dimensions.paddingSizeDefault, children: [
        NumberingWidget(index: index),
        Expanded(child: Text("${shiftItem?.name}", style: textMedium.copyWith(fontSize: Dimensions.fontSizeDefault))),
        EditDeleteSection(horizontal: true, onEdit: (){
          Get.dialog(CreateNewShiftScreen(shiftItem: shiftItem));
        },
          onDelete: (){
            Get.find<ShiftController>().deleteShift(shiftItem!.id!);
          },)
      ],
      ),
    );
  }
}