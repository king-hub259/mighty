import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/feature/cms_management/mobile_app_section/domain/model/mobile_app_model.dart';
import 'package:mighty_school/feature/cms_management/mobile_app_section/presentation/widgets/create_new_mobile_app_widget.dart';
import 'package:mighty_school/util/dimensions.dart';

class CreateNewMobileAppSectionScreen extends StatefulWidget {
  final MobileAppItem? mobileAppItem;
  const CreateNewMobileAppSectionScreen({super.key, this.mobileAppItem});

  @override
  State<CreateNewMobileAppSectionScreen> createState() => _CreateNewMobileAppSectionScreenState();
}

class _CreateNewMobileAppSectionScreenState extends State<CreateNewMobileAppSectionScreen> {
  ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: CustomAppBar(title: "mobile_app_section".tr),
      body: CustomWebScrollView(controller: scrollController, slivers: [

        SliverToBoxAdapter(child: Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
          child: Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
            child: CreateNewMobileAppSectionWidget(mobileAppItem: widget.mobileAppItem),
          ),
        ),)
      ],),
    );
  }
}
