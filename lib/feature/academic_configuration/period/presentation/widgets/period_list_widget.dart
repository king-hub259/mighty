import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/layout/list_layout_widget.dart';
import 'package:mighty_school/feature/academic_configuration/period/controller/period_controller.dart';
import 'package:mighty_school/feature/academic_configuration/period/domain/model/period_model.dart';
import 'package:mighty_school/feature/academic_configuration/period/presentation/screens/create_new_period_dialog.dart';
import 'package:mighty_school/feature/academic_configuration/period/presentation/widgets/period_item.dart';

class PeriodListWidget extends StatelessWidget {
  final ScrollController scrollController;
  const PeriodListWidget({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PeriodController>(
      initState: (val) => Get.find<PeriodController>().getPeriodList(1),
      builder: (periodController) {
        final periodModel = periodController.periodModel;
        final periodData = periodModel?.data;
        return GenericListSection<PeriodItem>(
          sectionTitle: "academic_configuration".tr,
          pathItems: ["period_list".tr],
          addNewTitle: "add_new_period".tr,
          onAddNewTap: () => Get.dialog(const CreateNewPeriodScreen()),
          headings: const ["period", "action"],
          scrollController: scrollController,
          isLoading: periodModel == null,
          totalSize: periodData?.total ?? 0,
          offset: periodData?.currentPage ?? 0,
          onPaginate: (offset) async => await periodController.getPeriodList(offset ?? 1),
          items: periodData?.data ?? [],
          itemBuilder: (item, index) => PeriodWidget(periodItem: item, index: index),
        );
      },
    );
  }
}