import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/feature/students_information/student/presentation/widgets/all_student_list_widget.dart';

class AllStudentScreen extends StatefulWidget {
  const AllStudentScreen({super.key});

  @override
  State<AllStudentScreen> createState() => _AllStudentScreenState();
}

class _AllStudentScreenState extends State<AllStudentScreen> {
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(appBar: CustomAppBar(title: "all_students".tr),
    body: CustomWebScrollView(controller: scrollController,slivers: [

      SliverToBoxAdapter(child: AllStudentListWidget(scrollController: scrollController),)
    ],),
    );
  }
}
