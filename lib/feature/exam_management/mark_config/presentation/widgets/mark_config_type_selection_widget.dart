import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/feature/exam_management/exam_startup/presentation/widgets/exam_startup_type_selection_widget.dart';
import 'package:mighty_school/feature/exam_management/mark_config/controller/mark_config_controller.dart';
import 'package:mighty_school/util/dimensions.dart';

class MarkConfigTypeSelectionWidget extends StatelessWidget {
  const MarkConfigTypeSelectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return  GetBuilder<MarkConfigController>(
      builder: (markConfigController) {
        return Row(children: [
          TypeSelectionWidget( onTap: () => markConfigController.setMarkConfigTypeIndex(0),
          title: "general_exam", selected: markConfigController.markConfigTypeIndex == 0),
          const SizedBox(width: Dimensions.paddingSizeDefault),

          TypeSelectionWidget( onTap: () => markConfigController.setMarkConfigTypeIndex(1),
              title: "grand_final", selected: markConfigController.markConfigTypeIndex == 1),
          const SizedBox(width: Dimensions.paddingSizeDefault),

          TypeSelectionWidget( onTap: () => markConfigController.setMarkConfigTypeIndex(2),
              title: "mark_config_view", selected: markConfigController.markConfigTypeIndex == 2),

        ],);
      }
    );
  }
}


