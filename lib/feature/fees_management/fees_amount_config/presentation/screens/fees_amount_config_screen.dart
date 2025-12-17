import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/feature/fees_management/fees_amount_config/presentation/widgets/fees_web_widget.dart';

class FeesAmountConfigScreen extends StatefulWidget {
  const FeesAmountConfigScreen({super.key});

  @override
  State<FeesAmountConfigScreen> createState() => _FeesAmountConfigScreenState();
}

class _FeesAmountConfigScreenState extends State<FeesAmountConfigScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: CustomAppBar(title: "fees_amount_config".tr),
        body: const CustomWebScrollView(slivers: [
          SliverToBoxAdapter(child:  FeesWebWidget(),)
        ]));
  }
}
