import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/confirmation_dialog.dart';
import 'package:mighty_school/common/widget/edit_delete_section.dart';
import 'package:mighty_school/common/widget/numbering_widget.dart';
import 'package:mighty_school/feature/academic_configuration/period/controller/period_controller.dart';
import 'package:mighty_school/feature/academic_configuration/period/domain/model/period_model.dart';
import 'package:mighty_school/feature/academic_configuration/period/presentation/screens/create_new_period_dialog.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';

class PeriodWidget extends StatelessWidget {
  final PeriodItem? periodItem;
  final int index;
  const PeriodWidget({super.key, this.periodItem, required this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.fromLTRB(Dimensions.paddingSizeDefault, Dimensions.paddingSizeDefault, Dimensions.paddingSizeDefault, 0),
      child: Row(spacing: Dimensions.paddingSizeDefault, crossAxisAlignment: CrossAxisAlignment.start, children: [

        NumberingWidget(index: index),
        Expanded(child: Text('${periodItem?.period}', style: textRegular.copyWith())),
        EditDeleteSection(horizontal: true, onDelete: (){
          Get.dialog(ConfirmationDialog(title: "period", content: "period",
            onTap: (){
              Get.back();
              Get.find<PeriodController>().deletePeriod(periodItem!.id!);
            },));

        }, onEdit: (){
          Get.dialog(CreateNewPeriodScreen(periodItem: periodItem));
        },)
      ],
      ),
    );
  }
}
