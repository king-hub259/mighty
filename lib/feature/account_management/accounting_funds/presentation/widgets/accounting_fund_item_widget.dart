
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/confirmation_dialog.dart';
import 'package:mighty_school/common/widget/edit_delete_section.dart';
import 'package:mighty_school/common/widget/numbering_widget.dart';
import 'package:mighty_school/feature/account_management/accounting_funds/domain/model/account_fund_model.dart';
import 'package:mighty_school/feature/account_management/accounting_funds/logic/account_fund_controller.dart';
import 'package:mighty_school/feature/account_management/accounting_funds/presentation/screen/create_new_accounting_fund_item_widget.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';

class AccountingFundItemWidget extends StatelessWidget {
  final AccountingFundItem? accountingFundItem;
  final int index;
  const AccountingFundItemWidget({super.key, this.accountingFundItem, required this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.fromLTRB(Dimensions.paddingSizeDefault, Dimensions.paddingSizeDefault, Dimensions.paddingSizeDefault, 0),
      child: Row(spacing: Dimensions.paddingSizeDefault, crossAxisAlignment: CrossAxisAlignment.start, children: [

        NumberingWidget(index: index),
        Expanded(child: Text('${accountingFundItem?.name}', style: textRegular.copyWith())),
        Expanded(child: Text('${accountingFundItem?.cashIn}', style: textRegular.copyWith())),
        Expanded(child: Text('${accountingFundItem?.cashOut}', style: textRegular.copyWith())),
        Expanded(child: Text('${accountingFundItem?.balance}', style: textRegular.copyWith())),
        EditDeleteSection(horizontal: true, onDelete: (){
          Get.dialog(ConfirmationDialog(title: "accounting_fund", content: "accounting_fund",
            onTap: (){
              Get.back();
              Get.find<AccountingFundController>().deleteAccountingFund(accountingFundItem!.id!);
            },));

        }, onEdit: (){
          Get.dialog(CreateNewAccountingFundWidget(accountingFundItem: accountingFundItem));
        },)
      ],
      ),
    );
  }
}
