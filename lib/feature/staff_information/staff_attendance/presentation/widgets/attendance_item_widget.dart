import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mighty_school/common/widget/active_inactive_widget.dart';
import 'package:mighty_school/common/widget/custom_contaner.dart';
import 'package:mighty_school/common/widget/edit_delete_section.dart';
import 'package:mighty_school/feature/student_attendance_information/student_attendance/domain/models/student_attendance_model.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';

class AttendanceItemWidget extends StatelessWidget {
  final AttendanceItem? attendanceItem;
  final int index;
  const AttendanceItemWidget({super.key, this.attendanceItem, required this.index});

  @override
  Widget build(BuildContext context) {

    String convertToAmPm(String time24Hour) {
      String desiredTime = time24Hour.substring(0, time24Hour.length-3);
      DateTime parsedTime = DateFormat('HH:mm').parse(desiredTime);
      String formattedTime = DateFormat('hh:mm a').format(parsedTime);
      return formattedTime;
    }

    return Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault, vertical: 5),
      child: CustomContainer(color: index % 2 == 1? Theme.of(context).cardColor : Theme.of(context).highlightColor,
          showShadow: index % 2 == 1,
          child: Row(crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text("${attendanceItem?.date}", style: textMedium.copyWith(fontSize: Dimensions.fontSizeDefault),),
              const SizedBox(height: Dimensions.paddingSizeSmall,),
              Text("${'check_in'.tr} : ${convertToAmPm(attendanceItem!.checkIn!)}", style: textRegular.copyWith(),),
              Text("${'check_out'.tr} : ${convertToAmPm(attendanceItem!.checkOut!)}", style: textRegular.copyWith(),),

            AttendanceStatusWidget(active: attendanceItem?.status == "present", status: attendanceItem?.status??'',),
              if(attendanceItem?.notes != null)
              Text("${'note'.tr} : ${attendanceItem?.notes}", style: textRegular.copyWith(color: Theme.of(context).hintColor),),
            ]),
          ),
          EditDeleteSection(onEdit: (){

          },
            onDelete: (){

          },)
        ],
      )),
    );
  }
}