import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_contaner.dart';
import 'package:mighty_school/common/widget/custom_divider.dart';
import 'package:mighty_school/common/widget/numbering_widget.dart';
import 'package:mighty_school/feature/payroll_management/payroll_mapping/domain/models/payroll_mapping_model.dart';
import 'package:mighty_school/helper/responsive_helper.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';

class PayrollMappingItemWidget extends StatelessWidget {
  final int index;
  final PayrollMappingItem? payrollMappingItem;

  const PayrollMappingItemWidget({super.key, required this.index, this.payrollMappingItem});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.fromLTRB(Dimensions.paddingSizeDefault, Dimensions.paddingSizeDefault, Dimensions.paddingSizeDefault, 0),
      child: ResponsiveHelper.isDesktop(context) ?
      Column(children: [
        Row(spacing: Dimensions.paddingSizeDefault, crossAxisAlignment: CrossAxisAlignment.start, children: [
          NumberingWidget(index: index),
          Expanded(child: Text(payrollMappingItem?.ledger?.ledgerName ?? '', style: textRegular.copyWith(fontSize: Dimensions.fontSizeDefault))),
          Text(payrollMappingItem?.fund?.name ?? '', style: textRegular.copyWith(fontSize: Dimensions.fontSizeDefault)),
        ]),
        const CustomDivider(verticalPadding: Dimensions.paddingSizeExtraSmall)
      ]) :
      CustomContainer(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("${"ledger".tr} : ${payrollMappingItem?.ledger?.ledgerName ?? ''}", style: textMedium.copyWith()),
          Text("${"fund".tr} : ${payrollMappingItem?.fund?.name ?? ''}", style: textRegular.copyWith()),
        ]),
      ),
    );
  }
}
