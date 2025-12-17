import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/feature/reports_management/fees_reports/logic/fees_reports_controller.dart';
import 'package:mighty_school/feature/reports_management/fees_reports/presentation/widgets/head_wise_fees_info_list_widget.dart';
import 'package:mighty_school/feature/reports_management/fees_reports/presentation/widgets/select_year_and_month_widget.dart';
import 'package:mighty_school/util/dimensions.dart';

class HeadWiseFeesInfoScreen extends StatefulWidget {
  const HeadWiseFeesInfoScreen({super.key});

  @override
  State<HeadWiseFeesInfoScreen> createState() => _HeadWiseFeesInfoScreenState();
}

class _HeadWiseFeesInfoScreenState extends State<HeadWiseFeesInfoScreen> {
  @override
  void initState() {
    super.initState();
    Get.find<FeesReportsController>().getHeadWisePayment();
  }
  ScrollController scrollController = ScrollController();

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "head_wise_fees_info".tr),
      body: CustomWebScrollView(slivers: [
        SliverToBoxAdapter(
          child: Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
            child: Column(spacing: Dimensions.paddingSizeDefault, children: [
              SelectYearAndMonthWidget(onTap: (){
                Get.find<FeesReportsController>().getHeadWisePayment();
              }),
              HeadWiseFeesInfoListWidget(scrollController: scrollController),
              ],
            ),
          ),
        ),
      ],
      ),
    );
  }
}
