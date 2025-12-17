import 'package:flutter/material.dart';
import 'package:mighty_school/common/widget/custom_contaner.dart';
import 'package:mighty_school/common/widget/custom_divider.dart';
import 'package:mighty_school/feature/fees_management/paid_info/domain/model/paid_report_model.dart';
import 'package:mighty_school/helper/responsive_helper.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';

class PaidReportItemWidget extends StatelessWidget {
  final PaidReportInfo? paidReportInfo;
  final int index;
  const PaidReportItemWidget({super.key, this.paidReportInfo, required this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.fromLTRB(Dimensions.paddingSizeDefault, Dimensions.paddingSizeDefault, Dimensions.paddingSizeDefault, 0),
      child: ResponsiveHelper.isDesktop(context)?
      Column(children: [
          Row(spacing: Dimensions.paddingSizeSmall, children: [
            Expanded(child: Text('${paidReportInfo?.student?.rollNo}', style: textRegular.copyWith())),
            Expanded(child: Text('${paidReportInfo?.student?.firstName} ${paidReportInfo?.student?.lastName}', style: textRegular.copyWith())),
            Expanded(child: Text('${paidReportInfo?.invoiceId}', style: textRegular.copyWith())),
            // Expanded(
            //   child: SizedBox(height: 40,
            //     child: ListView.builder(shrinkWrap: true, scrollDirection: Axis.horizontal,
            //       physics: const NeverScrollableScrollPhysics(), padding: EdgeInsets.zero,
            //       itemCount: paidReportInfo?.details?.length?? 0,
            //       itemBuilder: (context, index){
            //         return Text("${paidReportInfo?.details![index].feeHead?.name??''}, ");
            //       }),
            //   ),
            // ),

            Expanded(child: Text('${paidReportInfo?.totalPayable}', style: textRegular.copyWith())),
            Expanded(child: Text('${paidReportInfo?.totalPaid}', style: textRegular.copyWith())),

          ],),
        const CustomDivider(),
        ],
      ):
      CustomContainer(borderRadius: Dimensions.paddingSizeExtraSmall,

        child: Column(spacing: Dimensions.paddingSizeSmall, children: [
          Expanded(child: Text('${paidReportInfo?.student?.rollNo}', style: textRegular.copyWith())),
          Expanded(child: Text('${paidReportInfo?.student?.firstName} ${paidReportInfo?.student?.lastName}', style: textRegular.copyWith())),
          Expanded(child: Text('${paidReportInfo?.invoiceId}', style: textRegular.copyWith())),
          Expanded(
            child: SizedBox(height: 40,
              child: ListView.builder(shrinkWrap: true, scrollDirection: Axis.horizontal,
                  physics: const NeverScrollableScrollPhysics(), padding: EdgeInsets.zero,
                  itemCount: paidReportInfo?.details?.length?? 0,
                  itemBuilder: (context, index){
                    return Text("${paidReportInfo?.details![index].feeHead?.name??''}, ");
                  }),
            ),
          ),

          Expanded(child: Text('${paidReportInfo?.totalPayable}', style: textRegular.copyWith())),
          Expanded(child: Text('${paidReportInfo?.totalPaid}', style: textRegular.copyWith())),

        ],),
      ),
    );
  }
}
