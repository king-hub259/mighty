
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/common/widget/custom_floating_button.dart';
import 'package:mighty_school/feature/account_management/accounting_group/logic/account_group_controller.dart';
import 'package:mighty_school/feature/account_management/accounting_group/presentation/screen/create_new_accounting_group_item_widget.dart';
import 'package:mighty_school/feature/account_management/accounting_group/presentation/widgets/accounting_group_widget.dart';


class AccountingGroupScreen extends StatefulWidget {
  const AccountingGroupScreen({super.key});

  @override
  State<AccountingGroupScreen> createState() => _AccountingGroupScreenState();
}

class _AccountingGroupScreenState extends State<AccountingGroupScreen> {
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: CustomAppBar(title: "accounting_group".tr,),

      body: RefreshIndicator(onRefresh: () async{
          await Get.find<AccountingGroupController>().getAccountingGroupList(1);
        },
        child: CustomWebScrollView(slivers: [
          SliverToBoxAdapter(child: AccountingGroupWidget(scrollController: scrollController))
        ],),
      ),

      floatingActionButton: CustomFloatingButton(onTap: ()=> Get.dialog(const CreateNewAccountingGroupWidget()))

    );
  }
}
