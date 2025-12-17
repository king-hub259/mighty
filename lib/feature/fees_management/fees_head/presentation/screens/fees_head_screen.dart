import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/common/widget/custom_floating_button.dart';
import 'package:mighty_school/feature/fees_management/fees_head/presentation/screens/create_new_fees_head_dialog.dart';
import 'package:mighty_school/feature/fees_management/fees_head/presentation/widgets/fees_head_list_widget.dart';

class FeesHeadScreen extends StatefulWidget {
  const FeesHeadScreen({super.key});

  @override
  State<FeesHeadScreen> createState() => _FeesHeadScreenState();
}

class _FeesHeadScreenState extends State<FeesHeadScreen> {
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: CustomAppBar(title: "fees_head".tr),
    body: CustomWebScrollView(controller: scrollController, slivers:  [
      SliverToBoxAdapter(child: FeesHeadListWidget(scrollController: scrollController,))
    ],),
      floatingActionButton: CustomFloatingButton(title: "add", onTap: () => Get.dialog(const CreateNewFeesHeadDialog())));
  }
}
