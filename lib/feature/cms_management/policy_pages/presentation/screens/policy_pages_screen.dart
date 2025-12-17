import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/common/widget/custom_button.dart';
import 'package:mighty_school/feature/cms_management/policy_pages/presentation/widgets/policy_pages_type_widget.dart';
import 'package:mighty_school/util/dimensions.dart';

class PolicyPagesScreen extends StatefulWidget {
  const PolicyPagesScreen({super.key});

  @override
  State<PolicyPagesScreen> createState() => _PolicyPagesScreenState();
}

class _PolicyPagesScreenState extends State<PolicyPagesScreen> {
  ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: CustomAppBar(title: "policy_list".tr),
      body: CustomWebScrollView(controller: scrollController, slivers: [

        SliverToBoxAdapter(child: Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
          child: Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
            child: Column(children: [
              const PolicyPagesTypeWidget(),

              CustomButton(onTap: (){}, text: "update".tr)
            ]),
          ),
        ),)
      ],),
    );
  }
}
