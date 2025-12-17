import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_contaner.dart';
import 'package:mighty_school/common/widget/custom_image.dart';
import 'package:mighty_school/feature/parent_module/parent_paid_info/controller/parent_paid_info_controller.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/images.dart';
import 'package:mighty_school/util/styles.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';


class ParentFeesOverviewWidget extends StatefulWidget {
  const ParentFeesOverviewWidget({super.key});

  @override
  State<ParentFeesOverviewWidget> createState() => _StudentRatioChartWidgetState();
}

class _StudentRatioChartWidgetState extends State<ParentFeesOverviewWidget> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ParentPaidInfoController>(
      builder: (paidInfoController) {

        double totalPaid = paidInfoController.paidReportModel?.data?.totalPaidAmount??0;
        double totalUnPaid = paidInfoController.unPaidReportModel?.data?.studentData?.totalDueAmount??0;
        double total = totalPaid + totalUnPaid;
        double paidPercentage = total == 0 ? 0 : (totalPaid / total);
        double unpaidPercentage = total == 0 ? 0 : (totalUnPaid / total);
        return CustomContainer(showShadow: false,borderColor: Theme.of(context).hintColor.withValues(alpha: 0.25),
          height: 260 ,
          child: Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraLarge),
            child: Column(spacing: Dimensions.paddingSizeDefault,mainAxisSize: MainAxisSize.min,mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text("fees_overview".tr,  style: textBold.copyWith(fontSize: Dimensions.fontSizeExtraLarge)),

                SizedBox(height: 160,child: Row(spacing: Dimensions.paddingSizeDefault,
                    children: [Center(child: Stack(alignment: Alignment.center, children: [
                          CircularPercentIndicator(
                            radius: 70.0,
                            lineWidth: 13.0,
                            animation: true,
                            percent: paidPercentage,
                            startAngle: 180,
                            circularStrokeCap: CircularStrokeCap.round,
                            progressColor: Theme.of(context).colorScheme.primary,
                          ),

                          CircularPercentIndicator(
                            radius: 50.0,
                            lineWidth: 13.0,
                            animation: true,
                            percent: unpaidPercentage,
                            circularStrokeCap: CircularStrokeCap.round,
                            progressColor: Theme.of(context).colorScheme.error,
                          ),
                      const CustomImage(svg: Images.feesIcon,  width: 30)])),

                     VerticalDivider(color: Theme.of(context).hintColor.withValues(alpha: 0.25),thickness: 2,),
                      Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildLegend("${"paid".tr} (${paidPercentage.toStringAsFixed(2)}%)", "$totalPaid", Theme.of(context).colorScheme.primary),
                          _buildLegend("${"due".tr} (${unpaidPercentage.toStringAsFixed(2)}%)", "$totalUnPaid", Theme.of(context).colorScheme.error),],),

                    ],
                  ),
                ),

              ],
            ),
          ),
        );
      }
    );
  }

  Widget _buildLegend(String label, String value, Color color) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomContainer(color: color, showShadow: false,),
        const SizedBox(height: Dimensions.paddingSizeExtraSmall),
        Text(value, style: textMedium),
        Text(label, style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Colors.grey)),],);
  }
}