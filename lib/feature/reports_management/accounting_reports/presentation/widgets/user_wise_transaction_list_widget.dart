import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/layout/list_layout_widget.dart';
import 'package:mighty_school/feature/reports_management/accounting_reports/domain/model/user_wise_report_model.dart';
import 'package:mighty_school/feature/reports_management/accounting_reports/logic/accounting_reports_controller.dart';
import 'package:mighty_school/feature/reports_management/accounting_reports/presentation/widgets/item_widget/user_wise_item_widget.dart';

class UserWiseTransactionListWidget extends StatelessWidget {
  final ScrollController scrollController;
  const UserWiseTransactionListWidget({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AccountingReportsController>(
      builder: (accountingReportsController) {
        UserWiseReportModel? userWiseModel = accountingReportsController.userWiseModel;
        return GenericListSection<Data>(
          sectionTitle: "user_wise_report".tr,
          headings: const ["date", "reference", "description", "debit", "credit"],
          scrollController: scrollController,
          isLoading: userWiseModel == null,
          totalSize: 0,
          offset: 1,
          onPaginate: (offset) async {},
          items: userWiseModel?.data ?? [],
          itemBuilder: (item, index) => UserWiseItemWidget(item: item, index: index),
        );
      },
    );
  }
}