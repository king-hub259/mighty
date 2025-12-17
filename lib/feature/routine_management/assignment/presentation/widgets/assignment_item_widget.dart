import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/confirmation_dialog.dart';
import 'package:mighty_school/common/widget/custom_contaner.dart';
import 'package:mighty_school/common/widget/edit_delete_section.dart';
import 'package:mighty_school/feature/routine_management/assignment/controller/assignment_controller.dart';
import 'package:mighty_school/feature/routine_management/assignment/domain/models/assignment_model.dart';
import 'package:mighty_school/feature/routine_management/assignment/presentation/screens/create_new_assignment_screen.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';

class AssignmentItemWidget extends StatelessWidget {
  final AssignmentItem? assignmentItem;
  final int index;
  const AssignmentItemWidget({super.key, this.assignmentItem, required this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault, vertical: 5),
      child: CustomContainer(child: Row(
        children: [
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text("${"name".tr} : ${assignmentItem?.title}", style: textMedium.copyWith(fontSize: Dimensions.fontSizeDefault),),
              const SizedBox(height: Dimensions.paddingSizeSmall,),
              Text("${"details".tr} : ${assignmentItem?.description??''}", style: textRegular.copyWith(),),
            ]),
          ),
          EditDeleteSection(onEdit: (){
            Get.to(() =>  CreateNewAssignmentScreen(assignmentItem: assignmentItem));
          },
            onDelete: (){
              Get.dialog(ConfirmationDialog(
                title: "assignment",
                content: "assignment",
                onTap: (){
                  Get.back();
                  Get.find<AssignmentController>().deleteAssignment(assignmentItem!.id!);
                },));

          },)
        ],
      )),
    );
  }
}