import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/feature/account_management/payment/presentation/widgets/payment_widget.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key,});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "payment".tr),
      body: const CustomWebScrollView(slivers: [
        SliverToBoxAdapter(child: Column(children: [
          PaymentWidget(fromReceipt: true)
        ],),)
      ],),
    );
  }
}
