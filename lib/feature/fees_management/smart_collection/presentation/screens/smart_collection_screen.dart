import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/feature/fees_management/smart_collection/presentation/widgets/smart_collection_student_list_widget.dart';
import 'package:mighty_school/util/dimensions.dart';

class SmartCollectionScreen extends StatefulWidget {
  const SmartCollectionScreen({super.key});

  @override
  State<SmartCollectionScreen> createState() => _SmartCollectionScreenState();
}

class _SmartCollectionScreenState extends State<SmartCollectionScreen> {
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: CustomAppBar(title: "smart_collection".tr),
    body: const CustomWebScrollView(slivers: [

      SliverToBoxAdapter(child: Padding(padding: EdgeInsets.all(Dimensions.paddingSizeDefault),
        child: SmartCollectionStudentListWidget()))
    ],),

    );
  }
}
