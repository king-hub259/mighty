import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/confirmation_dialog.dart';
import 'package:mighty_school/common/widget/edit_delete_section.dart';
import 'package:mighty_school/common/widget/numbering_widget.dart';
import 'package:mighty_school/feature/exam_management/exam/controller/exam_controller.dart';
import 'package:mighty_school/feature/exam_management/exam/domain/model/exam_model.dart';
import 'package:mighty_school/feature/exam_management/exam/presentation/widgets/create_new_exam_dialog.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';

class ExamCardWidget extends StatelessWidget {
  final ExamItem? examItem;
  final int index;
  const ExamCardWidget({super.key, this.examItem, required this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.fromLTRB(Dimensions.paddingSizeDefault, Dimensions.paddingSizeDefault, Dimensions.paddingSizeDefault, 0),
      child: Row(spacing: Dimensions.paddingSizeDefault, crossAxisAlignment: CrossAxisAlignment.start, children: [

        NumberingWidget(index: index),
        Expanded(child: Text("${examItem?.name}", style: textRegular.copyWith())),
        Expanded(child: Text("${examItem?.examCode}", style: textRegular.copyWith())),
        EditDeleteSection(horizontal: true, onDelete: (){
          Get.dialog(ConfirmationDialog(title: "exam", content: "exam",
            onTap: (){
              Get.back();
              Get.find<ExamController>().deleteExam(examItem!.id!);
            },));

        }, onEdit: (){
          Get.dialog(CreateNewExamDialog(examItem: examItem));
        },)
      ],
      ),
    );
  }
}