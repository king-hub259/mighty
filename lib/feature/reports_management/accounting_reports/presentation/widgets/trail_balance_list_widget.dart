import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/layout/list_layout_widget.dart';
import 'package:mighty_school/feature/reports_management/accounting_reports/domain/model/trail_balance_report_model.dart';
import 'package:mighty_school/feature/reports_management/accounting_reports/logic/accounting_reports_controller.dart';
import 'package:mighty_school/feature/reports_management/accounting_reports/presentation/widgets/item_widget/trail_balance_item_widget.dart';

class TrailBalanceListWidget extends StatelessWidget {
  final ScrollController scrollController;
  const TrailBalanceListWidget({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AccountingReportsController>(
      builder: (accountingReportsController) {
        TrailBalanceReportModel? trialBalanceModel = accountingReportsController.trialBalanceModel;
        return GenericListSection<Data>(
          sectionTitle: "trial_balance".tr,
          headings: const ["ledger", "debit", "credit"],
          scrollController: scrollController,
          isLoading: trialBalanceModel == null,
          totalSize: 0,
          offset: 1,
          onPaginate: (offset) async {},
          items: trialBalanceModel?.data ?? [],
          itemBuilder: (item, index) => TrailBalanceItemWidget(item: item, index: index),
        );
      },
    );
  }
}