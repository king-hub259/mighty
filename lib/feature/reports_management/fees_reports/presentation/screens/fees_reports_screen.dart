import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/common/widget/sub_menu_item_widget.dart';
import 'package:mighty_school/feature/menu_section/controller/menu_type_controller.dart';
import 'package:mighty_school/feature/reports_management/fees_reports/presentation/screens/fees_monthly_report_screen.dart';
import 'package:mighty_school/feature/reports_management/fees_reports/presentation/screens/fees_payment_info_screen.dart';
import 'package:mighty_school/feature/reports_management/fees_reports/presentation/screens/head_wise_fees_info_screen.dart';
import 'package:mighty_school/feature/reports_management/fees_reports/presentation/screens/unpaid_fees_info_screen.dart';
import 'package:mighty_school/feature/reports_management/fees_reports/presentation/screens/fees_payment_ratio_screen.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/images.dart';

class FeesReportsScreen extends StatefulWidget {
  const FeesReportsScreen({super.key});

  @override
  State<FeesReportsScreen> createState() => _FeesReportsScreenState();
}

class _FeesReportsScreenState extends State<FeesReportsScreen> {
  List<MainMenuModel> feesReportsItems = [
    MainMenuModel(icon: Images.report, title: 'monthly_fees_report', widget: const FeesMonthlyReportScreen()),
    MainMenuModel(icon: Images.report, title: 'payment_fees_info', widget: const FeesPaymentInfoScreen()),
    MainMenuModel(icon: Images.report, title: 'head_wise_fees_info', widget: const HeadWiseFeesInfoScreen()),
    MainMenuModel(icon: Images.report, title: 'unpaid_fees_info', widget: const UnpaidFeesInfoScreen()),
    MainMenuModel(icon: Images.report, title: 'payment_ratio_info', widget: const FeesPaymentRatioScreen()),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(title: "fees_reports".tr,),
        body: CustomWebScrollView(slivers: [
          SliverToBoxAdapter(child:Padding(padding: const EdgeInsets.only(top: Dimensions.paddingSizeDefault),
            child: ListView.builder(
                itemCount: feesReportsItems.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                itemBuilder: (context, index){
                  return InkWell(onTap: ()=> Get.to(feesReportsItems[index].widget),
                      child: SubMenuItemWidget(icon: feesReportsItems[index].icon, title: feesReportsItems[index].title)
                  );
                }),
          ),)
        ],)
    );
  }
}