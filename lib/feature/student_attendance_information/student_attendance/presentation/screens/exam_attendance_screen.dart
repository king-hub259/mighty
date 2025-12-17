import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/common/widget/section_header_with_path_widget.dart';
import 'package:mighty_school/feature/student_attendance_information/student_attendance/presentation/widgets/exam_attendance_widget.dart';
import 'package:mighty_school/feature/student_attendance_information/student_attendance/presentation/widgets/student_list_for_attendance_widget.dart';

class ExamAttendanceScreen extends StatefulWidget {

  const ExamAttendanceScreen({super.key});

  @override
  State<ExamAttendanceScreen> createState() => _ExamAttendanceScreenState();
}

class _ExamAttendanceScreenState extends State<ExamAttendanceScreen> {
  ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "exam_attendance".tr),
      body: CustomWebScrollView(controller: scrollController, slivers: [

        SliverToBoxAdapter(child: Column(children: [
          SectionHeaderWithPath(sectionTitle: "student_attendance_information".tr,
              pathItems: ["exam_attendance".tr]),
          const ExamAttendanceWidget(),
          const StudentListForAttendanceWidget()
        ]))
      ],),
    );
  }
}
