import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_contaner.dart';
import 'package:mighty_school/common/widget/custom_image.dart';
import 'package:mighty_school/feature/saas_panel/saas_admin_dashboard/domain/domain/saas_admin_dashboard_report_model.dart';
import 'package:mighty_school/feature/saas_panel/saas_admin_dashboard/logic/saas_admin_dashboard_controller.dart';
import 'package:mighty_school/helper/responsive_helper.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/images.dart';
import 'package:mighty_school/util/styles.dart';

class SaasAdminSummeryNumberWidget extends StatelessWidget {
  const SaasAdminSummeryNumberWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SaasAdminDashboardController>(
      builder: (saasAdminDashboardController) {
        SaasAdminDashboardReportModel? reportModel = saasAdminDashboardController.saasAdminDashboardReportModel;
        return ResponsiveHelper.isDesktop(context)?
        Row(spacing: Dimensions.paddingSizeDefault, children: [
            Expanded(child: CountingItemWidget(title: 'total_institute', color: Theme.of(context).primaryColor, count: reportModel?.data?.totalStudents ?? 0)),
            Expanded(child: CountingItemWidget(title: 'active_institute', color: Theme.of(context).colorScheme.tertiaryContainer, count: reportModel?.data?.totalActiveInstitute ?? 0,),),
            Expanded(child: CountingItemWidget(title: 'in_active_institute', color: Theme.of(context).colorScheme.secondary, count: reportModel?.data?.totalInactiveInstitute ?? 0,),),
            Expanded(child: CountingItemWidget(title: 'total_packages', color: Theme.of(context).colorScheme.surfaceContainer, count: reportModel?.data?.totalPackages ?? 0,)),

          ],
        ):Column(spacing: Dimensions.paddingSizeDefault, children: [
          Row(spacing: Dimensions.paddingSizeDefault, children: [
            Expanded(child: CountingItemWidget(title: 'total_institute', color: Theme.of(context).primaryColor, count: reportModel?.data?.totalStudents ?? 0)),
            Expanded(child: CountingItemWidget(title: 'active_institute', color: Theme.of(context).colorScheme.tertiaryContainer, count: reportModel?.data?.totalActiveInstitute ?? 0,),),

          ]),
          Row(spacing: Dimensions.paddingSizeDefault, children: [
            Expanded(child: CountingItemWidget(title: 'in_active_institute', color: Theme.of(context).colorScheme.secondary, count: reportModel?.data?.totalInactiveInstitute ?? 0,),),
            Expanded(child: CountingItemWidget(title: 'total_packages', color: Theme.of(context).colorScheme.surfaceContainer, count: reportModel?.data?.totalPackages ?? 0,)),
          ],
          )
        ]);
      },
    );
  }
}
class CountingItemWidget extends StatelessWidget {
  final String title;
  final int count;
  final Color? color;
  final double? increaseNumber;
  const CountingItemWidget({super.key, required this.title, required this.count, this.color, this.increaseNumber});

  @override
  Widget build(BuildContext context) {
    return  CustomContainer(color: color,
      horizontalPadding: 20,verticalPadding: 20,borderRadius: 10,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, spacing: Dimensions.paddingSizeExtraSmall, children: [
        const CustomImage(image : Images.group, width: 25, localAsset: true),
        Row(spacing: Dimensions.paddingSizeExtraSmall, children: [
            Text("${count.toString()}+", style: textSemiBold.copyWith(fontSize: Dimensions.fontSizeOverLarge, color: Colors.white)),
            CustomContainer(color: Theme.of(context).cardColor.withValues(alpha: .25),
            showShadow: false, verticalPadding: 3, horizontalPadding: 7, borderRadius: 2,
            child: Row(spacing: Dimensions.paddingSizeExtraSmall, children: [
              Text("28.4%", style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Colors.white)),
           const CustomImage(image:Images.arrowUp, width: 10, localAsset: true)
            ]))]),

        Text(title.tr, style: textRegular.copyWith(fontSize: Dimensions.fontSizeDefault, color: Colors.white)),
    ]),);
  }
}

