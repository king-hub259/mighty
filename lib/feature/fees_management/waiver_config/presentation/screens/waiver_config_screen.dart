import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/feature/fees_management/waiver_config/presentation/widgets/waiver_config_widget.dart';

class WaiverConfigScreen extends StatefulWidget {
  const WaiverConfigScreen({super.key});

  @override
  State<WaiverConfigScreen> createState() => _WaiverConfigScreenState();
}

class _WaiverConfigScreenState extends State<WaiverConfigScreen> {
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: CustomAppBar(title: "waiver_config".tr),
    body: CustomWebScrollView(controller: scrollController, slivers:  const [
      SliverToBoxAdapter(child: WaiverConfigWidget())
    ],),
    );
  }
}
