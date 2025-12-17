import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/feature/routine_management/assignment/domain/models/assignment_model.dart';
import 'package:mighty_school/feature/routine_management/assignment/presentation/widgets/create_new_assignment_widget.dart';
import 'package:mighty_school/util/dimensions.dart';

class CreateNewAssignmentScreen extends StatefulWidget {
  final AssignmentItem? assignmentItem;
  const CreateNewAssignmentScreen({super.key, this.assignmentItem});

  @override
  State<CreateNewAssignmentScreen> createState() => _CreateNewAssignmentScreenState();
}

class _CreateNewAssignmentScreenState extends State<CreateNewAssignmentScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title:  widget.assignmentItem != null? "update_assignment" : "add_new_Assignment".tr,),
      body:CustomWebScrollView(slivers: [
        SliverToBoxAdapter(child:  Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
          child: CreateNewAssignmentWidget(assignmentItem: widget.assignmentItem,),
        ))
      ],),
    );
  }
}
