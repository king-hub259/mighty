import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/feature/fees_management/fees_start_up/presentation/widgets/fees_start_up_widget.dart';

class FeesStartupScreen extends StatefulWidget {
  const FeesStartupScreen({super.key});

  @override
  State<FeesStartupScreen> createState() => _FeesStartupScreenState();
}

class _FeesStartupScreenState extends State<FeesStartupScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(appBar: CustomAppBar(title: "fees_startup".tr),
      body: const CustomWebScrollView(slivers: [
        SliverToBoxAdapter(child:  FeesStartUpWidget(),)
      ]));
  }
}
