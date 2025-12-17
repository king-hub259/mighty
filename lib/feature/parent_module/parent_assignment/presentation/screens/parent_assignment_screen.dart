
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/common/widget/custom_delegate.dart';
import 'package:mighty_school/feature/parent_module/parent_assignment/controller/parent_assignment_controller.dart';
import 'package:mighty_school/feature/parent_module/parent_assignment/presentation/widgets/assignment_type_widget.dart';
import 'package:mighty_school/feature/parent_module/parent_assignment/presentation/widgets/parent_assignment_list_widget.dart';
import 'package:mighty_school/feature/parent_module/parent_assignment/presentation/widgets/submitted_assignment_list_widget.dart';

class ParentAssignmentScreen extends StatefulWidget {
  const ParentAssignmentScreen({super.key});
  @override
  State<ParentAssignmentScreen> createState() => _ParentAssignmentScreenState();
}

class _ParentAssignmentScreenState extends State<ParentAssignmentScreen> {
  ScrollController scrollController = ScrollController();
  @override
  void initState() {
    Get.find<ParentAssignmentController>().getMyAssignmentList(1);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "assignment".tr,),
      body: GetBuilder<ParentAssignmentController>(
        builder: (assignmentController) {
          return CustomWebScrollView(controller: scrollController, slivers: [
            SliverPersistentHeader(pinned: true,floating: true, delegate: SliverDelegate(height: 70,
                child: const AssignmentTypeWidget())),
            SliverToBoxAdapter(child: assignmentController.selectedAssignmentTypeIndex ==0?
            ParentAssignmentListWidget(scrollController: scrollController) : SubmittedAssignmentListWidget(scrollController: scrollController))
          ],);
        }
      ),
    );
  }
}



