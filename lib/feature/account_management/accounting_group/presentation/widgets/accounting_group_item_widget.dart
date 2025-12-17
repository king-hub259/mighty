import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/confirmation_dialog.dart';
import 'package:mighty_school/common/widget/custom_contaner.dart';
import 'package:mighty_school/common/widget/custom_divider.dart';
import 'package:mighty_school/common/widget/edit_delete_section.dart';
import 'package:mighty_school/feature/account_management/accounting_group/domain/model/accounting_group_model.dart';
import 'package:mighty_school/feature/account_management/accounting_group/logic/account_group_controller.dart';
import 'package:mighty_school/feature/account_management/accounting_group/presentation/screen/create_new_accounting_group_item_widget.dart';
import 'package:mighty_school/helper/responsive_helper.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';

class AccountingGroupItemWidget extends StatelessWidget {
  final AccountingGroupItem? accountingGroupItem;
  final int index;
  const AccountingGroupItemWidget({super.key, this.accountingGroupItem, required this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.fromLTRB(Dimensions.paddingSizeDefault, Dimensions.paddingSizeDefault, Dimensions.paddingSizeDefault, 0),
      child: ResponsiveHelper.isDesktop(context)?
      Column(children: [
        Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Expanded(child: Text('${accountingGroupItem?.name}', style: textRegular.copyWith(fontSize: Dimensions.fontSizeDefault),)),

          EditDeleteSection(horizontal: true, onDelete: (){
            Get.dialog(ConfirmationDialog(
              title: "accounting_group",
              content: "accounting_group",
              onTap: (){
                Get.back();
                Get.find<AccountingGroupController>().deleteAccountingGroup(accountingGroupItem!.id!);
              },));

          }, onEdit: (){
            Get.dialog(CreateNewAccountingGroupWidget(accountingGroupItem: accountingGroupItem,));
          },)
        ],
        ),
        const CustomDivider(verticalPadding: Dimensions.paddingSizeExtraSmall,)
      ],
      ):
      CustomContainer(
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Expanded(child: Text('${"name".tr} : ${accountingGroupItem?.name}', style: textRegular.copyWith(fontSize: Dimensions.fontSizeDefault),)),
          EditDeleteSection(onDelete: (){
            Get.dialog(ConfirmationDialog(
              title: "accounting_group",
              content: "accounting_group",
              onTap: (){
                Get.back();
                Get.find<AccountingGroupController>().deleteAccountingGroup(accountingGroupItem!.id!);
              },));

          }, onEdit: (){
            Get.dialog(CreateNewAccountingGroupWidget(accountingGroupItem: accountingGroupItem,));
          },)
        ],
        ),
      ),
    );
  }
}