import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/feature/student_attendance_information/student_attendance/presentation/widgets/student_list_for_attendance_widget.dart';

class StudentListForAttendance extends StatefulWidget {
  const StudentListForAttendance({super.key});

  @override
  State<StudentListForAttendance> createState() => _StudentListForAttendanceState();
}

class _StudentListForAttendanceState extends State<StudentListForAttendance> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "students".tr),
      body: const CustomWebScrollView(slivers: [
        SliverToBoxAdapter(child:StudentListForAttendanceWidget(),)
      ],),
    );
  }
}
