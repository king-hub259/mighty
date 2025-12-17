
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/feature/exam_management/mark_config/presentation/widgets/mark_config_widget.dart';

class MarkConfigScreen extends StatefulWidget {
  const MarkConfigScreen({super.key});

  @override
  State<MarkConfigScreen> createState() => _MarkConfigScreenState();
}

class _MarkConfigScreenState extends State<MarkConfigScreen> {
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: CustomAppBar(title: "mark_config".tr),
      body: CustomWebScrollView(controller: scrollController, slivers: [
        SliverToBoxAdapter(child: MarkConfigWidget(scrollController: scrollController),)
      ],),

    );
  }
}



