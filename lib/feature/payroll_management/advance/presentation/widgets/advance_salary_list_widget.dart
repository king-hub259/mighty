import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/layout/list_layout_widget.dart';
import 'package:mighty_school/feature/payroll_management/advance/domain/models/advance_salary_model.dart';
import 'package:mighty_school/feature/payroll_management/advance/logic/advance_controller.dart';
import 'package:mighty_school/feature/payroll_management/advance/presentation/screens/create_advance_salary_screen.dart';
import 'package:mighty_school/feature/payroll_management/advance/presentation/widgets/advance_salary_item_widget.dart';

class AdvanceSalaryListWidget extends StatelessWidget {
  final ScrollController scrollController;

  const AdvanceSalaryListWidget({
    super.key,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AdvanceController>(
      initState: (val) => Get.find<AdvanceController>().getAdvanceSalaryList(1),
      builder: (advanceController) {
        AdvanceSalaryModel? advanceSalaryModel = advanceController.advanceSalaryModel;
        var advanceSalaryData = advanceSalaryModel?.data;

        return GenericListSection<AdvanceSalaryItem>(
          sectionTitle: "payroll_management".tr,
          pathItems: ["advance_salary".tr],
          addNewTitle: "add_advance_salary".tr,
          onAddNewTap: () => Get.to(() => const CreateAdvanceSalaryScreen()),
          headings: const ["employee", "month", "year", "amount", "status", "action"],

          scrollController: scrollController,
          isLoading: advanceSalaryModel == null,
          totalSize: advanceSalaryData?.total ?? 0,
          offset: advanceSalaryData?.currentPage ?? 0,
          onPaginate: (offset) async => await advanceController.getAdvanceSalaryList(offset ?? 1),

          items: advanceSalaryData?.data ?? [],
          itemBuilder: (item, index) {
            return AdvanceSalaryItemWidget(advanceSalaryItem: item, index: index);
          },
        );
      },
    );
  }
}
