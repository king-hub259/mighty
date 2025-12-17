
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/common/widget/section_header_with_path_widget.dart';
import 'package:mighty_school/feature/student_attendance_information/student_attendance/presentation/widgets/add_new_student_attendance_widget.dart';
import 'package:mighty_school/feature/student_attendance_information/student_attendance/presentation/widgets/student_list_for_attendance_widget.dart';

class StudentAttendanceScreen extends StatefulWidget {
  const StudentAttendanceScreen({super.key});

  @override
  State<StudentAttendanceScreen> createState() => _StudentAttendanceScreenState();
}

class _StudentAttendanceScreenState extends State<StudentAttendanceScreen> {
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "student_attendance".tr),
      body: CustomWebScrollView(controller: scrollController, slivers: [

        SliverToBoxAdapter(child: Column(children: [
          SectionHeaderWithPath(sectionTitle: "student_attendance_information".tr,
          pathItems: ["student_attendance".tr]),
          const StudentAttendanceFilterSection(),
          const StudentListForAttendanceWidget()
        ]))
      ],),
    );
  }
}



