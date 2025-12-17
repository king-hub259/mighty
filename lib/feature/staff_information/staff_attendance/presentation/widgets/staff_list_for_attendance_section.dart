import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mighty_school/common/widget/custom_contaner.dart';
import 'package:mighty_school/common/widget/custom_text_field.dart';
import 'package:mighty_school/feature/staff_information/staff_attendance/controller/staff_attendance_controller.dart';
import 'package:mighty_school/feature/staff_information/staff_attendance/domain/models/user_model.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';

class StaffListForAttendanceWidget extends StatelessWidget {
  const StaffListForAttendanceWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StaffAttendanceController>(
      builder: (attendanceController) {
        String timeToAmPm(String time) {
          DateTime dateTime = DateFormat("HH:mm").parse(time);
          String time12Hour = DateFormat("hh:mm a").format(dateTime);
          return time12Hour;
        }
        UserModel? staffModel = attendanceController.userModel;
        return (staffModel != null && staffModel.data != null && staffModel.data!.isNotEmpty)?
        ListView.builder(
          itemCount: staffModel.data?.length??0,
          shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context,index){
          final staff = staffModel.data?[index];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeExtraSmall),
            child: CustomContainer(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(staff?.name??'', style: textRegular.copyWith(),),

              SizedBox(height: 40,
                child: ListView.builder(
                  itemCount: attendanceController.presentTypeList.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, typeIndex){
                    bool selected = attendanceController.presentTypeList[typeIndex].toLowerCase() == staff?.presentType;
                  return Padding(padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: InkWell(onTap: ()=> attendanceController.setPresentType(typeIndex, index),
                      child: Row(children: [
                        Icon(selected? Icons.radio_button_checked_rounded : Icons.radio_button_off,
                          color: selected? Theme.of(context).primaryColor : Theme.of(context).hintColor,),

                        const SizedBox(width: 5),
                        Text(attendanceController.presentTypeList[typeIndex].tr, style: textRegular.copyWith(),),],),
                    ),
                  );
                }),
              ),
              Row(children: [
                Expanded(child: InkWell(onTap: ()=> attendanceController.pickTime(index),
                    child: CustomTextField(title: "check_in".tr,
                        isEnabled : false,
                        suffix: const Icon(Icons.access_time, size: 20),
                        hintText: timeToAmPm(staff?.checkIn??"09:00")))),
                const SizedBox(width: Dimensions.paddingSizeSmall),

                Expanded(child: InkWell(onTap: ()=> attendanceController.pickTime(index, checkOut: true),
                    child: CustomTextField(title: "check_out".tr,
                        isEnabled : false,
                        suffix: const Icon(Icons.access_time, size: 20),
                        hintText: timeToAmPm(staff?.checkOut??"17:00"))))],
              ),

            ],)),
          );
        }):const SizedBox();
      }
    );
  }
}
