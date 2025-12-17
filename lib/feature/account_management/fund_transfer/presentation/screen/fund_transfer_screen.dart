import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/feature/account_management/fund_transfer/presentation/widgets/fund_transfer_widget.dart';

class FundTransferScreen extends StatefulWidget {
  const FundTransferScreen({super.key});

  @override
  State<FundTransferScreen> createState() => _FundTransferScreenState();
}

class _FundTransferScreenState extends State<FundTransferScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "fund_transfer".tr),
      body: const CustomWebScrollView(slivers: [
        SliverToBoxAdapter(child: Column(children: [
          FundTransferWidget()
        ],),)
      ],),
    );
  }
}
