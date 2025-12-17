import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_title.dart';
import 'package:mighty_school/feature/account_management/accounting_funds/logic/account_fund_controller.dart';
import 'package:mighty_school/feature/account_management/accounting_funds/presentation/widgets/accounting_fund_dropdown.dart';

class SelectAccountingFundWidget extends StatefulWidget {
  
  final String title;
  const SelectAccountingFundWidget({super.key, required this.title});

  @override
  State<SelectAccountingFundWidget> createState() => _SelectAccountingFundWidgetState();
}

class _SelectAccountingFundWidgetState extends State<SelectAccountingFundWidget> {
  @override
  void initState() {
    if(Get.find<AccountingFundController>().accountingFundModel == null){
      Get.find<AccountingFundController>().getAccountingFundList(1);
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      CustomTitle(title: widget.title),
      GetBuilder<AccountingFundController>(
          builder: (accountingFundController) {
            return Padding(padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: AccountingFundDropdown(width: Get.width, title: "select".tr,
                items: accountingFundController.accountingFundModel?.data?.data??[],
                selectedValue: accountingFundController.selectedAccountingFundItem,
                onChanged: (val){
                  accountingFundController.selectAccountingFundItem(val!);
                },
              ),);
          }
      ),
    ],);
  }
}
