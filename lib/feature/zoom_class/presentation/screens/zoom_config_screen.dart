import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/feature/zoom_class/presentation/widgets/zoom_class_config_widget.dart';

class ZoomConfigScreen extends StatefulWidget {
  const ZoomConfigScreen({super.key});

  @override
  State<ZoomConfigScreen> createState() => _ZoomConfigScreenState();
}

class _ZoomConfigScreenState extends State<ZoomConfigScreen> {
  ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "zoom_config".tr),
      body: CustomWebScrollView(controller: scrollController, slivers: const [

        SliverToBoxAdapter(child: ZoomClassConfigWidget())
      ]),
    );
  }
}
