import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/feature/cms_management/why_choose_us/presentation/widgets/create_new_why_choose_us_widget.dart';
import 'package:mighty_school/util/dimensions.dart';

class CreateNewBenefitScreen extends StatefulWidget {
  const CreateNewBenefitScreen({super.key});

  @override
  State<CreateNewBenefitScreen> createState() => _CreateNewBenefitScreenState();
}

class _CreateNewBenefitScreenState extends State<CreateNewBenefitScreen> {
  ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: CustomAppBar(title: "why_choose_us".tr),
      body: CustomWebScrollView(controller: scrollController, slivers: const [

        SliverToBoxAdapter(child: Padding(padding: EdgeInsets.all(Dimensions.paddingSizeDefault),
          child: Padding(padding: EdgeInsets.all(Dimensions.paddingSizeDefault),
            child: CreateNewWhyChooseUsWidget()),
        ),)
      ],),
    );
  }
}
