import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/layout/list_layout_widget.dart';
import 'package:mighty_school/feature/branch/controller/branch_controller.dart';
import 'package:mighty_school/feature/branch/domain/models/branch_model.dart';
import 'package:mighty_school/feature/branch/presentation/widgets/branch_item_widget.dart';
import 'package:mighty_school/feature/branch/presentation/widgets/create_new_branch_widget.dart';

class BranchListWidget extends StatelessWidget {
  final ScrollController scrollController;
  const BranchListWidget({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BranchController>(
      initState: (val) => Get.find<BranchController>().getBranchList(1),
      builder: (branchController) {
        final branchModel = branchController.branchModel;
        final branchData = branchModel?.data;

        return GenericListSection<BranchItem>(
          sectionTitle: "branch".tr,
          pathItems: ["branch".tr],
          addNewTitle: "add_new_branch".tr,
          onAddNewTap: () => Get.dialog(const CreateNewBranchWidget()),
          headings: const ["branch", "action"],

          scrollController: scrollController,
          isLoading: branchModel == null,
          totalSize: branchData?.total ?? 0,
          offset: branchData?.currentPage ?? 0,
          onPaginate: (offset) async => await branchController.getBranchList(offset ?? 1),

          items: branchData?.data ?? [],
          itemBuilder: (item, index) => BranchItemWidget(index: index, branchItem: item),
        );
      },
    );
  }
}