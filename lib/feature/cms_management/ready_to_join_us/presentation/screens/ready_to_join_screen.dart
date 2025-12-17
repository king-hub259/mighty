import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/feature/cms_management/banner/presentation/widgets/banner_list_widget.dart';
import 'package:mighty_school/feature/cms_management/ready_to_join_us/presentation/widgets/ready_to_join_list_widget.dart';
import 'package:mighty_school/util/dimensions.dart';

class ReadyToJoinScreen extends StatefulWidget {
  const ReadyToJoinScreen({super.key});

  @override
  State<ReadyToJoinScreen> createState() => _ReadyToJoinScreenState();
}

class _ReadyToJoinScreenState extends State<ReadyToJoinScreen> {
  ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: CustomAppBar(title: "ready_to_join".tr),
      body: CustomWebScrollView(controller: scrollController, slivers: [

        SliverToBoxAdapter(child: Padding(
          padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
          child: Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
            child: ReadyToJoinListWidget(scrollController: scrollController),
          ),
        ),)
      ],),
    );
  }
}
