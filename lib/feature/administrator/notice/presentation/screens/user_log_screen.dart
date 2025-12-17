import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/feature/administrator/notice/presentation/widgets/user_log_widget.dart';

class UserLogScreen extends StatelessWidget {
  const UserLogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ScrollController scrollController = ScrollController();
    return Scaffold(
      appBar: CustomAppBar(title: "user_log".tr),
      body: CustomWebScrollView(slivers: [
        SliverToBoxAdapter(child: UserLogListWidget(scrollController: scrollController,))

      ]),
    );
  }
}
