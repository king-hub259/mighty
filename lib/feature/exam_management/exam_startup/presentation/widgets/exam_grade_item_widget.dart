import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_divider.dart';
import 'package:mighty_school/feature/exam_management/exam_startup/controller/exam_startup_controller.dart';
import 'package:mighty_school/feature/exam_management/exam_startup/domain/model/exam_grade_model.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';

class ExamGradeItemWidget extends StatelessWidget {
  final ExamGradeItem? examGradeItem;
  final int index;
  const ExamGradeItemWidget({super.key, this.examGradeItem, required this.index});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
        Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault, vertical: Dimensions.paddingSizeSeven),
          child: Row(children: [
              SizedBox(width: 15, height: 15, child: Checkbox(value: examGradeItem?.isSelected??false,
                  onChanged: (val){
                Get.find<ExamStartupController>().toggleExamGrade(index);
                  })),
              const SizedBox(width: Dimensions.paddingSizeSmall),
              Expanded(child: Text("${examGradeItem?.gradeName}", style: textMedium.copyWith(fontSize: Dimensions.fontSizeDefault),)),
            const SizedBox(width: Dimensions.paddingSizeSmall),

            Expanded(child: Text("${examGradeItem?.gradeRange}", style: textMedium.copyWith(fontSize: Dimensions.fontSizeDefault),)),
            const SizedBox(width: Dimensions.paddingSizeSmall),
            ],
          ),
        ),
        const Padding(padding: EdgeInsets.symmetric(vertical: Dimensions.paddingSizeExtraSmall),
          child: CustomDivider()),
      ],
    );
  }
}