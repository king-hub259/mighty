import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/layout/list_layout_widget.dart';
import 'package:mighty_school/feature/account_management/accounting_category/controller/accounting_category_controller.dart';
import 'package:mighty_school/feature/account_management/accounting_category/domain/models/accounting_category_model.dart';
import 'package:mighty_school/feature/account_management/accounting_category/presentation/screens/create_new_account_category_screen.dart';
import 'package:mighty_school/feature/account_management/accounting_category/presentation/widgets/accounting_category_item_widget.dart';


class AccountingCategoryWidget extends StatelessWidget {
  final ScrollController scrollController;
  const AccountingCategoryWidget({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AccountingCategoryController>(
      initState: (val) => Get.find<AccountingCategoryController>().getAccountingCategoryList(1),
      builder: (accountingCategoryController) {
        final accountingCategoryModel = accountingCategoryController.accountingCategoryModel;
        final accountingCategory = accountingCategoryModel?.data;

        return GenericListSection<AccountingCategoryItem>(
          sectionTitle: "account_management".tr,
          pathItems: ["accounting_category".tr],
          addNewTitle: "add_new_accounting_category".tr,
          onAddNewTap: () => Get.dialog(const CreateNewAccountingCategoryScreen()),
          headings: const ["name", "action"],

          scrollController: scrollController,
          isLoading: accountingCategoryModel == null,
          totalSize: accountingCategory?.total ?? 0,
          offset: accountingCategory?.currentPage ?? 0,
          onPaginate: (offset) async => accountingCategoryController.getAccountingCategoryList(offset??1),

          items: accountingCategory?.data ?? [],
          itemBuilder: (item, index) {
            return AccountingCategoryItemWidget(accountingCategoryItem: item, index: index);
          },
        );
      },
    );
  }
}