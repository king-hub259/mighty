import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_contaner.dart';
import 'package:mighty_school/feature/academic_configuration/class/presentation/widgets/select_class_widget.dart';
import 'package:mighty_school/feature/exam_management/exam_startup/controller/exam_startup_controller.dart';
import 'package:mighty_school/feature/exam_management/exam_startup/presentation/widgets/exam_assign_submit_button_widget.dart';
import 'package:mighty_school/feature/exam_management/exam_startup/presentation/widgets/exam_grade_list_widget.dart';
import 'package:mighty_school/feature/exam_management/exam_startup/presentation/widgets/exam_short_code_list_widget.dart';
import 'package:mighty_school/feature/exam_management/exam_startup/presentation/widgets/exam_startup_type_selection_widget.dart';
import 'package:mighty_school/feature/exam_management/exam_startup/presentation/widgets/selection_exam_widget.dart';
import 'package:mighty_school/feature/exam_management/exam_startup/presentation/widgets/selection_merit_type_widget.dart';
import 'package:mighty_school/util/dimensions.dart';

class ExamStartupWidget extends StatefulWidget {
  final ScrollController scrollController;
  const ExamStartupWidget({super.key, required this.scrollController});

  @override
  State<ExamStartupWidget> createState() => _ExamStartupWidgetState();
}

class _ExamStartupWidgetState extends State<ExamStartupWidget> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ExamStartupController>(
      builder: (examStartupController) {
        return CustomContainer(borderRadius: Dimensions.paddingSizeExtraSmall,
            child: Column(spacing: Dimensions.paddingSizeDefault, children: [
              const ExamStartupTypeSelectionWidget(),
              const SelectClassWidget(),
              if(examStartupController.examStartupTypeIndex == 0)...[
                ExamShortCodeListWidget(scrollController: widget.scrollController),
              ]else if(examStartupController.examStartupTypeIndex == 1)...[
                ExamGradeListWidget(scrollController: widget.scrollController),
                ]else ...[

                 const Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Expanded(child: SelectionExamWidget()),
                  SizedBox(width: Dimensions.paddingSizeSmall),
                  Expanded(child: SelectionMeritProcessTypeWidget()),
                   SizedBox(width: Dimensions.paddingSizeSmall),
                   ExamAssignSubmitButtonWidget(),


                ],),
              ],

            ],));
      }
    );
  }
}
