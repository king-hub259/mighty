import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/feature/account_management/chart_of_account/presentation/widgets/chart_of_account_widget.dart';

class ChartOfAccountScreen extends StatefulWidget {
  final bool fromReceipt;
  const ChartOfAccountScreen({super.key,  this.fromReceipt = false});

  @override
  State<ChartOfAccountScreen> createState() => _ChartOfAccountScreenState();
}

class _ChartOfAccountScreenState extends State<ChartOfAccountScreen> {
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "chart_of_account".tr),
      body: CustomWebScrollView(slivers: [
        SliverToBoxAdapter(child: Column(children: [
          ChartOfAccountWidget(scrollController: scrollController,)
        ],),)
      ],),
    );
  }
}
