import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/common/widget/no_data_found.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';

class ReturnAdvanceScreen extends StatefulWidget {
  const ReturnAdvanceScreen({super.key});

  @override
  State<ReturnAdvanceScreen> createState() => _ReturnAdvanceScreenState();
}

class _ReturnAdvanceScreenState extends State<ReturnAdvanceScreen> {
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "return_advance".tr),
      body: CustomWebScrollView(controller: scrollController, slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
            child: Column(
              children: [
                Text(
                  "return_advance_salary".tr,
                  style: textMedium.copyWith(fontSize: Dimensions.fontSizeLarge),
                ),
                const SizedBox(height: Dimensions.paddingSizeLarge),
                const NoDataFound(),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}