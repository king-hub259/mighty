import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/layout/list_layout_widget.dart';
import 'package:mighty_school/feature/payroll_management/payroll_start_up/domain/models/salary_head_model.dart';
import 'package:mighty_school/feature/payroll_management/payroll_start_up/logic/payroll_start_up_controller.dart';
import 'package:mighty_school/feature/payroll_management/payroll_start_up/presentation/widgets/add_new_salary_head_widget.dart';
import 'package:mighty_school/feature/payroll_management/payroll_start_up/presentation/widgets/salary_head_item_widget.dart';

class SalaryHeadListWidget extends StatelessWidget {
  final ScrollController scrollController;

  const SalaryHeadListWidget({
    super.key,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PayrollStartUpController>(
      builder: (payrollStartUpController) {
        SalaryHeadModel? salaryHeadModel = payrollStartUpController.salaryHeadModel;
        var salaryHeadData = salaryHeadModel?.data;

        return GenericListSection<SalaryHeadItem>(
          sectionTitle: "payroll_management".tr,
          pathItems: ["salary_head".tr],
          addNewTitle: "add_new_salary_head".tr,
          onAddNewTap: () => Get.dialog(const AddNewSalaryHeadWidget()),
          headings: const ["name",  "type", "action"],

          scrollController: scrollController,
          isLoading: salaryHeadModel == null,
          totalSize: salaryHeadData?.total ?? 0,
          offset: salaryHeadData?.currentPage ?? 0,
          onPaginate: (offset) async => await payrollStartUpController.getSalaryHeadList(offset ?? 1),

          items: salaryHeadData?.data ?? [],
          itemBuilder: (item, index) {
            return SalaryHeadItemWidget(salaryHeadItem: item, index: index);
          },
        );
      },
    );
  }
}