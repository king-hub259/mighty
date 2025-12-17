
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/layout/list_layout_widget.dart';
import 'package:mighty_school/feature/account_management/accounting_group/domain/model/accounting_group_model.dart';
import 'package:mighty_school/feature/account_management/accounting_group/logic/account_group_controller.dart';
import 'package:mighty_school/feature/account_management/accounting_group/presentation/screen/create_new_accounting_group_item_widget.dart';
import 'package:mighty_school/feature/account_management/accounting_group/presentation/widgets/accounting_group_item_widget.dart';

class AccountingGroupWidget extends StatelessWidget {
  final ScrollController scrollController;
  const AccountingGroupWidget({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AccountingGroupController>(
      initState: (val) => Get.find<AccountingGroupController>().getAccountingGroupList(1),
      builder: (accountGroupController) {
        final accountingGroupModel = accountGroupController.accountingGroupModel;
        final accountingGroup = accountingGroupModel?.data;

        return GenericListSection<AccountingGroupItem>(
          sectionTitle: "account_management".tr,
          pathItems: ["accounting_group".tr],
          addNewTitle: "add_new_accounting_group".tr,
          onAddNewTap: () => Get.dialog(const CreateNewAccountingGroupWidget()),
          headings: const ["name", "action"],

          scrollController: scrollController,
          isLoading: accountingGroupModel == null,
          totalSize: accountingGroup?.total ?? 0,
          offset: accountingGroup?.currentPage ?? 0,
          onPaginate: (offset) async => accountGroupController.getAccountingGroupList(offset??1),

          items: accountingGroup?.data ?? [],
          itemBuilder: (item, index) {
            return AccountingGroupItemWidget(accountingGroupItem: item, index: index);
          },
        );
      },
    );
  }
}