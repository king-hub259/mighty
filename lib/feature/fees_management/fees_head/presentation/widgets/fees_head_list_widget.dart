import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/layout/list_layout_widget.dart';
import 'package:mighty_school/feature/fees_management/fees_head/controller/fees_head_controller.dart';
import 'package:mighty_school/feature/fees_management/fees_head/domain/model/fees_head_model.dart';
import 'package:mighty_school/feature/fees_management/fees_head/presentation/screens/create_new_fees_head_dialog.dart';
import 'package:mighty_school/feature/fees_management/fees_head/presentation/widgets/fees_head_item_widget.dart';

class FeesHeadListWidget extends StatelessWidget {
  final ScrollController scrollController;
  const FeesHeadListWidget({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FeesHeadController>(
      initState: (val) => Get.find<FeesHeadController>().getFeesHeadList(1),
        builder: (feesHeadController) {
      FeesHeadModel? feesHeadModel = feesHeadController.feesHeadModel;
      Data? feesHeadData = feesHeadModel?.data;

      return GenericListSection<FeesHeadItem>(
        sectionTitle: "fees_management".tr,
        pathItems: ["fees_head".tr],
        addNewTitle: "add_new_fees_head".tr,
        onAddNewTap: () => Get.dialog(const CreateNewFeesHeadDialog()),
        headings: const ["name", "serial", "action"],
        scrollController: scrollController,
        isLoading: feesHeadModel == null,
        totalSize: feesHeadData?.total ?? 0,
        offset: feesHeadData?.currentPage ?? 0,
        onPaginate: (offset) async => await feesHeadController.getFeesHeadList(offset ?? 1),
        items: feesHeadData?.data ?? [],
        itemBuilder: (item, index) => FeesHeadItemWidget(feesHeadItem: item, index: index),
      );
    });
  }
}
