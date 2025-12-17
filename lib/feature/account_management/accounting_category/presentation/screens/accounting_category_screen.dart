
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/common/widget/custom_floating_button.dart';
import 'package:mighty_school/feature/account_management/accounting_category/presentation/screens/create_new_account_category_screen.dart';
import 'package:mighty_school/feature/account_management/accounting_category/presentation/widgets/accounting_category_widget.dart';

class AccountingCategoryScreen extends StatefulWidget {
  const AccountingCategoryScreen({super.key});

  @override
  State<AccountingCategoryScreen> createState() => _AccountingCategoryScreenState();
}

class _AccountingCategoryScreenState extends State<AccountingCategoryScreen> {
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "accounting_category".tr),
      body: CustomWebScrollView(controller: scrollController, slivers: [
        SliverToBoxAdapter(child: AccountingCategoryWidget(scrollController: scrollController))
      ],),


      floatingActionButton: CustomFloatingButton(onTap: ()=> Get.dialog(const CreateNewAccountingCategoryScreen()))
    );
  }
}



