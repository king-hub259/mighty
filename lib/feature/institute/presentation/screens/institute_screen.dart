
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/feature/institute/presentation/widgets/institute_list_widget.dart';

class InstituteScreen extends StatefulWidget {
  const InstituteScreen({super.key});

  @override
  State<InstituteScreen> createState() => _InstituteScreenState();
}

class _InstituteScreenState extends State<InstituteScreen> {
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: CustomAppBar(title: "institute_list".tr),
      body: CustomWebScrollView(controller: scrollController, slivers: [

        SliverToBoxAdapter(child: InstituteListWidget(scrollController: scrollController,))
      ]),
    );
  }
}



