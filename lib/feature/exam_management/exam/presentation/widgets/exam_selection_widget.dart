import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_title.dart';
import 'package:mighty_school/feature/exam_management/exam/controller/exam_controller.dart';
import 'package:mighty_school/feature/exam_management/exam/presentation/widgets/exam_dropdown.dart';

class ExamSelectionWidget extends StatefulWidget {
  const ExamSelectionWidget({super.key});

  @override
  State<ExamSelectionWidget> createState() => _ExamSelectionWidgetState();
}

class _ExamSelectionWidgetState extends State<ExamSelectionWidget> {
  @override
  void initState() {
    if(Get.find<ExamController>().examModel == null){
      Get.find<ExamController>().getExamList(1);
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const CustomTitle(title: "exam"),
      GetBuilder<ExamController>(
          builder: (examController) {
            return Padding(padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: ExamDropdown(width: Get.width, title: "select".tr,
                items: examController.examModel?.data?.data??[],
                selectedValue: examController.selectedExamItem,
                onChanged: (val){
                  examController.selectExam(val!);
                },
              ),);
          }
      ),
    ],);
  }
}
