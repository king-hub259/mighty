import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_contaner.dart';
import 'package:mighty_school/feature/report/presentation/widgets/dashboard_heading_section_widget.dart';
import 'package:mighty_school/feature/saas_panel/saas_admin_dashboard/logic/saas_admin_dashboard_controller.dart';
import 'package:mighty_school/feature/saas_panel/saas_admin_dashboard/presentation/widgets/saas_admin_summery_number_widget.dart';
import 'package:mighty_school/feature/saas_panel/saas_admin_dashboard/presentation/widgets/saas_collection_overview_summery_widget.dart';
import 'package:mighty_school/util/dimensions.dart';

class SaasAdminDashboardSummeryWidget extends StatefulWidget {
  final ScrollController scrollController;
  const SaasAdminDashboardSummeryWidget({super.key, required this.scrollController});

  @override
  State<SaasAdminDashboardSummeryWidget> createState() => _SaasAdminDashboardSummeryWidgetState();
}

class _SaasAdminDashboardSummeryWidgetState extends State<SaasAdminDashboardSummeryWidget> {
  @override
  void initState() {

    if(Get.find<SaasAdminDashboardController>().saasAdminDashboardReportModel == null){
      Get.find<SaasAdminDashboardController>().getSaasAdminDashboardReport();
    }

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  const Padding(padding:  EdgeInsets.all(Dimensions.paddingSizeDefault),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, spacing: Dimensions.paddingSizeExtraLarge,  children: [

        DashboardHeadingSectionWidget(),
        SaasAdminSummeryNumberWidget(),

        CustomContainer(child: SaasCollectionOverviewWidget()),

      ],),
    );
  }
}
