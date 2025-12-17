import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/layout/list_layout_widget.dart';
import 'package:mighty_school/feature/fees_management/fees_amount_config/controller/fees_controller.dart';
import 'package:mighty_school/feature/fees_management/fees_amount_config/domain/model/fees_model.dart';
import 'package:mighty_school/feature/fees_management/fees_amount_config/presentation/widgets/fees_item_widget.dart';

class FeesListWidget extends StatelessWidget {
  final ScrollController scrollController;
  const FeesListWidget({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FeesController>(
        initState: (val) => Get.find<FeesController>().getFeesList(1),
        builder: (feesController) {
      FeesModel? feesModel = feesController.feesModel;
      Data? feesData = feesModel?.data;

      return GenericListSection<FeesItem>(
        sectionTitle: "fees_management".tr,
        pathItems: ["fees_amount_config".tr],
        headings: const ["fee_head", "section", "group", "amount", "action"],
        scrollController: scrollController,
        isLoading: feesModel == null,
        totalSize: feesData?.total ?? 0,
        offset: feesData?.currentPage ?? 0,
        onPaginate: (offset) async => await feesController.getFeesList(offset ?? 1),
        items: feesData?.data ?? [],
        itemBuilder: (item, index) => FeesItemWidget(feesItem: item, index: index),
      );
    });
  }
}
