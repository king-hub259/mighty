import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_contaner.dart';
import 'package:mighty_school/feature/exam_management/exam_startup/controller/exam_startup_controller.dart';
import 'package:mighty_school/util/dimensions.dart';

class ExamStartupTypeSelectionWidget extends StatelessWidget {
  const ExamStartupTypeSelectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return  GetBuilder<ExamStartupController>(
      builder: (examStartupController) {
        return Row(children: [
          TypeSelectionWidget( onTap: () => examStartupController.setSelectedTypeIndex(0),
          title: "exam_code", selected: examStartupController.examStartupTypeIndex == 0),
          const SizedBox(width: Dimensions.paddingSizeDefault),

          TypeSelectionWidget( onTap: () => examStartupController.setSelectedTypeIndex(1),
              title: "exam_grade", selected: examStartupController.examStartupTypeIndex == 1),
          const SizedBox(width: Dimensions.paddingSizeDefault),

          TypeSelectionWidget( onTap: () => examStartupController.setSelectedTypeIndex(2),
              title: "exam_create", selected: examStartupController.examStartupTypeIndex == 2),

        ],);
      }
    );
  }
}

class TypeSelectionWidget extends StatelessWidget {
  final Function()? onTap;
  final String title;
  final bool selected;
  const TypeSelectionWidget({super.key, this.onTap, required this.title, this.selected = false});

  @override
  Widget build(BuildContext context) {
    return CustomContainer(color: Colors.transparent,borderRadius: Dimensions.paddingSizeExtraSmall, showShadow: false,
        onTap: onTap, border: selected? Border.all(color: Theme.of(context).hintColor) : null,
        borderColor: selected? Theme.of(context).hintColor : null, verticalPadding: 5,
        child: Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall, vertical: Dimensions.paddingSizeExtraSmall),
            child: Text(title.tr)));
  }
}
