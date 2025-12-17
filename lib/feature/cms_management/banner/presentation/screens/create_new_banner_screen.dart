import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/feature/cms_management/banner/presentation/widgets/create_new_banner_widget.dart';
import 'package:mighty_school/util/dimensions.dart';

class CreateNewBannerScreen extends StatefulWidget {
  const CreateNewBannerScreen({super.key});

  @override
  State<CreateNewBannerScreen> createState() => _CreateNewBannerScreenState();
}

class _CreateNewBannerScreenState extends State<CreateNewBannerScreen> {
  ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: CustomAppBar(title: "banner".tr),
      body: CustomWebScrollView(controller: scrollController, slivers: const [

        SliverToBoxAdapter(child: Padding(padding: EdgeInsets.all(Dimensions.paddingSizeDefault),
          child: Padding(padding: EdgeInsets.all(Dimensions.paddingSizeDefault),
            child: CreateNewBannerWidget(),
          ),
        ),)
      ],),
    );
  }
}
