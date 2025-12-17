import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/feature/exam_management/mark_input/presentation/widgets/mark_input_widget.dart';

class MarkInputScreen extends StatefulWidget {
  const MarkInputScreen({super.key});

  @override
  State<MarkInputScreen> createState() => _MarkInputScreenState();
}

class _MarkInputScreenState extends State<MarkInputScreen> {
  ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: CustomAppBar(title: "mark_input".tr),
      body: CustomWebScrollView(controller: scrollController, slivers: [
        SliverToBoxAdapter(child: MarkInputWidget(scrollController: scrollController,))
      ],),
    );
  }
}
