import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/feature/cms_management/mobile_app_section/presentation/widgets/mobile_app_list_widget.dart';
import 'package:mighty_school/util/dimensions.dart';

class MobileAppScreen extends StatefulWidget {
  const MobileAppScreen({super.key});

  @override
  State<MobileAppScreen> createState() => _MobileAppScreenState();
}

class _MobileAppScreenState extends State<MobileAppScreen> {
  ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: CustomAppBar(title: "mobile_app_section".tr),
      body: CustomWebScrollView(controller: scrollController, slivers: [

        SliverToBoxAdapter(child: Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
          child: Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
            child: MobileAppListWidget(scrollController: scrollController),
          ),
        ),)
      ],),
    );
  }
}
