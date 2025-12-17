import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/feature/cms_management/why_choose_us/presentation/widgets/why_choose_us_list_widget.dart';
import 'package:mighty_school/util/dimensions.dart';

class WhyChooseUsScreen extends StatefulWidget {
  const WhyChooseUsScreen({super.key});

  @override
  State<WhyChooseUsScreen> createState() => _WhyChooseUsScreenState();
}

class _WhyChooseUsScreenState extends State<WhyChooseUsScreen> {
  ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar:CustomAppBar(title: "why_choose_us".tr),
      body: CustomWebScrollView(controller: scrollController, slivers: [

        SliverToBoxAdapter(child: Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
          child: Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
            child: WhyChooseUsListWidget(scrollController: scrollController),
          ),
        ),)
      ],),
    );
  }
}
