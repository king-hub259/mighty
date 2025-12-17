import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/layout/list_layout_widget.dart';
import 'package:mighty_school/feature/payroll_management/salary/domain/model/salary_payment_info_model.dart';
import 'package:mighty_school/feature/payroll_management/salary/logic/salary_controller.dart';
import 'package:mighty_school/feature/payroll_management/salary/presentation/widgets/salary_payment_info_item_widget.dart';

class SalaryPaymentInfoListWidget extends StatelessWidget {
  final ScrollController scrollController;
  const SalaryPaymentInfoListWidget({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SalaryController>(
      initState: (val) => Get.find<SalaryController>().getSalaryPaymentInfo(),
      builder: (salaryController) {
        SalaryPaymentInfoModel? salaryPaymentInfoModel = salaryController.salaryPaymentInfoModel;
        return GenericListSection<SalaryPaymentInfoItem>(
          sectionTitle: "payroll_management".tr,
          pathItems: ["payment_info".tr],
          addNewTitle: null, // No add button for salary processing
          onAddNewTap: null,
          headings: const ["hr_id", "name", "payable", "paid", "due", "advance", "net_salary"],

          scrollController: scrollController,
          isLoading: salaryPaymentInfoModel == null,
          totalSize: 0,
          offset: 1,
          onPaginate: (offset) async {},

          items: salaryPaymentInfoModel?.data ?? [],
          itemBuilder: (item, index) {
            return SalaryPaymentInfoItemWidget(salaryItem: item, index: index,);
          },
        );
      }
    );
  }
}
