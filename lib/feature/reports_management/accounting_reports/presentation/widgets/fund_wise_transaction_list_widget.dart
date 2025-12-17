import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/layout/list_layout_widget.dart';
import 'package:mighty_school/feature/reports_management/accounting_reports/domain/model/fund_wise_report_model.dart';
import 'package:mighty_school/feature/reports_management/accounting_reports/logic/accounting_reports_controller.dart';
import 'package:mighty_school/feature/reports_management/accounting_reports/presentation/widgets/item_widget/fund_wise_item_widget.dart';

class FundWiseTransactionListWidget extends StatelessWidget {
  final ScrollController scrollController;
  const FundWiseTransactionListWidget({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AccountingReportsController>(
      builder: (accountingReportsController) {
        FundWiseReportModel? fundWiseModel = accountingReportsController.fundWiseModel;
        return GenericListSection<Data>(
          sectionTitle: "fund_wise_report".tr,
          headings: const ["date", "fund", "reference", "debit", "credit"],
          scrollController: scrollController,
          isLoading: fundWiseModel == null,
          totalSize: 0,
          offset: 1,
          onPaginate: (offset) async {},
          items: fundWiseModel?.data ?? [],
          itemBuilder: (item, index) => FundWiseItemWidget(item: item, index: index),
        );
      },
    );
  }
}