import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/confirmation_dialog.dart';
import 'package:mighty_school/common/widget/custom_contaner.dart';
import 'package:mighty_school/common/widget/edit_delete_section.dart';
import 'package:mighty_school/common/widget/numbering_widget.dart';
import 'package:mighty_school/feature/payroll_management/advance/domain/models/advance_salary_model.dart';
import 'package:mighty_school/feature/payroll_management/advance/logic/advance_controller.dart';
import 'package:mighty_school/feature/payroll_management/advance/presentation/screens/create_advance_salary_screen.dart';
import 'package:mighty_school/helper/price_converter.dart';
import 'package:mighty_school/helper/responsive_helper.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';

class AdvanceSalaryItemWidget extends StatelessWidget {
  final int index;
  final AdvanceSalaryItem advanceSalaryItem;

  const AdvanceSalaryItemWidget({
    super.key,
    required this.index,
    required this.advanceSalaryItem,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(Dimensions.paddingSizeDefault, Dimensions.paddingSizeDefault, Dimensions.paddingSizeDefault, 0),
      child: ResponsiveHelper.isDesktop(context) ?
      Row(spacing: Dimensions.paddingSizeDefault, crossAxisAlignment: CrossAxisAlignment.start, children: [

        NumberingWidget(index: index),
        Expanded(child: Text("${advanceSalaryItem.employee?.firstName ?? ''} ${advanceSalaryItem.employee?.lastName ?? ''}", style: textRegular.copyWith())),
        Expanded(child: Text(advanceSalaryItem.requestDate ?? '', style: textRegular.copyWith())),
        Expanded(child: Text(advanceSalaryItem.approvedDate ?? '', style: textRegular.copyWith())),
        Expanded(child: Text(PriceConverter.convertPrice(context, advanceSalaryItem.amount ?? 0), style: textRegular.copyWith())),
        Expanded(child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: Dimensions.paddingSizeSmall,
            vertical: Dimensions.paddingSizeExtraSmall,
          ),
          decoration: BoxDecoration(
            color: _getStatusColor(advanceSalaryItem.status).withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
          ),
          child: Text(
            advanceSalaryItem.status?.toUpperCase() ?? '',
            style: textMedium.copyWith(
              fontSize: Dimensions.fontSizeSmall,
              color: _getStatusColor(advanceSalaryItem.status),
            ),
          ),
        )),
        EditDeleteSection(horizontal: true, onDelete: (){
          Get.dialog(ConfirmationDialog(title: "advance_salary", content: "advance_salary",
            onTap: (){
              Get.back();
              Get.find<AdvanceController>().deleteAdvanceSalary(advanceSalaryItem.id!);
            },));
        }, onEdit: (){
          Get.find<AdvanceController>().fillForm(advanceSalaryItem);
          Get.to(() => CreateAdvanceSalaryScreen(advanceSalaryItem: advanceSalaryItem));
        },)
      ]) :
      CustomContainer(
        child: Row(spacing: Dimensions.paddingSizeExtraSmall, crossAxisAlignment: CrossAxisAlignment.start, children: [
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text("${"employee".tr} : ${advanceSalaryItem.employee?.firstName ?? ''} ${advanceSalaryItem.employee?.lastName ?? ''}", style: textMedium.copyWith(fontSize: Dimensions.fontSizeDefault)),
            Text("${"month".tr} : ${advanceSalaryItem.requestDate ?? ''}", style: textRegular.copyWith(fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).hintColor)),
            Text("${"year".tr} : ${advanceSalaryItem.approvedDate ?? ''}", style: textRegular.copyWith(fontSize: Dimensions.fontSizeDefault)),
            Text("${"amount".tr} : ${PriceConverter.convertPrice(context, advanceSalaryItem.amount ?? 0)}", style: textRegular.copyWith(fontSize: Dimensions.fontSizeDefault)),
            Container(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall,
                vertical: Dimensions.paddingSizeExtraSmall),
              decoration: BoxDecoration(color: _getStatusColor(advanceSalaryItem.status).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(Dimensions.radiusSmall)),
              child: Text(advanceSalaryItem.status?.toUpperCase() ?? '',
                style: textMedium.copyWith(fontSize: Dimensions.fontSizeSmall,
                  color: _getStatusColor(advanceSalaryItem.status)))),
          ])),
          EditDeleteSection(horizontal: true, onEdit: (){
            Get.find<AdvanceController>().fillForm(advanceSalaryItem);
            Get.to(() => CreateAdvanceSalaryScreen(advanceSalaryItem: advanceSalaryItem));
          }, onDelete: (){
            Get.dialog(ConfirmationDialog(title: "advance_salary", content: "advance_salary",
              onTap: (){
                Get.back();
                Get.find<AdvanceController>().deleteAdvanceSalary(advanceSalaryItem.id!);
              },));
          },)
        ]),
      ),
    );
  }

  Color _getStatusColor(String? status) {
    switch (status?.toLowerCase()) {
      case 'approved':
        return Colors.green;
      case 'pending':
        return Colors.orange;
      case 'rejected':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
