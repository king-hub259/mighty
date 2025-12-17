import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/feature/cms_management/about_us/presentation/widgets/about_us_widget.dart';
import 'package:mighty_school/util/dimensions.dart';

class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({super.key});

  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: CustomAppBar(title: "about_us".tr),
      body: CustomWebScrollView(controller: scrollController, slivers: const [

        SliverToBoxAdapter(child: Padding(
          padding: EdgeInsets.all(Dimensions.paddingSizeDefault),
          child: Padding(padding: EdgeInsets.all(Dimensions.paddingSizeDefault),
            child: AboutUsWidget(),
          ),
        ),)
      ],),
    );
  }
}
