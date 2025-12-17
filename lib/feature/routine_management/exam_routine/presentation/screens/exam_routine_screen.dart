import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/feature/routine_management/exam_routine/presentation/widgets/exam_routine_widget.dart';

class ExamRoutineScreen extends StatefulWidget {
  const ExamRoutineScreen({super.key});

  @override
  State<ExamRoutineScreen> createState() => _ExamRoutineScreenState();
}

class _ExamRoutineScreenState extends State<ExamRoutineScreen> {
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: CustomAppBar(title: "exam_schedule".tr),
    body: CustomWebScrollView(controller: scrollController, slivers:  const [
      SliverToBoxAdapter(child: ExamRoutineWidget())
    ],),
    );
  }
}
