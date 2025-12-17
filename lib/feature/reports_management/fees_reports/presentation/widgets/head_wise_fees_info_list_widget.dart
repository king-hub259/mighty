import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/layout/list_layout_widget.dart';
import 'package:mighty_school/feature/reports_management/fees_reports/domain/model/fees_head_wise_report_model.dart';
import 'package:mighty_school/feature/reports_management/fees_reports/logic/fees_reports_controller.dart';
import 'package:mighty_school/feature/reports_management/fees_reports/presentation/widgets/item_widget/head_wise_fees_info_item_widget.dart';

class HeadWiseFeesInfoListWidget extends StatelessWidget {
  final ScrollController scrollController;
  const HeadWiseFeesInfoListWidget({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FeesReportsController>(
      builder: (feesReportsController) {
        FeesHeadWiseReportModel? feesHeadWiseModel = feesReportsController.feesHeadWiseModel;
        return GenericListSection<FeesHeadWiseReportItem>(
          sectionTitle: "head_wise_fees_info".tr,
          pathItems: ["head_wise".tr],
          headings: const ["student", "roll", "fee_head", "total_paid", "invoice_date"],
          scrollController: scrollController,
          isLoading: feesHeadWiseModel == null,
          totalSize: 0,
          offset: 1,
          onPaginate: (offset) async {},
          items: feesHeadWiseModel?.data ?? [],
          itemBuilder: (item, index) => HeadWiseFeesInfoItemWidget(item: item, index: index),
        );
      },
    );
  }
}