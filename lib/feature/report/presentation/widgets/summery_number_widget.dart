import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_contaner.dart';
import 'package:mighty_school/common/widget/custom_image.dart';
import 'package:mighty_school/feature/report/domain/model/dashboard_report_model.dart';
import 'package:mighty_school/feature/report/logic/dashboard_report_controller.dart';
import 'package:mighty_school/helper/responsive_helper.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/images.dart';
import 'package:mighty_school/util/styles.dart';

class SummeryNumberWidget extends StatelessWidget {
  const SummeryNumberWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardReportController>(
      builder: (reportController) {
        DashboardReportModel? reportModel = reportController.dashboardReportModel;
        return ResponsiveHelper.isDesktop(context)?
        Row(spacing: Dimensions.paddingSizeDefault, children: [
            Expanded(child: CountingItemWidget(title: 'total_admin', color: Theme.of(context).primaryColor, count: reportModel?.data?.admins ?? 0)),
            Expanded(child: CountingItemWidget(title: 'total_students', color: Theme.of(context).colorScheme.tertiaryContainer, count: reportModel?.data?.students ?? 0,),),
            Expanded(child: CountingItemWidget(title: 'total_teacher', color: Theme.of(context).colorScheme.secondary, count: reportModel?.data?.teachers ?? 0,),),
            Expanded(child: CountingItemWidget(title: 'total_staff', color: Theme.of(context).colorScheme.surfaceContainer, count: reportModel?.data?.staffs ?? 0,)),

          ],
        ):Column(spacing: Dimensions.paddingSizeDefault, children: [
          Row(spacing: Dimensions.paddingSizeDefault, children: [
            Expanded(child: CountingItemWidget(title: 'total_admin', color: Theme.of(context).primaryColor, count: reportModel?.data?.admins ?? 0)),
            Expanded(child: CountingItemWidget(title: 'total_students', color: Theme.of(context).colorScheme.tertiaryContainer, count: reportModel?.data?.students ?? 0,),),

          ]),
          Row(spacing: Dimensions.paddingSizeDefault, children: [
            Expanded(child: CountingItemWidget(title: 'total_teacher', color: Theme.of(context).colorScheme.secondary, count: reportModel?.data?.teachers ?? 0,),),
            Expanded(child: CountingItemWidget(title: 'total_staff', color: Theme.of(context).colorScheme.surfaceContainer, count: reportModel?.data?.staffs ?? 0,)),
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

