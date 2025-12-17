import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/feature/fees_management/fees_mapping/presentation/widgets/fees_mapping_web_widget.dart';

class FeesMappingScreen extends StatefulWidget {
  const FeesMappingScreen({super.key});

  @override
  State<FeesMappingScreen> createState() => _FeesMappingScreenState();
}

class _FeesMappingScreenState extends State<FeesMappingScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: CustomAppBar(title: "fees_mapping".tr),
        body: const CustomWebScrollView(slivers: [
          SliverToBoxAdapter(child:  FeesMappingWebWidget(),)
        ]));
  }
}
