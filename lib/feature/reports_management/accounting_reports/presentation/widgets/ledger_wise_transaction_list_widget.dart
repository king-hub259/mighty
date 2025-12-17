import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/layout/list_layout_widget.dart';
import 'package:mighty_school/feature/reports_management/accounting_reports/domain/model/ledger_wise_report_model.dart';
import 'package:mighty_school/feature/reports_management/accounting_reports/logic/accounting_reports_controller.dart';
import 'package:mighty_school/feature/reports_management/accounting_reports/presentation/widgets/item_widget/ledger_wise_item_widget.dart';

class LedgerWiseTransactionListWidget extends StatelessWidget {
  final ScrollController scrollController;
  const LedgerWiseTransactionListWidget({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AccountingReportsController>(
      builder: (accountingReportsController) {
        LedgerWiseReportModel? ledgerWiseModel = accountingReportsController.ledgerWiseModel;
        return GenericListSection<Data>(
          sectionTitle: "ledger_wise_report".tr,
          headings: const ["date", "reference", "ledger", "debit", "credit"],
          scrollController: scrollController,
          isLoading: ledgerWiseModel == null,
          totalSize: 0,
          offset: 1,
          onPaginate: (offset) async {},
          items: ledgerWiseModel?.data ?? [],
          itemBuilder: (item, index) => LedgerWiseItemWidget(item: item, index: index),
        );
      },
    );
  }
}