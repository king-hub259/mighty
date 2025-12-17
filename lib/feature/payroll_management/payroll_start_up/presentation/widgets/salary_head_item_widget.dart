import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/confirmation_dialog.dart';
import 'package:mighty_school/common/widget/custom_contaner.dart';
import 'package:mighty_school/common/widget/edit_delete_section.dart';
import 'package:mighty_school/common/widget/numbering_widget.dart';
import 'package:mighty_school/feature/payroll_management/payroll_start_up/domain/models/salary_head_model.dart';
import 'package:mighty_school/feature/payroll_management/payroll_start_up/logic/payroll_start_up_controller.dart';
import 'package:mighty_school/feature/payroll_management/payroll_start_up/presentation/widgets/add_new_salary_head_widget.dart';
import 'package:mighty_school/helper/responsive_helper.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';

class SalaryHeadItemWidget extends StatelessWidget {
  final int index;
  final SalaryHeadItem? salaryHeadItem;

  const SalaryHeadItemWidget({
    super.key,
    required this.index,
    this.salaryHeadItem,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(Dimensions.paddingSizeDefault, Dimensions.paddingSizeDefault, Dimensions.paddingSizeDefault, 0),
      child: ResponsiveHelper.isDesktop(context) ?
      Row(spacing: Dimensions.paddingSizeDefault, crossAxisAlignment: CrossAxisAlignment.start, children: [
        NumberingWidget(index: index),
        Expanded(child: Text('${salaryHeadItem?.name}', style: textRegular.copyWith(fontSize: Dimensions.fontSizeDefault))),
        Expanded(child: Text(salaryHeadItem?.description ?? '', style: textRegular.copyWith(fontSize: Dimensions.fontSizeDefault))),
        Expanded(child: Text(salaryHeadItem?.type ?? '', style: textRegular.copyWith(fontSize: Dimensions.fontSizeDefault))),
        Expanded(child: Text(salaryHeadItem?.status ?? '', style: textRegular.copyWith(fontSize: Dimensions.fontSizeDefault))),
        EditDeleteSection(horizontal: true, onDelete: (){
          Get.dialog(ConfirmationDialog(
            title: "salary_head",
            content: "salary_head",
            onTap: (){
              Get.back();
              Get.find<PayrollStartUpController>().deleteSalaryHead(salaryHeadItem!.id!);
            },));
        }, onEdit: (){
          Get.dialog(AddNewSalaryHeadWidget(salaryHeadItem: salaryHeadItem));
        },)
      ]) :
      CustomContainer(
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text("${"name".tr} : ${salaryHeadItem?.name}", style: textMedium.copyWith(fontSize: Dimensions.fontSizeDefault)),
            const SizedBox(height: Dimensions.paddingSizeExtraSmall),
            Text("${"description".tr} : ${salaryHeadItem?.description ?? ''}", style: textRegular.copyWith(fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).hintColor)),
            const SizedBox(height: Dimensions.paddingSizeExtraSmall),
            Text("${"type".tr} : ${salaryHeadItem?.type ?? ''}", style: textRegular.copyWith(fontSize: Dimensions.fontSizeDefault)),
            const SizedBox(height: Dimensions.paddingSizeExtraSmall),
            Text("${"status".tr} : ${salaryHeadItem?.status ?? ''}", style: textRegular.copyWith(fontSize: Dimensions.fontSizeDefault)),
          ])),
          EditDeleteSection(horizontal: true, onEdit: (){
            Get.dialog(AddNewSalaryHeadWidget(salaryHeadItem: salaryHeadItem));
          }, onDelete: (){
            Get.dialog(ConfirmationDialog(
              title: "salary_head",
              content: "salary_head",
              onTap: (){
                Get.back();
                Get.find<PayrollStartUpController>().deleteSalaryHead(salaryHeadItem!.id!);
              },));
          },)
        ]),
      ),
    );
  }
}