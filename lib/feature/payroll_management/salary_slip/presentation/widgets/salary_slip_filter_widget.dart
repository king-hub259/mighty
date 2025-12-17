import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_button.dart';
import 'package:mighty_school/common/widget/custom_contaner.dart';
import 'package:mighty_school/common/widget/custom_dropdown.dart';
import 'package:mighty_school/common/widget/custom_snackbar.dart';
import 'package:mighty_school/common/widget/custom_title.dart';
import 'package:mighty_school/feature/payroll_management/salary_slip/logic/salary_slip_controller.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';

class SalarySlipFilterWidget extends StatefulWidget {
  const SalarySlipFilterWidget({super.key});

  @override
  State<SalarySlipFilterWidget> createState() => _SalarySlipFilterWidgetState();
}

class _SalarySlipFilterWidgetState extends State<SalarySlipFilterWidget> {


  @override
  Widget build(BuildContext context) {
    return GetBuilder<SalarySlipController>(
      builder: (salarySlipController) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
          child: CustomContainer(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

                Text("create_salary_slip".tr, style: textMedium.copyWith(fontSize: Dimensions.fontSizeLarge)),


                Row(spacing: Dimensions.paddingSizeDefault, children: [

                    Expanded(child: Column(children: [
                      const CustomTitle(title: "year", ),
                      Padding(padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: CustomDropdown(width: Get.width, title: "select".tr,
                          items: salarySlipController.years,
                          selectedValue: salarySlipController.selectedYear,
                          onChanged: (val){
                            salarySlipController.setSelectedYear(val!);
                          },
                        ),),
                    ],)),

                    Expanded(child: Column(children: [
                      const CustomTitle(title: "month", ),
                      Padding(padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: CustomDropdown(width: Get.width, title: "select".tr,
                          items: salarySlipController.months,
                          selectedValue: salarySlipController.selectedMonth,
                          onChanged: (val){
                            salarySlipController.setSelectedMonth(val!);
                          },
                        ),),
                    ],)),

                    SizedBox(width: 150,
                      child: salarySlipController.isLoading?
                          const Center(child: CircularProgressIndicator())
                          : CustomButton(
                        onTap: () {
                          if(salarySlipController.selectedMonthValue == null || salarySlipController.selectedYear == null) {
                           showCustomSnackBar("select_month_and_year".tr);
                            return;
                          }
                          salarySlipController.getSalarySlipByMonth(salarySlipController.selectedMonthValue!, salarySlipController.selectedYear!);
                        },

                        text: 'search'.tr,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }
    );
  }
}
