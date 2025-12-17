import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/layout/list_layout_widget.dart';
import 'package:mighty_school/feature/account_management/accounting_funds/domain/model/account_fund_model.dart';
import 'package:mighty_school/feature/account_management/accounting_funds/logic/account_fund_controller.dart';
import 'package:mighty_school/feature/account_management/accounting_funds/presentation/screen/create_new_accounting_fund_item_widget.dart';
import 'package:mighty_school/feature/account_management/accounting_funds/presentation/widgets/accounting_fund_item_widget.dart';

class AccountingFundWidget extends StatelessWidget {
  final ScrollController scrollController;
  const AccountingFundWidget({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AccountingFundController>(
      initState: (val) => Get.find<AccountingFundController>().getAccountingFundList(1),
      builder: (accountFundController) {
        final accountingFundModel = accountFundController.accountingFundModel;
        final accountingFund = accountingFundModel?.data;

        return GenericListSection<AccountingFundItem>(
          sectionTitle: "account_management".tr,
          pathItems: ["accounting_fund".tr],
          addNewTitle: "add_new_accounting_fund".tr,
          onAddNewTap: () => Get.dialog(const CreateNewAccountingFundWidget()),
          headings: const ["name", "amount_in", "amount_out", "balance", "action"],

          scrollController: scrollController,
          isLoading: accountingFundModel == null,
          totalSize: accountingFund?.total ?? 0,
          offset: accountingFund?.currentPage ?? 0,
          onPaginate: (offset) async => accountFundController.getAccountingFundList(offset??1),

          items: accountingFund?.data ?? [],
          itemBuilder: (item, index) {
            return AccountingFundItemWidget(accountingFundItem: item, index: index);
          },
        );
      },
    );
  }
}