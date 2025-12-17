import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/common/widget/custom_floating_button.dart';
import 'package:mighty_school/feature/fees_management/waiver/presentation/screens/create_new_waiver_dialog.dart';
import 'package:mighty_school/feature/fees_management/waiver/presentation/widgets/waiver_list_widget.dart';

class WaiverScreen extends StatefulWidget {
  const WaiverScreen({super.key});

  @override
  State<WaiverScreen> createState() => _WaiverScreenState();
}

class _WaiverScreenState extends State<WaiverScreen> {
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: CustomAppBar(title: "waiver".tr),
    body: CustomWebScrollView(controller: scrollController, slivers:  [
      SliverToBoxAdapter(child: WaiverListWidget(scrollController: scrollController,))
    ],),
      floatingActionButton: CustomFloatingButton(title: "add", onTap: () => Get.dialog(const CreateNewWaiverDialog())));
  }
}
