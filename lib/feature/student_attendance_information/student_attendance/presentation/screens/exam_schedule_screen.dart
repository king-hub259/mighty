import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/common/widget/section_header_with_path_widget.dart';
import 'package:mighty_school/feature/student_attendance_information/student_attendance/presentation/widgets/exam_schedule_widget.dart';

class ExamScheduleScreen extends StatefulWidget {

  const ExamScheduleScreen({super.key});

  @override
  State<ExamScheduleScreen> createState() => _ExamScheduleScreenState();
}

class _ExamScheduleScreenState extends State<ExamScheduleScreen> {
  ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "exam_schedule".tr),
      body: CustomWebScrollView(controller: scrollController, slivers: [

        SliverToBoxAdapter(child: Column(children: [
          SectionHeaderWithPath(sectionTitle: "student_attendance_information".tr,
              pathItems: ["exam_schedule".tr]),
          const ExamScheduleWidget()
        ]))
      ],),
    );
  }
}
