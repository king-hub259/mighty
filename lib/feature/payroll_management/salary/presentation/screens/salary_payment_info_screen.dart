import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/feature/payroll_management/salary/presentation/widgets/salary_payment_info_list_widget.dart';

class SalaryPaymentInfoScreen extends StatefulWidget {
  const SalaryPaymentInfoScreen({super.key});

  @override
  State<SalaryPaymentInfoScreen> createState() => _SalaryPaymentInfoScreenState();
}

class _SalaryPaymentInfoScreenState extends State<SalaryPaymentInfoScreen> {
  ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "payment_info".tr),
      body: CustomWebScrollView(controller: scrollController, slivers: [
        SliverToBoxAdapter(
          child: SalaryPaymentInfoListWidget(scrollController: scrollController),
        ),
      ]),
    );
  }
}
