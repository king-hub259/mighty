import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/confirmation_dialog.dart';
import 'package:mighty_school/common/widget/edit_delete_section.dart';
import 'package:mighty_school/common/widget/numbering_widget.dart';
import 'package:mighty_school/feature/account_management/accounting_category/controller/accounting_category_controller.dart';
import 'package:mighty_school/feature/account_management/accounting_category/domain/models/accounting_category_model.dart';
import 'package:mighty_school/feature/account_management/accounting_category/presentation/screens/create_new_account_category_screen.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';

class AccountingCategoryItemWidget extends StatelessWidget {
  final AccountingCategoryItem? accountingCategoryItem;
  final int index;
  const AccountingCategoryItemWidget({super.key, this.accountingCategoryItem, required this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.fromLTRB(Dimensions.paddingSizeDefault, Dimensions.paddingSizeDefault, Dimensions.paddingSizeDefault, 0),
      child: Row(spacing: Dimensions.paddingSizeDefault, crossAxisAlignment: CrossAxisAlignment.start, children: [

        NumberingWidget(index: index),
        Expanded(child: Text('${accountingCategoryItem?.name}', style: textRegular.copyWith())),
        EditDeleteSection(horizontal: true, onDelete: (){
          Get.dialog(ConfirmationDialog(title: "accounting_category", content: "accounting_category",
            onTap: (){
              Get.back();
              Get.find<AccountingCategoryController>().deleteAccountingCategory(accountingCategoryItem!.id!);
            },));

        }, onEdit: (){
          Get.dialog(CreateNewAccountingCategoryScreen(accountingCategoryItem: accountingCategoryItem));
        },)
      ],
      ),
    );
  }
}