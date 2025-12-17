import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_title.dart';
import 'package:mighty_school/feature/account_management/accounting_category/controller/accounting_category_controller.dart';
import 'package:mighty_school/feature/account_management/accounting_category/presentation/widgets/accounting_category_dropdown.dart';
import 'package:mighty_school/feature/academic_configuration/department/controller/department_controller.dart';

class SelectAccountingCategoryWidget extends StatefulWidget {
  const SelectAccountingCategoryWidget({super.key});

  @override
  State<SelectAccountingCategoryWidget> createState() => _SelectAccountingCategoryWidgetState();
}

class _SelectAccountingCategoryWidgetState extends State<SelectAccountingCategoryWidget> {
  @override
  void initState() {
    if(Get.find<DepartmentController>().departmentModel == null){
      Get.find<DepartmentController>().getDepartmentList(1);
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const CustomTitle(title: "accounting_category"),
      GetBuilder<AccountingCategoryController>(
          builder: (accountingCategoryController) {
            return Padding(padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: AccountingCategoryDropdown(width: Get.width, title: "select".tr,
                items: accountingCategoryController.accountingCategoryModel?.data?.data??[],
                selectedValue: accountingCategoryController.selectedAccountingCategory,
                onChanged: (val){
                  accountingCategoryController.selectAccountingCategory(val!);
                },
              ),);
          }
      ),
    ],);
  }
}
