import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_dropdown.dart';
import 'package:mighty_school/common/widget/custom_title.dart';
import 'package:mighty_school/feature/payroll_management/payroll_start_up/logic/payroll_start_up_controller.dart';

class SelectSalaryHeadTypeWidget extends StatelessWidget {
  const SelectSalaryHeadTypeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PayrollStartUpController>(
        builder: (startupController) {
          return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const CustomTitle(title: "salary_head_type", ),
            Padding(padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: CustomDropdown(width: Get.width, title: "select".tr,
                items: startupController.headTypes,
                selectedValue: startupController.selectedHeadType,
                onChanged: (val){
                  startupController.setSelectedHeadType(val!);
                },
              ),),
          ],);
        }
    );
  }
}
