import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/layout/list_layout_widget.dart';
import 'package:mighty_school/feature/account_management/accounting_ledger/domain/model/accounting_ledger_model.dart';
import 'package:mighty_school/feature/account_management/accounting_ledger/logic/account_ledger_controller.dart';
import 'package:mighty_school/feature/account_management/accounting_ledger/presentation/screen/create_new_accounting_ledger_item_widget.dart';
import 'package:mighty_school/feature/account_management/accounting_ledger/presentation/widgets/accounting_ledger_item_widget.dart';

class AccountingLedgerWidget extends StatelessWidget {
  final ScrollController scrollController;
  const AccountingLedgerWidget({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AccountLedgerController>(
      initState: (val) => Get.find<AccountLedgerController>().getAccountingLedgerList(1),
      builder: (accountingLedgerController) {
        final ledgerModel = accountingLedgerController.accountingLedgerModel;
        final ledgerData = ledgerModel?.data;

        return GenericListSection<AccountingLedgerItem>(
          sectionTitle: "account_management".tr,
          pathItems: ["ledger".tr],
          addNewTitle: "add".tr,
          onAddNewTap: () => Get.dialog(const CreateNewAccountingLedgerWidget()),
          headings: const ["name", "action"],

          scrollController: scrollController,
          isLoading: ledgerModel == null,
          totalSize: ledgerData?.total ?? 0,
          offset: ledgerData?.currentPage ?? 0,
          onPaginate: (offset) async => await accountingLedgerController.getAccountingLedgerList(offset??1),

          items: ledgerData?.data ?? [],
          itemBuilder: (item, index) {
            return AccountingLedgerItemWidget(accountingLedgerItem: item, index: index);
          },
        );
      },
    );
  }
}