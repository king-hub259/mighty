import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/feature/payroll_management/payroll_assign/presentation/widgets/payroll_assign_list_widget.dart';

class PayrollAssignScreen extends StatefulWidget {
  const PayrollAssignScreen({super.key});

  @override
  State<PayrollAssignScreen> createState() => _PayrollAssignScreenState();
}

class _PayrollAssignScreenState extends State<PayrollAssignScreen> {
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "payroll_assign".tr),
      body: CustomWebScrollView(controller: scrollController, slivers: [
        SliverToBoxAdapter(
          child: PayrollAssignListWidget(scrollController: scrollController),
        ),
      ]),
    );
  }
}