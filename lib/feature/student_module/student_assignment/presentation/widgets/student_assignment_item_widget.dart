import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/feature/student_module/student_assignment/domain/models/student_assignment_model.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';

class StudentAssignmentItemWidget extends StatelessWidget {
  final StudentAssignmentItem? assignmentItem;
  final int index;
  const StudentAssignmentItemWidget({super.key, this.assignmentItem, required this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault, vertical: 5),
      child: Row(
        children: [
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text("${"name".tr} : ${assignmentItem?.title}", style: textMedium.copyWith(fontSize: Dimensions.fontSizeDefault),),
              const SizedBox(height: Dimensions.paddingSizeSmall,),
              Text("${"details".tr} : ${assignmentItem?.description??''}", style: textRegular.copyWith(),),
            ]),
          ),
        ],
      ),
    );
  }
}