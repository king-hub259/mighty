import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/feature/account_management/payment/presentation/widgets/payment_widget.dart';

class ReceiptScreen extends StatefulWidget {
  const ReceiptScreen({super.key});

  @override
  State<ReceiptScreen> createState() => _ReceiptScreenState();
}

class _ReceiptScreenState extends State<ReceiptScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title:"Receipt".tr),
      body: const CustomWebScrollView(slivers: [
        SliverToBoxAdapter(child: Column(children: [
          PaymentWidget(fromReceipt: true)
        ],),)
      ],),
    );
  }
}
