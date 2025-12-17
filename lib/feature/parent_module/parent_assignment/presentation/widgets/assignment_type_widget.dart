import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_type_button_widget.dart';
import 'package:mighty_school/feature/parent_module/parent_assignment/controller/parent_assignment_controller.dart';
import 'package:mighty_school/util/dimensions.dart';


class AssignmentTypeWidget extends StatelessWidget {
  const AssignmentTypeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ParentAssignmentController>(
        builder: (assignmentController) {
          return Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
            child: Row(spacing: Dimensions.paddingSizeSmall, children: [
              SizedBox(width: 120, child: CustomTypeButtonWidget(onTap: ()=> assignmentController.setSelectedAssignmentTypeIndex(0),
                  title: "assignment".tr, selected: assignmentController.selectedAssignmentTypeIndex == 0)),

              Expanded(child: CustomTypeButtonWidget(onTap: ()=> assignmentController.setSelectedAssignmentTypeIndex(1),
                  title: "submitted_assignment".tr, selected: assignmentController.selectedAssignmentTypeIndex == 1)),
            ]),
          );
        }
    );
  }
}
