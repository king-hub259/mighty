
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/layout/list_layout_widget.dart';
import 'package:mighty_school/feature/reports_management/fees_reports/domain/model/fees_monthly_report_model.dart';
import 'package:mighty_school/feature/reports_management/fees_reports/logic/fees_reports_controller.dart';
import 'package:mighty_school/feature/reports_management/fees_reports/presentation/widgets/item_widget/fees_monthly_report_item_widget.dart';

class MonthlyFeesReportListWidget extends StatelessWidget {
  final ScrollController scrollController;
  const MonthlyFeesReportListWidget({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FeesReportsController>(
      builder: (feesReportsController) {
        FeesMonthlyReportModel? feesMonthlyReportModel = feesReportsController.feesMonthlyReportModel;
        return GenericListSection<MonthlyReportItem>(
          sectionTitle: "fees_report".tr,
          pathItems:  ["monthly".tr],
          headings: const ["monthly"],

          scrollController: scrollController,
          isLoading: feesMonthlyReportModel == null,
          totalSize:  0,
          offset: 1,
          onPaginate: (offset) async {},
          items: feesMonthlyReportModel?.data ?? [],
          itemBuilder: (item, index) => FeesMonthlyReportItemWidget(item: item, index: index),
        );
      },
    );
  }
}