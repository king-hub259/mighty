import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/common/widget/sub_menu_item_widget.dart';
import 'package:mighty_school/feature/academic_configuration/group/presentation/screens/group_screen.dart';
import 'package:mighty_school/feature/account_management/accounting_category/presentation/screens/accounting_category_screen.dart';
import 'package:mighty_school/feature/account_management/accounting_funds/presentation/screen/accounting_fund_screen.dart';
import 'package:mighty_school/feature/account_management/accounting_ledger/presentation/screen/accounting_ledger_screen.dart';
import 'package:mighty_school/feature/account_management/chart_of_account/presentation/screen/chart_of_account_screen.dart';
import 'package:mighty_school/feature/account_management/contra/presentation/screen/contra_screen.dart';
import 'package:mighty_school/feature/account_management/fund_transfer/presentation/screen/fund_transfer_screen.dart';
import 'package:mighty_school/feature/account_management/journal/presentation/screen/journal_screen.dart';
import 'package:mighty_school/feature/account_management/payment/presentation/screen/payment_screen.dart';
import 'package:mighty_school/feature/account_management/payment/presentation/screen/receipt_screen.dart';
import 'package:mighty_school/feature/menu_section/controller/menu_type_controller.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/images.dart';


class AccountManagementScreen extends StatefulWidget {
  const AccountManagementScreen({super.key});

  @override
  State<AccountManagementScreen> createState() => _AccountManagementScreenState();
}

class _AccountManagementScreenState extends State<AccountManagementScreen> {
  List<MainMenuModel> studentInformationItems = [
    MainMenuModel(icon: Images.accounting, title: 'ledger', widget:  const AccountingLedgerScreen()),
    MainMenuModel(icon: Images.accounting, title: 'fund', widget:  const AccountingFundScreen()),
    MainMenuModel(icon: Images.accounting, title: 'category', widget:  const AccountingCategoryScreen()),
    MainMenuModel(icon: Images.accounting, title: 'group', widget:  const GroupScreen()),
    MainMenuModel(icon: Images.accounting, title: 'payment', widget:  const PaymentScreen()),
    MainMenuModel(icon: Images.accounting, title: 'receipt', widget:  const ReceiptScreen()),
    MainMenuModel(icon: Images.accounting, title: 'contra', widget:  const ContraScreen()),
    MainMenuModel(icon: Images.accounting, title: 'journal', widget:  const JournalScreen()),
    MainMenuModel(icon: Images.accounting, title: 'fund_transfer', widget:  const FundTransferScreen()),
    MainMenuModel(icon: Images.accounting, title: 'chart_of_account', widget:  const ChartOfAccountScreen()),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: CustomAppBar(title: "account_management".tr,),
        body: CustomWebScrollView(slivers: [

          SliverToBoxAdapter(child:Padding(padding: const EdgeInsets.only(top: Dimensions.paddingSizeDefault),
            child: ListView.builder(
                itemCount: studentInformationItems.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                itemBuilder: (context, index){
                  return InkWell(onTap: ()=> Get.to(studentInformationItems[index].widget),
                      child: SubMenuItemWidget(icon: studentInformationItems[index].icon, title: studentInformationItems[index].title)
                  );
                }),
          ),)
        ],)
    );
  }
}
