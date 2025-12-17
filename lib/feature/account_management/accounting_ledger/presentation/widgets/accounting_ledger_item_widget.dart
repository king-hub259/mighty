import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/confirmation_dialog.dart';
import 'package:mighty_school/common/widget/edit_delete_section.dart';
import 'package:mighty_school/common/widget/numbering_widget.dart';
import 'package:mighty_school/feature/account_management/accounting_ledger/domain/model/accounting_ledger_model.dart';
import 'package:mighty_school/feature/account_management/accounting_ledger/logic/account_ledger_controller.dart';
import 'package:mighty_school/feature/account_management/accounting_ledger/presentation/screen/create_new_accounting_ledger_item_widget.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';

class AccountingLedgerItemWidget extends StatelessWidget {
  final AccountingLedgerItem? accountingLedgerItem;
  final int index;
  const AccountingLedgerItemWidget({super.key, this.accountingLedgerItem, required this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.fromLTRB(Dimensions.paddingSizeDefault, Dimensions.paddingSizeDefault, Dimensions.paddingSizeDefault, 0),
      child: Row(spacing: Dimensions.paddingSizeDefault, crossAxisAlignment: CrossAxisAlignment.start, children: [

        NumberingWidget(index: index),
        Expanded(child: Text('${accountingLedgerItem?.ledgerName}', style: textRegular.copyWith())),
        EditDeleteSection(horizontal: true, onDelete: (){
          Get.dialog(ConfirmationDialog(title: "accounting_ledger", content: "accounting_ledger",
            onTap: (){
              Get.back();
              Get.find<AccountLedgerController>().deleteAccountingLedger(accountingLedgerItem!.id!);
            },));

        }, onEdit: (){
          Get.dialog(CreateNewAccountingLedgerWidget(accountingLedgerItem: accountingLedgerItem));
        },)
      ],
      ),
    );
  }
}
