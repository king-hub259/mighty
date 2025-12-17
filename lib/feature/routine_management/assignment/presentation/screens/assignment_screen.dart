
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/common/widget/custom_floating_button.dart';
import 'package:mighty_school/feature/routine_management/assignment/presentation/screens/create_new_assignment_screen.dart';
import 'package:mighty_school/feature/routine_management/assignment/presentation/widgets/assignment_list_widget.dart';

class AssignmentScreen extends StatefulWidget {
  const AssignmentScreen({super.key});

  @override
  State<AssignmentScreen> createState() => _AssignmentScreenState();
}

class _AssignmentScreenState extends State<AssignmentScreen> {
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:CustomAppBar(title: "assignment".tr),
      body: CustomWebScrollView(controller: scrollController, slivers: [

        SliverToBoxAdapter(child: AssignmentListWidget(scrollController: scrollController),)
      ],),


      floatingActionButton: CustomFloatingButton(onTap: ()=> Get.to(() => const CreateNewAssignmentScreen()))
    );
  }
}



