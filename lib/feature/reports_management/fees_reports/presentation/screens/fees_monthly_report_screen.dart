import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/feature/reports_management/fees_reports/logic/fees_reports_controller.dart';
import 'package:mighty_school/feature/reports_management/fees_reports/presentation/widgets/fees_monthly_report_list_widget.dart';
import 'package:mighty_school/feature/reports_management/fees_reports/presentation/widgets/select_year_and_month_widget.dart';
import 'package:mighty_school/util/dimensions.dart';

class FeesMonthlyReportScreen extends StatefulWidget {
  const FeesMonthlyReportScreen({super.key});

  @override
  State<FeesMonthlyReportScreen> createState() => _FeesMonthlyReportScreenState();
}

class _FeesMonthlyReportScreenState extends State<FeesMonthlyReportScreen> {
  @override
  void initState() {
    super.initState();

    if (Get.find<FeesReportsController>().feesMonthlyReportModel == null) {
      Get.find<FeesReportsController>().getMonthlyReport();
    }
  }
  ScrollController scrollController = ScrollController();

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "monthly_fees_report".tr),
      body: CustomWebScrollView(slivers: [
        SliverToBoxAdapter(
          child: Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
            child: Column(spacing: Dimensions.paddingSizeDefault, children: [
              SelectYearAndMonthWidget(onTap: (){
                Get.find<FeesReportsController>().getMonthlyReport();
              }),
              MonthlyFeesReportListWidget(scrollController: scrollController),
              ],
            ),
          ),
        ),
      ],
      ),
    );
  }
}
