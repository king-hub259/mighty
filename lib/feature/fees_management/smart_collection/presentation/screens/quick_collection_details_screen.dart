import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/feature/fees_management/smart_collection/presentation/widgets/quick_collection_details_widget.dart';
import 'package:mighty_school/util/dimensions.dart';

class QuickCollectionDetailsScreen extends StatefulWidget {
  const QuickCollectionDetailsScreen({super.key});

  @override
  State<QuickCollectionDetailsScreen> createState() => _QuickCollectionDetailsScreenState();
}

class _QuickCollectionDetailsScreenState extends State<QuickCollectionDetailsScreen> {
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: CustomAppBar(title: "quick_collection_details".tr),
      body: const CustomWebScrollView(slivers: [

        SliverToBoxAdapter(child: Padding(padding: EdgeInsets.all(Dimensions.paddingSizeDefault),
            child: QuickCollectionDetailsWidget()))
      ],),

    );
  }
}
