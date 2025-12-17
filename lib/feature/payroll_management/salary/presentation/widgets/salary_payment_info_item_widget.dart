import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/export.dart';
import 'package:mighty_school/common/widget/numbering_widget.dart';
import 'package:mighty_school/feature/payroll_management/salary/domain/model/salary_payment_info_model.dart';
import 'package:mighty_school/helper/price_converter.dart';
import 'package:mighty_school/helper/responsive_helper.dart';
import 'package:mighty_school/util/dimensions.dart';

class SalaryPaymentInfoItemWidget extends StatelessWidget {
  final SalaryPaymentInfoItem salaryItem;
  final int index;
  const SalaryPaymentInfoItemWidget({super.key, required this.salaryItem, required this.index});

  @override
  Widget build(BuildContext context) {
    return ResponsiveHelper.isDesktop(context)?
    Row(spacing: Dimensions.paddingSizeDefault, children: [
      NumberingWidget(index: index),
      Expanded(child: Text(salaryItem.hrId?.toString() ?? "-", overflow: TextOverflow.ellipsis,)),
      Expanded(child: Text(salaryItem.hrName ?? "-", overflow: TextOverflow.ellipsis,)),
      Expanded(child: Text(PriceConverter.convertPrice(context, salaryItem.payableSalary??0), overflow: TextOverflow.ellipsis,)),
      Expanded(child: Text(PriceConverter.convertPrice(context, salaryItem.paid??0), overflow: TextOverflow.ellipsis,)),
      Expanded(child: Text(PriceConverter.convertPrice(context, salaryItem.due??0), overflow: TextOverflow.ellipsis,)),
      Expanded(child: Text(PriceConverter.convertPrice(context, salaryItem.advance??0), overflow: TextOverflow.ellipsis,)),
      Expanded(child: Text(PriceConverter.convertPrice(context, salaryItem.netSalary??0), overflow: TextOverflow.ellipsis,)),

    ],):
    Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [
        NumberingWidget(index: index),
        const SizedBox(width: Dimensions.paddingSizeDefault,),
        Text(salaryItem.hrName ?? "-", style: Theme.of(context).textTheme.titleMedium,),
      ],),
      const SizedBox(height: Dimensions.paddingSizeSmall,),
      Row(children: [
        Expanded(child: Text("${"hr_id".tr}: ${salaryItem.hrId?.toString() ?? "-"}", overflow: TextOverflow.ellipsis,)),
        Expanded(child: Text("${"net_salary".tr}: ${PriceConverter.convertPrice(context, salaryItem.netSalary??0)}", overflow: TextOverflow.ellipsis,)),
      ],),
      const SizedBox(height: Dimensions.paddingSizeSmall,),
      Row(children: [
        Expanded(child: Text("${"paid".tr}: ${PriceConverter.convertPrice(context, salaryItem.paid??0)}", overflow: TextOverflow.ellipsis,)),
        Expanded(child: Text("${"due".tr}: ${PriceConverter.convertPrice(context, salaryItem.due??0)}", overflow: TextOverflow.ellipsis,)),
      ],),
      const SizedBox(height: Dimensions.paddingSizeSmall,),
      Row(children: [
        Expanded(child: Text("${"advance".tr}: ${PriceConverter.convertPrice(context, salaryItem.advance??0)}", overflow: TextOverflow.ellipsis,)),
        Expanded(child: Text("${"payable_salary".tr}: ${PriceConverter.convertPrice(context, salaryItem.payableSalary??0)}", overflow: TextOverflow.ellipsis,)),
      ],),
      const Divider(),
    ],)
    ;
  }
}
