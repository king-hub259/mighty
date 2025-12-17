
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/common/widget/custom_floating_button.dart';
import 'package:mighty_school/feature/administrator/notice/presentation/screens/create_new_notice_screen.dart';
import 'package:mighty_school/feature/administrator/notice/presentation/widgets/notice_list_widget.dart';
import 'package:mighty_school/util/dimensions.dart';

class NoticeScreen extends StatefulWidget {
  const NoticeScreen({super.key});

  @override
  State<NoticeScreen> createState() => _NoticeScreenState();
}

class _NoticeScreenState extends State<NoticeScreen> {
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "notice".tr),
      body: CustomWebScrollView(controller: scrollController, slivers: [
        SliverToBoxAdapter(child: Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
          child: NoticeListWidget(scrollController: scrollController)))
      ],),


      floatingActionButton: CustomFloatingButton(title: "add".tr, onTap: ()=>Get.dialog(const CreateNewNoticeScreen())));
  }
}



