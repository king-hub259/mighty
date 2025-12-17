
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_contaner.dart';
import 'package:mighty_school/feature/report/logic/dashboard_report_controller.dart';
import 'package:mighty_school/helper/price_converter.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';

class TodayReportWidget extends StatelessWidget {
  const TodayReportWidget({super.key});

  @override
  Widget build(BuildContext context) {
    double width = .5, height = 40;
    return GetBuilder<DashboardReportController>(
      builder: (dashboardReportController) {
        var data = dashboardReportController.dashboardReportModel?.data;
        return Padding(padding: const EdgeInsets.fromLTRB(Dimensions.paddingSizeSmall, Dimensions.paddingSizeSmall, Dimensions.paddingSizeSmall, Dimensions.paddingSizeDefault),
          child: CustomContainer(color: Theme.of(context).secondaryHeaderColor, borderRadius: 5,
            verticalPadding: Dimensions.paddingSizeSmall,horizontalPadding: 5,
            showShadow: false,
            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(spacing: Dimensions.paddingSizeExtraSmall, crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Expanded(child: TodayReportItemCard(title: "today_student_present".tr, amount: double.parse(data?.studentTodayPresent?.present?.toString()??"0"), isNumber: true,)),
                  IntrinsicHeight(child: Container(width: width, height: height, color: Colors.white,)),
                  Expanded(child: TodayReportItemCard(title: "today_teacher_present".tr, amount: double.parse(data?.studentPresentToday?.presentCount?.toString()??"0"), isNumber: true,)),
                  IntrinsicHeight(child: Container(width: width, height: height, color: Colors.white,)),
                  Expanded(child: TodayReportItemCard(title: "today_staff_present".tr, amount: double.parse(data?.staffPresentToday?.presentCount?.toString()??"0"), isNumber: true,)),
                ],),
                Padding(padding: const EdgeInsets.symmetric(vertical: 5), child: Container(color: Colors.white, width: Get.width, height: width)),
                Row(spacing: Dimensions.paddingSizeExtraSmall, crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Expanded(child: TodayReportItemCard(title: "total_student".tr, amount: double.parse(data?.students?.toString()??"0"), isNumber: true,)),
                  IntrinsicHeight(child: Container(width: width, height: height, color: Colors.white,)),
                  Expanded(child: TodayReportItemCard(title: "total_teacher".tr, amount: double.parse(data?.teachers?.toString()??"0"), isNumber: true,)),
                  IntrinsicHeight(child: Container(width: width, height: height, color: Colors.white,)),
                  Expanded(child: TodayReportItemCard(title: "total_staff".tr, amount: double.parse(data?.staffs?.toString()??"0"), isNumber: true,)),
                ],),
                Padding(padding: const EdgeInsets.symmetric(vertical: 5), child: Container(color: Colors.white, width: Get.width, height: width)),
                Row(spacing: Dimensions.paddingSizeExtraSmall, crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Expanded(child: TodayReportItemCard(title: "today_income".tr, amount: double.parse(data?.todayIncome?.toString()??"0"))),
                  IntrinsicHeight(child: Container(width: width, height: height, color: Colors.white,)),
                  Expanded(child: TodayReportItemCard(title: "today_expense".tr, amount: double.parse(data?.todayExpense?.toString()??"0"))),
                ],),
              ],
            ),),
        );
      }
    );
  }
}

class TodayReportItemCard extends StatelessWidget {
  final String title;
  final double? amount;
  final bool isNumber;
  const TodayReportItemCard({super.key, required this.title, this.amount,  this.isNumber = false});

  @override
  Widget build(BuildContext context) {
    return Column(spacing: Dimensions.paddingSizeExtraSmall, children: [
      Text(title, textAlign: TextAlign.center, style: textRegular.copyWith(color: Colors.white, fontSize: Dimensions.fontSizeExtraSmall),),
      isNumber?
      Text(amount!.toStringAsFixed(0), style: textBold.copyWith(color: Colors.white),):
      Text(PriceConverter.convertPrice(context, amount??0), style: textBold.copyWith(color: Colors.white),),
    ],);
  }
}
