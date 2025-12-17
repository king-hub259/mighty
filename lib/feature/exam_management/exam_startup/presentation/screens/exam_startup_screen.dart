
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/feature/exam_management/exam_startup/presentation/widgets/exam_startup_widget.dart';

class ExamStartupScreen extends StatefulWidget {
  const ExamStartupScreen({super.key});

  @override
  State<ExamStartupScreen> createState() => _ExamStartupScreenState();
}

class _ExamStartupScreenState extends State<ExamStartupScreen> {
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: CustomAppBar(title: "exam_startup".tr),
      body: CustomWebScrollView(controller: scrollController, slivers: [
        SliverToBoxAdapter(child: ExamStartupWidget(scrollController: scrollController),)
      ],),

    );
  }
}



