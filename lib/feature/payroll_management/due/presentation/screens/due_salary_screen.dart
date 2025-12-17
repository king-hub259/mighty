import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/feature/staff_information/staff/presentation/widgets/staff_list_widget.dart';

class DueSalaryScreen extends StatefulWidget {
  const DueSalaryScreen({super.key});

  @override
  State<DueSalaryScreen> createState() => _DueSalaryScreenState();
}

class _DueSalaryScreenState extends State<DueSalaryScreen> {
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "due_salary".tr),
      body: CustomWebScrollView(controller: scrollController, slivers: [
        SliverToBoxAdapter(
          child: StaffListWidget(showHeading: false, scrollController: scrollController),
        ),
      ]),
    );
  }
}
