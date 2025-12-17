import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/feature/zoom_class/logic/zoom_class_controller.dart';
import 'package:mighty_school/feature/zoom_class/presentation/widgets/zoom_class_widget.dart';

class ZoomClassScreen extends StatefulWidget {
  const ZoomClassScreen({super.key});

  @override
  State<ZoomClassScreen> createState() => _ZoomClassScreenState();
}

class _ZoomClassScreenState extends State<ZoomClassScreen> {
  ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "zoom_class".tr),
      body: CustomWebScrollView(controller: scrollController, slivers: [

        SliverToBoxAdapter(child: GetBuilder<ZoomClassController>(
            builder: (thirdPartyController) {
              return ZoomClassWidget(scrollController: scrollController);
            }
        ))
      ]),
    );
  }
}
