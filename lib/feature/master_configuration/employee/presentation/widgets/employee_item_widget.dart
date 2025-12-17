import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/active_inactive_widget.dart';
import 'package:mighty_school/common/widget/confirmation_dialog.dart';
import 'package:mighty_school/common/widget/custom_contaner.dart';
import 'package:mighty_school/common/widget/custom_divider.dart';
import 'package:mighty_school/common/widget/edit_delete_section.dart';
import 'package:mighty_school/feature/master_configuration/employee/controller/employee_controller.dart';
import 'package:mighty_school/feature/master_configuration/employee/domain/models/employee_model.dart';
import 'package:mighty_school/feature/master_configuration/employee/presentation/screens/create_new_employee_screen.dart';
import 'package:mighty_school/feature/master_configuration/employee/presentation/widgets/create_new_employee_widget.dart';
import 'package:mighty_school/helper/responsive_helper.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';

class EmployeeItemWidget extends StatelessWidget {
  final EmployeeItem? employeeItem;
  final int index;
  const EmployeeItemWidget({super.key, this.employeeItem, required this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault, vertical: 5),
      child: ResponsiveHelper.isDesktop(context)?
      Column(children: [
          Row(spacing: Dimensions.paddingSizeSmall, children: [

              Text("${index+1}. ",maxLines: 1, style: textRegular.copyWith(fontSize: Dimensions.fontSizeDefault),),
              Expanded(child: Text("${employeeItem?.name}",maxLines: 1, style: textRegular.copyWith(fontSize: Dimensions.fontSizeDefault),)),
              Expanded(child: Text(employeeItem?.email??'', maxLines: 1, style: textRegular.copyWith(),)),
              Expanded(child: Text(employeeItem?.phone??'', style: textRegular.copyWith(),)),
              Expanded(child: Text(employeeItem?.department??'', style: textRegular.copyWith(),)),


              EditDeleteSection(horizontal: true, onEdit: (){
                Get.bottomSheet(isScrollControlled: true, Container(width: Get.width,
                    padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                    decoration: BoxDecoration(borderRadius: const BorderRadius.vertical(top: Radius.circular(Dimensions.radiusLarge)),
                        color: Theme.of(context).cardColor),
                    child: CreateNewEmployeeWidget(employeeItem: employeeItem)));

              },
                onDelete: (){
                Get.dialog(ConfirmationDialog(
                  title: "employee".tr,
                    content: "employee".tr,
                    onTap: (){
                    Get.back();
                  Get.find<EmployeeController>().deleteEmployee(employeeItem!.id!);
                }));

                },)
            ],
          ),
        const CustomDivider()
        ],
      ):
      CustomContainer(child: Row(crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text("${employeeItem?.name}", style: textMedium.copyWith(fontSize: Dimensions.fontSizeDefault),),
              Text("${"role".tr} : ${employeeItem?.role??''}", style: textRegular.copyWith(),),
              Text("${"phone".tr} : ${employeeItem?.phone??''}", style: textRegular.copyWith(),),
              Text("${"department".tr} : ${employeeItem?.department??''}", style: textRegular.copyWith(),),
              ActiveInActiveWidget(active: employeeItem?.status == 1)
            ]),
          ),
          EditDeleteSection(onEdit: (){
            Get.to(()=> CreateNewEmployeeScreen(employeeItem: employeeItem));
          },
            onDelete: (){
              Get.dialog(ConfirmationDialog(
                  title: "employee".tr,
                  content: "employee".tr,
                  onTap: (){
                    Get.back();
                    Get.find<EmployeeController>().deleteEmployee(employeeItem!.id!);
                  }));
          },)
        ],
      )),
    );
  }
}