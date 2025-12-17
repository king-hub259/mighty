import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mighty_school/common/widget/custom_contaner.dart';
import 'package:mighty_school/common/widget/custom_text_field.dart';
import 'package:mighty_school/feature/master_configuration/employee/controller/employee_controller.dart';
import 'package:mighty_school/feature/master_configuration/employee/domain/models/employee_model.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';

class EmployeeListSection extends StatelessWidget {
  const EmployeeListSection({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EmployeeController>(
      builder: (employeeController) {
        String timeToAmPm(String time) {
          DateTime dateTime = DateFormat("HH:mm").parse(time);
          String time12Hour = DateFormat("hh:mm a").format(dateTime);
          return time12Hour;
        }
        EmployeeModel? employeeModel = employeeController.employeeModel;
        return (employeeModel != null && employeeModel.data?.data != null && employeeModel.data!.data!.isNotEmpty)?
        ListView.builder(
          itemCount: employeeModel.data?.data?.length??0,
          shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context,index){
          final employee = employeeModel.data?.data?[index];
          return CustomContainer(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(employee?.name??'', style: textRegular.copyWith(),),

            SizedBox(height: 40,
              child: ListView.builder(
                itemCount: employeeController.presentTypeList.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, typeIndex){
                  bool selected = typeIndex == employeeController.selectedPresentTypeIndex;
                return Padding(padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: InkWell(onTap: ()=> employeeController.setPresentType(typeIndex, index),
                    child: Row(children: [
                      Icon(selected? Icons.radio_button_checked_rounded : Icons.radio_button_off,
                        color: selected? Theme.of(context).primaryColor : Theme.of(context).hintColor,),

                      const SizedBox(width: 5),
                      Text(employeeController.presentTypeList[typeIndex].tr, style: textRegular.copyWith(),),],),
                  ),
                );
              }),
            ),
            Row(children: [
              Expanded(child: InkWell(onTap: ()=> employeeController.pickTime(index),
                  child: CustomTextField(title: "check_in".tr,
                      isEnabled : false,
                      suffix: const Icon(Icons.access_time, size: 20),
                      hintText: timeToAmPm(employee?.checkIn??"09:00")))),
              const SizedBox(width: Dimensions.paddingSizeSmall),

              Expanded(child: InkWell(onTap: ()=> employeeController.pickTime(index, checkOut: true),
                  child: CustomTextField(title: "check_out".tr,
                      isEnabled : false,
                      suffix: const Icon(Icons.access_time, size: 20),
                      hintText: timeToAmPm(employee?.checkOut??"17:00"))))],
            ),

          ],));
        }):const SizedBox();
      }
    );
  }
}
