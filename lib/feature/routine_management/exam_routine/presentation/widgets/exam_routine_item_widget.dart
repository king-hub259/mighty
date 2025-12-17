import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_divider.dart';
import 'package:mighty_school/common/widget/custom_text_field.dart';
import 'package:mighty_school/feature/routine_management/exam_routine/domain/model/exam_routine_model.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';

class ExamRoutineItemWidget extends StatelessWidget {
  final ExamRoutineItem? examRoutineItem;
  final int index;
  const ExamRoutineItemWidget({super.key, this.examRoutineItem, required this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.fromLTRB(Dimensions.paddingSizeDefault, Dimensions.paddingSizeDefault, Dimensions.paddingSizeDefault, 0),
      child: Column(children: [
          Row(spacing: Dimensions.paddingSizeSmall, children: [
            Expanded(child: Text('${examRoutineItem?.subjectName}', style: textRegular.copyWith())),
             Expanded(child: CustomTextField(hintText: "select".tr)),
             Expanded(child: CustomTextField(hintText: "start_time".tr,)),
             Expanded(child: CustomTextField(hintText: "end_time".tr)),
             Expanded(child: CustomTextField(hintText: "room".tr)),

          ],
          ),
          const CustomDivider(verticalPadding: Dimensions.paddingSizeExtraSmall)
        ],
      ),
    );
  }
}
