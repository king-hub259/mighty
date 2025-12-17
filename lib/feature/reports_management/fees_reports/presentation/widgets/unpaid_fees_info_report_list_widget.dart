import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/layout/list_layout_widget.dart';
import 'package:mighty_school/feature/reports_management/fees_reports/domain/model/fees_payment_info_model.dart';
import 'package:mighty_school/feature/reports_management/fees_reports/logic/fees_reports_controller.dart';
import 'package:mighty_school/feature/reports_management/fees_reports/presentation/widgets/item_widget/unpaid_fees_info_item_widget.dart';

class UnpaidFeesInfoReportListWidget extends StatelessWidget {
  final ScrollController scrollController;
  const UnpaidFeesInfoReportListWidget({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FeesReportsController>(
      builder: (feesReportsController) {
        FeesPaymentInfoReportModel? unpaidFeesModel = feesReportsController.unpaidFeesModel;
        return GenericListSection<FeesPaymentInfoItem>(
          sectionTitle: "unpaid_fees_info".tr,
          pathItems: ["unpaid_info".tr],
          headings: const ["student", "invoice_id", "total_payable", "total_paid", "total_due"],
          scrollController: scrollController,
          isLoading: unpaidFeesModel == null,
          totalSize: 0,
          offset: 1,
          onPaginate: (offset) async {},
          items: unpaidFeesModel?.data ?? [],
          itemBuilder: (item, index) => UnpaidFeesInfoItemWidget(item: item, index: index),
        );
      },
    );
  }
}