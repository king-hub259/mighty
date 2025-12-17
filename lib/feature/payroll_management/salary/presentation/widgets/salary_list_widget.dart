import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/layout/list_layout_widget.dart';
import 'package:mighty_school/feature/payroll_management/salary/domain/models/salary_model.dart';
import 'package:mighty_school/feature/payroll_management/salary/logic/salary_controller.dart';
import 'package:mighty_school/feature/payroll_management/salary/presentation/widgets/salary_item_widget.dart';

class SalaryListWidget extends StatelessWidget {
  final ScrollController scrollController;

  const SalaryListWidget({
    super.key,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SalaryController>(
      initState: (val) => Get.find<SalaryController>().getSalaryList(

          DateTime.now().month.toString(),
          DateTime.now().year.toString()
      ),
      builder: (salaryController) {
        SalaryModel? salaryModel = salaryController.salaryModel;
        var salaryData = salaryModel?.data;

        return GenericListSection<SalaryItem>(
          sectionTitle: "payroll_management".tr,
          pathItems: ["salary_processing".tr],
          addNewTitle: null, // No add button for salary processing
          onAddNewTap: null,
          headings: const ["employee", "month_year", "basic_salary", "total_earning", "total_deduction", "net_salary"],

          scrollController: scrollController,
          isLoading: salaryModel == null,
          totalSize: salaryData?.total ?? 0,
          offset: salaryData?.currentPage ?? 0,
          onPaginate: (offset) async {},
          items: salaryData?.data ?? [],
          itemBuilder: (item, index) {
            return SalaryItemWidget(salaryItem: item, index: index);
          },
        );
      },
    );
  }
}
