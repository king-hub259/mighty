import 'package:flutter/material.dart';
import 'package:mighty_school/common/widget/custom_contaner.dart';
import 'package:mighty_school/common/widget/custom_divider.dart';
import 'package:mighty_school/feature/fees_management/paid_info/domain/model/un_paid_report_model.dart';
import 'package:mighty_school/helper/responsive_helper.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';

class UnPaidReportItemWidget extends StatelessWidget {
  final StudentData? unPaidReportItem;
  final int index;
  const UnPaidReportItemWidget({super.key, this.unPaidReportItem, required this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.fromLTRB(Dimensions.paddingSizeDefault, Dimensions.paddingSizeDefault, Dimensions.paddingSizeDefault, 0),
      child: ResponsiveHelper.isDesktop(context)?
      Column(children: [
          Row(spacing: Dimensions.paddingSizeSmall, children: [
            Expanded(child: Text('${unPaidReportItem?.roll}', style: textRegular.copyWith())),
            Expanded(child: Text('${unPaidReportItem?.name}', style: textRegular.copyWith())),


            Expanded(child: Text('${unPaidReportItem?.totalPaidAmount}', style: textRegular.copyWith())),

          ],),
        const CustomDivider(),
        ],
      ):
      CustomContainer(borderRadius: Dimensions.paddingSizeExtraSmall,

        child: Row(spacing: Dimensions.paddingSizeSmall, children: [
          Expanded(child: Text('${unPaidReportItem?.roll}', style: textRegular.copyWith())),
          Expanded(child: Text('${unPaidReportItem?.name}', style: textRegular.copyWith())),


          Expanded(child: Text('${unPaidReportItem?.totalPaidAmount}', style: textRegular.copyWith())),

        ],),
      ),
    );
  }
}
