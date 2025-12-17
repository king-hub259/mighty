import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_contaner.dart';
import 'package:mighty_school/common/widget/numbering_widget.dart';
import 'package:mighty_school/feature/payroll_management/salary/domain/models/salary_model.dart';
import 'package:mighty_school/helper/responsive_helper.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';

class SalaryItemWidget extends StatelessWidget {
  final int index;
  final SalaryItem salaryItem;

  const SalaryItemWidget({
    super.key,
    required this.index,
    required this.salaryItem,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(Dimensions.paddingSizeDefault, Dimensions.paddingSizeDefault, Dimensions.paddingSizeDefault, 0),
      child: ResponsiveHelper.isDesktop(context) ?
      Row(spacing: Dimensions.paddingSizeDefault, crossAxisAlignment: CrossAxisAlignment.start, children: [

        NumberingWidget(index: index),
        Expanded(child: Text("${salaryItem.employee?.firstName ?? ''} ${salaryItem.employee?.lastName ?? ''}", style: textRegular.copyWith())),
        Expanded(child: Text("${salaryItem.month ?? ''} ${salaryItem.year ?? ''}", style: textRegular.copyWith())),
        Expanded(child: Text("\$${salaryItem.basicSalary ?? '0'}", style: textRegular.copyWith())),
        Expanded(child: Text("\$${salaryItem.totalEarning ?? '0'}", style: textRegular.copyWith(color: Colors.green))),
        Expanded(child: Text("\$${salaryItem.totalDeduction ?? '0'}", style: textRegular.copyWith(color: Colors.red))),
        Expanded(child: Text("\$${salaryItem.netSalary ?? '0'}", style: textMedium.copyWith(color: Colors.green))),
      ]) :
      CustomContainer(
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text("${"employee".tr} : ${salaryItem.employee?.firstName ?? ''} ${salaryItem.employee?.lastName ?? ''}", style: textMedium.copyWith(fontSize: Dimensions.fontSizeDefault)),
            const SizedBox(height: Dimensions.paddingSizeExtraSmall),
            Text("${"month_year".tr} : ${salaryItem.month ?? ''} ${salaryItem.year ?? ''}", style: textRegular.copyWith(fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).hintColor)),
            const SizedBox(height: Dimensions.paddingSizeExtraSmall),
            Text("${"basic_salary".tr} : \$${salaryItem.basicSalary ?? '0'}", style: textRegular.copyWith(fontSize: Dimensions.fontSizeDefault)),
            const SizedBox(height: Dimensions.paddingSizeExtraSmall),
            Text("${"total_earning".tr} : \$${salaryItem.totalEarning ?? '0'}", style: textRegular.copyWith(fontSize: Dimensions.fontSizeDefault, color: Colors.green)),
            const SizedBox(height: Dimensions.paddingSizeExtraSmall),
            Text("${"total_deduction".tr} : \$${salaryItem.totalDeduction ?? '0'}", style: textRegular.copyWith(fontSize: Dimensions.fontSizeDefault, color: Colors.red)),
            const SizedBox(height: Dimensions.paddingSizeExtraSmall),
            Text("${"net_salary".tr} : \$${salaryItem.netSalary ?? '0'}", style: textMedium.copyWith(fontSize: Dimensions.fontSizeDefault, color: Colors.green)),
          ])),
        ]),
      ),
    );
  }


}
