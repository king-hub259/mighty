import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/feature/payroll_management/payroll_mapping/logic/payroll_mapping_controller.dart';
import 'package:mighty_school/feature/payroll_management/payroll_mapping/presentation/widgets/payroll_mapping_widget.dart';

class PayrollMappingScreen extends StatefulWidget {
  const PayrollMappingScreen({super.key});

  @override
  State<PayrollMappingScreen> createState() => _PayrollMappingScreenState();
}

class _PayrollMappingScreenState extends State<PayrollMappingScreen> {
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    Get.find<PayrollMappingController>().getPayrollMappingList(1);
    Get.find<PayrollMappingController>().getEmployeeList();
    Get.find<PayrollMappingController>().getSalaryHeadList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "payroll_mapping".tr),
      body: CustomWebScrollView(controller: scrollController, slivers: [

        SliverToBoxAdapter(
          child: PayrollMappingWidget(scrollController: scrollController),
        ),
      ]),
    );
  }
}