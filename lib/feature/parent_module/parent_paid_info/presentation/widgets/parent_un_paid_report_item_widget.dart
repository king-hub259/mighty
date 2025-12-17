import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_contaner.dart';
import 'package:mighty_school/common/widget/custom_divider.dart';
import 'package:mighty_school/feature/parent_module/parent_paid_info/domain/model/parent_un_paid_report_model.dart';
import 'package:mighty_school/feature/parent_module/parent_paid_info/presentation/widgets/due_list_widget.dart';
import 'package:mighty_school/helper/responsive_helper.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';


class ParentUnPaidReportItemWidget extends StatelessWidget {
  final ParentFeeHeads? unPaidReportItem;
  final int index;
  const ParentUnPaidReportItemWidget({super.key, this.unPaidReportItem, required this.index});

  @override
  Widget build(BuildContext context) {
    return ResponsiveHelper.isDesktop(context)?
    Column(children: [
        Row(spacing: Dimensions.paddingSizeSmall, children: [
          Expanded(child: Text('${unPaidReportItem?.feeHeadId}', style: textRegular.copyWith())),
          Expanded(child: Text('${unPaidReportItem?.feeHeadName}', style: textRegular.copyWith())),
          Expanded(child: InkWell(onTap: ()=> Get.dialog(DueListWidget(subHeads: unPaidReportItem?.subHeads)),
              child: Text('view_details'.tr, style: textRegular.copyWith())))]),
      const CustomDivider()]):

    ExpansionTile(showTrailingIcon: false, initiallyExpanded: false,
      backgroundColor: Colors.transparent,
      tilePadding: EdgeInsets.zero,
      title: CustomContainer(borderRadius: Dimensions.paddingSizeExtraSmall,
        showShadow: false,borderColor: Theme.of(context).hintColor.withAlpha(50),
        child: Row(children: [

          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, spacing: Dimensions.paddingSizeSmall, children: [
            Text('${"title".tr} : ${unPaidReportItem?.feeHeadName}', style: textRegular.copyWith()),
            Text('${"due_amount".tr} : ${unPaidReportItem?.subHeads?.map((e) => e.feeAndFinePayable ?? 0).fold(0.0, (a, b) => a + b).toStringAsFixed(2)}',
                    style: textRegular.copyWith())])),
            Icon(Icons.arrow_forward_ios, color: Theme.of(context).hintColor, size: 16),
          ])),
      children: [
        Row(spacing: Dimensions.paddingSizeDefault, crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("id".tr, style:textMedium.copyWith(fontSize: Dimensions.fontSizeLarge)),
          Expanded(child: Text('title'.tr, style:  textMedium.copyWith(fontSize: Dimensions.fontSizeLarge))),
          Expanded(child: Text("amount".tr, style: textMedium.copyWith(fontSize: Dimensions.fontSizeLarge))),
        ]),
        const Padding(padding: EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault), child: CustomDivider()),
        DueListWidget(subHeads: unPaidReportItem?.subHeads)
      ],
    );
  }
}
