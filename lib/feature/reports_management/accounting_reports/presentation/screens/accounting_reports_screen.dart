import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/common/widget/sub_menu_item_widget.dart';
import 'package:mighty_school/feature/menu_section/controller/menu_type_controller.dart';
import 'package:mighty_school/feature/reports_management/accounting_reports/presentation/screens/balance_sheet_screen.dart';
import 'package:mighty_school/feature/reports_management/accounting_reports/presentation/screens/trail_balance_screen.dart';
import 'package:mighty_school/feature/reports_management/accounting_reports/presentation/screens/income_statement_screen.dart';
import 'package:mighty_school/feature/reports_management/accounting_reports/presentation/screens/cash_flow_statement_screen.dart';
import 'package:mighty_school/feature/reports_management/accounting_reports/presentation/screens/voucher_wise_screen.dart';
import 'package:mighty_school/feature/reports_management/accounting_reports/presentation/screens/user_wise_screen.dart';
import 'package:mighty_school/feature/reports_management/accounting_reports/presentation/screens/ledger_wise_screen.dart';
import 'package:mighty_school/feature/reports_management/accounting_reports/presentation/screens/fund_wise_screen.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/images.dart';

class AccountingReportsScreen extends StatefulWidget {
  const AccountingReportsScreen({super.key});

  @override
  State<AccountingReportsScreen> createState() => _AccountingReportsScreenState();
}

class _AccountingReportsScreenState extends State<AccountingReportsScreen> {
  List<MainMenuModel> accountingReportsItems = [
    MainMenuModel(icon: Images.report, title: 'balance_sheet', widget: const BalanceSheetScreen()),
    MainMenuModel(icon: Images.report, title: 'trial_balance', widget: const TrailBalanceScreen()),
    MainMenuModel(icon: Images.report, title: 'income_statement', widget: const IncomeStatementScreen()),
    MainMenuModel(icon: Images.report, title: 'cash_flow_statement', widget: const CashFlowStatementScreen()),
    MainMenuModel(icon: Images.report, title: 'voucher_wise_report', widget: const VoucherWiseScreen()),
    MainMenuModel(icon: Images.report, title: 'user_wise_report', widget: const UserWiseScreen()),
    MainMenuModel(icon: Images.report, title: 'ledger_wise_report', widget: const LedgerWiseScreen()),
    MainMenuModel(icon: Images.report, title: 'fund_wise_report', widget: const FundWiseScreen()),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(title: "accounting_reports".tr,),
        body: CustomWebScrollView(slivers: [
          SliverToBoxAdapter(child:Padding(padding: const EdgeInsets.only(top: Dimensions.paddingSizeDefault),
            child: ListView.builder(
                itemCount: accountingReportsItems.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                itemBuilder: (context, index){
                  return InkWell(onTap: ()=> Get.to(accountingReportsItems[index].widget),
                      child: SubMenuItemWidget(icon: accountingReportsItems[index].icon, title: accountingReportsItems[index].title)
                  );
                }),
          ),)
        ],)
    );
  }
}