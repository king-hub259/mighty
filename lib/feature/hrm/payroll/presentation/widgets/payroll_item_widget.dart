import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_contaner.dart';
import 'package:mighty_school/common/widget/edit_delete_section.dart';
import 'package:mighty_school/feature/hrm/payroll/controller/payroll_controller.dart';
import 'package:mighty_school/feature/hrm/payroll/domain/models/payroll_model.dart';
import 'package:mighty_school/feature/hrm/payroll/presentation/screens/create_new_payroll_screen.dart';
import 'package:mighty_school/helper/price_converter.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';

class PayrollItemWidget extends StatelessWidget {
  final PayrollItem? payrollItem;
  final int index;
  const PayrollItemWidget({super.key, this.payrollItem, required this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault, vertical: 5),
      child: CustomContainer(child: Row(crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text("${"ref".tr} : ${payrollItem?.reference}", style: textMedium.copyWith(fontSize: Dimensions.fontSizeDefault),),
              Text("${"payment_type".tr} : ${payrollItem?.method??''}", style: textRegular.copyWith(),),
              Text("${"amount".tr} : ${PriceConverter.convertPrice(context, double.parse(payrollItem?.amount??'0'))}", style: textRegular.copyWith(),),
            ]),
          ),
          EditDeleteSection(onEdit: (){
            Get.to(()=> CreateNewPayrollScreen(payrollItem: payrollItem));
          },
            onDelete: (){
            Get.find<PayrollController>().deletePayroll(payrollItem!.id!);
          },)
        ],
      )),
    );
  }
}