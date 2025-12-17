
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/feature/payroll_management/payroll_start_up/logic/payroll_start_up_controller.dart';
import 'package:mighty_school/feature/payroll_management/payroll_start_up/presentation/widgets/salary_head_list_widget.dart';

class PayrollStartUpScreen extends StatefulWidget {
  const PayrollStartUpScreen({super.key});

  @override
  State<PayrollStartUpScreen> createState() => _PayrollStartUpScreenState();
}

class _PayrollStartUpScreenState extends State<PayrollStartUpScreen> {
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    Get.find<PayrollStartUpController>().getSalaryHeadList(1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "salary_head_setup".tr),
      body: CustomWebScrollView(controller: scrollController, slivers: [

        SliverToBoxAdapter(
          child: SalaryHeadListWidget(scrollController: scrollController),
        ),
      ]),
    );
  }
}



