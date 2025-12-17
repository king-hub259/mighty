import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_contaner.dart';
import 'package:mighty_school/common/widget/custom_divider.dart';
import 'package:mighty_school/feature/parent_module/parent_paid_info/domain/model/parent_paid_report_model.dart';
import 'package:mighty_school/helper/responsive_helper.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';


class ParentPaidReportItemWidget extends StatelessWidget {
  final CollectionHistory? paidReportInfo;
  final int index;
  const ParentPaidReportItemWidget({super.key, this.paidReportInfo, required this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeDefault),
      child: ResponsiveHelper.isDesktop(context)?
      Column(children: [
          Row(spacing: Dimensions.paddingSizeSmall, children: [
            Expanded(child: Text('${paidReportInfo?.invoiceId}', style: textRegular.copyWith())),
            Expanded(child: Text('${paidReportInfo?.invoiceDate}', style: textRegular.copyWith())),
            Expanded(child: Text('${paidReportInfo?.feeHeadName}', style: textRegular.copyWith())),
            Expanded(child: Text('${paidReportInfo?.previousDuePaid}', style: textRegular.copyWith())),
            Expanded(child: Text('${paidReportInfo?.fineAmount}', style: textRegular.copyWith())),
            Expanded(child: Text('${paidReportInfo?.waiver}', style: textRegular.copyWith())),
            Expanded(child: Text('${paidReportInfo?.paidAmount}', style: textRegular.copyWith())),

          ],),
        const CustomDivider(),
        ],
      ):
      CustomContainer(borderRadius: Dimensions.paddingSizeExtraSmall, showShadow: false, borderColor: Theme.of(context).hintColor.withAlpha(50),

        child: Column(spacing: Dimensions.paddingSizeSmall,crossAxisAlignment: CrossAxisAlignment.start, children: [
          ItemInfoWithStyleWidget(title: "title".tr, value: paidReportInfo?.feeHeadName),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ItemInfoWithStyleWidget(title: "id".tr, value: paidReportInfo?.invoiceId),
              ItemInfoWithStyleWidget(title: "invoice_date".tr, value: paidReportInfo?.invoiceDate),

            ],
          ),



          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ItemInfoWithStyleWidget(title: "fine".tr, value: paidReportInfo?.fineAmount),
              ItemInfoWithStyleWidget(title: "waiver".tr, value: paidReportInfo?.waiver),
            ],
          ),

          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ItemInfoWithStyleWidget(title: "previous_due".tr, value: paidReportInfo?.previousDuePaid),
              ItemInfoWithStyleWidget(title: "amount".tr, value: paidReportInfo?.paidAmount),
            ],
          ),

        ],),
      ),
    );
  }
}

class ItemInfoWithStyleWidget extends StatelessWidget {
  final String title;
  final String? value;
  final Color? titleColor;
  final Color? valueColor;
  final double? fontSize;
  const ItemInfoWithStyleWidget({super.key, required this.title, this.value, this.titleColor, this.valueColor, this.fontSize});

  @override
  Widget build(BuildContext context) {
    return Text.rich(TextSpan(children: [
        TextSpan(text: "$title : ", style: textMedium.copyWith(fontSize: fontSize?? Dimensions.fontSizeSmall,
            color: titleColor?? Theme.of(context).textTheme.bodyMedium?.color?.withAlpha(100))),
        TextSpan(text: value, style: textRegular.copyWith(fontSize: fontSize??Dimensions.fontSizeDefault, color: valueColor)),
    ]));
  }
}
