
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/common/widget/custom_floating_button.dart';
import 'package:mighty_school/feature/sms/purchase_sms/presentation/screens/create_new_purchase_sms_screen.dart';
import 'package:mighty_school/feature/sms/purchase_sms/presentation/widgets/purchase_sms_list_widget.dart';

class PurchaseSmsScreen extends StatefulWidget {
  const PurchaseSmsScreen({super.key});

  @override
  State<PurchaseSmsScreen> createState() => _PurchaseSmsScreenState();
}

class _PurchaseSmsScreenState extends State<PurchaseSmsScreen> {
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "purchase_sms".tr),
      body: CustomWebScrollView(controller: scrollController, slivers: [
        SliverToBoxAdapter(child: PurchaseSmsListWidget(scrollController: scrollController))
      ],),


      floatingActionButton: CustomFloatingButton(title: "add", onTap: ()=> Get.dialog(const CreateNewPurchaseSmsScreen())));
  }
}



