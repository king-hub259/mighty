import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/layout/list_layout_widget.dart';
import 'package:mighty_school/feature/account_management/chart_of_account/domain/model/char_of_account_model.dart';
import 'package:mighty_school/feature/account_management/chart_of_account/logic/chart_of_account_controller.dart';
import 'package:mighty_school/feature/account_management/chart_of_account/presentation/widgets/chart_of_account_item_widget.dart';


class ChartOfAccountWidget extends StatelessWidget {
  final ScrollController scrollController;
  const ChartOfAccountWidget({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChartOfAccountController>(
        initState: (val) => Get.find<ChartOfAccountController>().getChartOfAccount(1),
        builder: (chartOfAccountController) {
          ChartOfAccountModel? chartOfAccountModel = chartOfAccountController.chartOfAccountModel;
          var chartOfAccount = chartOfAccountController.chartOfAccountModel?.data;
          return GenericListSection<ChartOfAccountItem>(
            sectionTitle: "account_management".tr,
            pathItems: ["chart_of_account".tr],
            headings: const ["name", "action"],
            scrollController: scrollController,
            isLoading: chartOfAccountModel == null,
            totalSize: chartOfAccount?.total ?? 0,
            offset: chartOfAccount?.currentPage ?? 0,
            onPaginate: (offset) async => await chartOfAccountController.getChartOfAccount(offset??1),
            items: chartOfAccount?.data ?? [],
            itemBuilder: (item, index) {
              return ChartOfAccountItemWidget(chartOfAccountItem: item, index: index);
            },
          );
        }
    );
  }
}
