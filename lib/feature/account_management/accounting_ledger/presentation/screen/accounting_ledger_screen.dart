
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/common/widget/custom_floating_button.dart';
import 'package:mighty_school/feature/account_management/accounting_ledger/logic/account_ledger_controller.dart';
import 'package:mighty_school/feature/account_management/accounting_ledger/presentation/screen/create_new_accounting_ledger_item_widget.dart';
import 'package:mighty_school/feature/account_management/accounting_ledger/presentation/widgets/accounting_ledger_widget.dart';


class AccountingLedgerScreen extends StatefulWidget {
  const AccountingLedgerScreen({super.key});

  @override
  State<AccountingLedgerScreen> createState() => _AccountingLedgerScreenState();
}

class _AccountingLedgerScreenState extends State<AccountingLedgerScreen> {
  ScrollController scrollController = ScrollController();
  @override
  void initState() {
    Get.find<AccountLedgerController>().getAccountingLedgerList(1);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "accounting_ledger".tr,),
      body: RefreshIndicator(
        onRefresh: () async{
          await Get.find<AccountLedgerController>().getAccountingLedgerList(1);
        },
        child: CustomWebScrollView(slivers: [
          SliverToBoxAdapter(child: AccountingLedgerWidget(scrollController: scrollController))
        ])),

      floatingActionButton: CustomFloatingButton(onTap: ()=>Get.dialog(const CreateNewAccountingLedgerWidget()))
    );
  }
}
