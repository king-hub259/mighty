import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/layout/list_layout_widget.dart';
import 'package:mighty_school/feature/academic_configuration/picklist/controller/picklist_controller.dart';
import 'package:mighty_school/feature/academic_configuration/picklist/domain/models/pick_list_model.dart';
import 'package:mighty_school/feature/academic_configuration/picklist/presentation/screens/create_new_picklist_screen.dart';
import 'package:mighty_school/feature/academic_configuration/picklist/presentation/widgets/picklist_item_widget.dart';

class PickListWidget extends StatelessWidget {
  final ScrollController scrollController;
  const PickListWidget({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PickListController>(
      initState: (val) => Get.find<PickListController>().getPickList(1),
      builder: (pickListController) {
        final pickListModel = pickListController.pickListModel;
        final pickListData = pickListModel?.data;
        return GenericListSection<PickListItem>(
          sectionTitle: "academic_configuration".tr,
          pathItems: ["pick_list".tr],
          addNewTitle: "add_new_picklist".tr,
          onAddNewTap: () => Get.dialog(const CreateNewPickListScreen()),
          headings: const ["type", "value", "action"],
          scrollController: scrollController,
          isLoading: pickListModel == null,
          totalSize: pickListData?.total ?? 0,
          offset: pickListData?.currentPage ?? 0,
          onPaginate: (offset) async => await pickListController.getPickList(offset ?? 1),
          items: pickListData?.data ?? [],
          itemBuilder: (item, index) => PickListItemWidget(index: index, pickListItem: item),
        );
      },
    );
  }
}