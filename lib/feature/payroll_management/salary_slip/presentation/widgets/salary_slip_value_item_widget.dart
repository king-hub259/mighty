import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/feature/payroll_management/salary_slip/domain/model/salary_slip_model.dart';
import 'package:mighty_school/feature/payroll_management/salary_slip/logic/salary_slip_controller.dart';
import 'package:mighty_school/feature/payroll_management/salary_slip/presentation/widgets/salary_slip_widget.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';

class SalarySlipValueItemWidget extends StatelessWidget {
  final int index;
  final SalarySlips user;
  final List<SalarySlips> salarySlipData;
  final double width;
  final double height;
  const SalarySlipValueItemWidget({super.key, required this.index, required this.user, required this.salarySlipData, required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SalarySlipController>(
      builder: (salarySlipController) {
        return Column(children: [
            Container(height: 60, decoration: BoxDecoration(color: index % 2 == 0 ? Theme.of(context).cardColor : Theme.of(context).scaffoldBackgroundColor,),
              child: Row( children: [
                Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
                  child: SizedBox(width : 20, height: 20,
                    child: Checkbox(value: user.isSelected, onChanged: (val){
                      salarySlipController.toggleSelection(index);
                    }),
                  ),
                ),
                  SizedBox(width: width, child: Padding(padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text("${index + 1}. ${user.user?.name ?? ''}",
                        maxLines: 2, overflow: TextOverflow.ellipsis, style: textRegular))),
                  const CustomBorder(),
                  SizedBox(width: width,
                    child: Center(child: Text(user.user?.userType ?? "", style: textRegular, textAlign: TextAlign.center)),),
                  const CustomBorder(),

                  /// Non-editable Salary Head Amounts
                  if (user.salaryHeadUserPayrolls != null && user.salaryHeadUserPayrolls!.isNotEmpty)
                    ...user.salaryHeadUserPayrolls!.map((head) => [
                      SizedBox(width: width,
                        child: Container(margin: const EdgeInsets.all(4.0),
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                          decoration: BoxDecoration(border: Border.all(color: Theme.of(context).dividerColor),
                            borderRadius: BorderRadius.circular(4),
                            color: Theme.of(context).cardColor),
                          child: Center(child: Text(head.amount ?? "0.00", style: textRegular.copyWith(fontWeight: FontWeight.w500),
                              textAlign: TextAlign.center)))),
                      const CustomBorder(),
                    ]).expand((x) => x),

                  // Net Salary display
                  SizedBox(width: width, child: Container(margin: const EdgeInsets.all(4.0),
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                      decoration: BoxDecoration(border: Border.all(color: Theme.of(context).primaryColor, width: 2),
                        borderRadius: BorderRadius.circular(4), color: Theme.of(context).primaryColor.withValues(alpha: 0.1)),
                      child: Center(child: Text(user.user?.userPayroll?.netSalary ?? "0.00",
                        style: textBold.copyWith(color: Theme.of(context).primaryColor),
                          textAlign: TextAlign.center)),
                    ),
                  ),
                ],
              ),
            ),

            if (index < salarySlipData.length - 1)
              Container(height: 1, color: Theme.of(context).dividerColor,
                margin: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeExtraSmall)),
          ],
        );
      }
    );
  }
}
