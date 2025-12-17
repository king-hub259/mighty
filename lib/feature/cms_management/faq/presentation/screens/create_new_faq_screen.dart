import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/feature/cms_management/faq/domain/model/faq_model.dart';
import 'package:mighty_school/feature/cms_management/faq/presentation/widgets/create_new_faq_widget.dart';
import 'package:mighty_school/util/dimensions.dart';

class CreateNewFAqScreen extends StatefulWidget {
  final FaqItem? faqItem;
  const CreateNewFAqScreen({super.key, this.faqItem});

  @override
  State<CreateNewFAqScreen> createState() => _CreateNewFAqScreenState();
}

class _CreateNewFAqScreenState extends State<CreateNewFAqScreen> {
  ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: CustomAppBar(title: "faq".tr),
      body: CustomWebScrollView(controller: scrollController, slivers: [

        SliverToBoxAdapter(child: Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
          child: Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
            child: CreateNewFaqWidget(faqItem: widget.faqItem),
          ),
        ),)
      ],),
    );
  }
}
