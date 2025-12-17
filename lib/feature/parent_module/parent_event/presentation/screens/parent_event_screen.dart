
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/feature/parent_module/parent_event/presentation/widgets/parent_event_list_widget.dart';

class ParentEventScreen extends StatefulWidget {
  const ParentEventScreen({super.key});

  @override
  State<ParentEventScreen> createState() => _ParentEventScreenState();
}

class _ParentEventScreenState extends State<ParentEventScreen> {
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "events".tr),
      body: CustomWebScrollView(controller: scrollController, slivers: [

        SliverToBoxAdapter(child: ParentEventListWidget(scrollController: scrollController))
      ],),

    );
  }
}



