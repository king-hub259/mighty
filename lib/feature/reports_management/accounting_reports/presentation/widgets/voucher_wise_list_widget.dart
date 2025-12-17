import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/layout/list_layout_widget.dart';
import 'package:mighty_school/feature/reports_management/accounting_reports/domain/model/voucher_report_model.dart';
import 'package:mighty_school/feature/reports_management/accounting_reports/logic/accounting_reports_controller.dart';
import 'package:mighty_school/feature/reports_management/accounting_reports/presentation/widgets/item_widget/voucher_wise_item_widget.dart';

class VoucherWiseListWidget extends StatelessWidget {
  final ScrollController scrollController;
  const VoucherWiseListWidget({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AccountingReportsController>(
      builder: (accountingReportsController) {
        VoucherReportModel? voucherWiseModel = accountingReportsController.voucherWiseModel;
        return GenericListSection<Data>(
          sectionTitle: "voucher_wise_report".tr,
          headings: const ["date", "reference", "description", "debit", "credit"],
          scrollController: scrollController,
          isLoading: voucherWiseModel == null,
          totalSize: 0,
          offset: 1,
          onPaginate: (offset) async {},
          items: voucherWiseModel?.data ?? [],
          itemBuilder: (item, index) => VoucherWiseItemWidget(item: item, index: index),
        );
      },
    );
  }
}