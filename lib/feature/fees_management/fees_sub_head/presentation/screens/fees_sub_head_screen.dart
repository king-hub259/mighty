import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/common/widget/custom_floating_button.dart';
import 'package:mighty_school/feature/fees_management/fees_sub_head/presentation/screens/create_new_fees_sub_head_dialog.dart';
import 'package:mighty_school/feature/fees_management/fees_sub_head/presentation/widgets/fees_sub_head_list_widget.dart';

class FeesSubHeadScreen extends StatefulWidget {
  const FeesSubHeadScreen({super.key});

  @override
  State<FeesSubHeadScreen> createState() => _FeesSubHeadScreenState();
}

class _FeesSubHeadScreenState extends State<FeesSubHeadScreen> {
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: CustomAppBar(title: "fees_sub_head".tr),
    body: CustomWebScrollView(controller: scrollController, slivers:  [
      SliverToBoxAdapter(child: FeesSubHeadListWidget(scrollController: scrollController,))
    ],),
      floatingActionButton: CustomFloatingButton(title: "add", onTap: () => Get.dialog(const CreateNewFeesSubHeadDialog())));
  }
}
