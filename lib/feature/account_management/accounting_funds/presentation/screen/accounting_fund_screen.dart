
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/common/widget/custom_floating_button.dart';
import 'package:mighty_school/feature/account_management/accounting_funds/logic/account_fund_controller.dart';
import 'package:mighty_school/feature/account_management/accounting_funds/presentation/screen/create_new_accounting_fund_item_widget.dart';
import 'package:mighty_school/feature/account_management/accounting_funds/presentation/widgets/accounting_fund_widget.dart';


class AccountingFundScreen extends StatefulWidget {
  const AccountingFundScreen({super.key});

  @override
  State<AccountingFundScreen> createState() => _AccountingFundScreenState();
}

class _AccountingFundScreenState extends State<AccountingFundScreen> {
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "accounting_fund".tr,),

      body: RefreshIndicator(onRefresh: () async=> await Get.find<AccountingFundController>().getAccountingFundList(1),
        child: CustomWebScrollView(slivers: [
          SliverToBoxAdapter(child: AccountingFundWidget(scrollController: scrollController))
        ])),

      floatingActionButton: CustomFloatingButton(onTap: ()=> Get.dialog(const CreateNewAccountingFundWidget()),)
    );
  }
}
