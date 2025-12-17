import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/layout/list_layout_widget.dart';
import 'package:mighty_school/feature/academic_configuration/section/controller/section_controller.dart';
import 'package:mighty_school/feature/academic_configuration/section/domain/model/section_model.dart';
import 'package:mighty_school/feature/academic_configuration/section/presentation/widgets/create_new_section_widget_web.dart';
import 'package:mighty_school/feature/academic_configuration/section/presentation/widgets/section_item_widget.dart';

class SectionListWidget extends StatelessWidget {
  final ScrollController scrollController;
  const SectionListWidget({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SectionController>(
      builder: (sectionController) {
        final sectionModel = sectionController.sectionModel;
        final sectionData = sectionModel?.data;

        return GenericListSection<SectionItem>(
          sectionTitle: "academic_configuration".tr,
          pathItems: ["section_list".tr],
          addNewTitle: "add_new_section".tr,
          onAddNewTap: () => Get.dialog(const CreateNewSectionWidgetForWeb()),
          headings: const ["section", "action"],
          scrollController: scrollController,
          isLoading: false,
          totalSize: sectionData?.total ?? 0,
          offset: sectionData?.currentPage ?? 0,
          onPaginate: (offset) async => await sectionController.getSectionList(offset ?? 1),
          items: sectionData?.data ?? [],
          itemBuilder: (item, index) => SectionItemWidget(index: index, sectionItem: item),
        );
      },
    );
  }
}