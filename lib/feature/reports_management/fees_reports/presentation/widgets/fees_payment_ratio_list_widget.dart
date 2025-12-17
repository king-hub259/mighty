import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/layout/list_layout_widget.dart';
import 'package:mighty_school/feature/reports_management/fees_reports/logic/fees_reports_controller.dart';
import 'package:mighty_school/feature/reports_management/fees_reports/presentation/widgets/item_widget/fees_payment_ratio_item_widget.dart';

class FeesPaymentRatioListWidget extends StatelessWidget {
  final ScrollController scrollController;
  const FeesPaymentRatioListWidget({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FeesReportsController>(
      builder: (feesReportsController) {
        // Using dynamic data since the model structure is not defined
        List<dynamic> paymentRatioData = feesReportsController.paymentRatioModel?.data ?? [];
        return GenericListSection<dynamic>(
          sectionTitle: "payment_ratio_info".tr,
          pathItems: ["payment_ratio".tr],
          headings: const ["category", "total_amount", "paid_amount", "ratio"],
          scrollController: scrollController,
          isLoading: feesReportsController.paymentRatioModel == null,
          totalSize: 0,
          offset: 1,
          onPaginate: (offset) async {},
          items: paymentRatioData,
          itemBuilder: (item, index) => FeesPaymentRatioItemWidget(item: item, index: index),
        );
      },
    );
  }
}