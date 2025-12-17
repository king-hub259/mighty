import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_button.dart';
import 'package:mighty_school/common/widget/custom_dropdown.dart';
import 'package:mighty_school/common/widget/custom_title.dart';
import 'package:mighty_school/feature/hrm/payroll/controller/payroll_controller.dart';
import 'package:mighty_school/util/dimensions.dart';

class SelectYearAndMonthWidget extends StatelessWidget {
  final Function()? onTap;
  const SelectYearAndMonthWidget({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PayrollController>(
      builder: (payrollController) {
        return Padding(
          padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
          child: Row(spacing: Dimensions.paddingSizeDefault, children: [

             Expanded(
               child: Column(children: [
                 const CustomTitle(title: "year"),
                 Padding(padding: const EdgeInsets.symmetric(vertical: 8.0),
                   child: CustomDropdown(width: Get.width, title: "choose_year".tr,
                     items: payrollController.yearList,
                     selectedValue: payrollController.selectedYear,
                     onChanged: (val){
                       payrollController.setSelectedYear(val!);
                     },
                   ),),
               ],),
             ),
              Expanded(child: Column(children: [
                const CustomTitle(title: "month"),
                Padding(padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: CustomDropdown(width: Get.width, title: "choose_month".tr,
                    items: payrollController.monthList,
                    selectedValue: payrollController.selectedMonth,
                    onChanged: (val){
                      payrollController.setSelectedMonth(val!);
                    },
                  ),),
              ])),
            SizedBox(width: 100, child: Column(
              children: [
                const CustomTitle(title: ""),
                CustomButton(onTap: onTap, text: "submit".tr, height: 30, width: 100),
              ],
            ))
          ]),
        );
      }
    );
  }
}
