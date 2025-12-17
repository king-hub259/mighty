import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/feature/fees_management/paid_info/presentation/widgets/un_paid_report_list_widget.dart';

class UnPaidReportScreen extends StatefulWidget {
  const UnPaidReportScreen({super.key});

  @override
  State<UnPaidReportScreen> createState() => _UnPaidReportScreenState();
}

class _UnPaidReportScreenState extends State<UnPaidReportScreen> {
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: CustomAppBar(title: "unpaid_info".tr),
        body: CustomScrollView(controller: scrollController, slivers:  [
          SliverToBoxAdapter(child: UnPaidReportListWidget(scrollController: scrollController,))
        ],));
  }
}
