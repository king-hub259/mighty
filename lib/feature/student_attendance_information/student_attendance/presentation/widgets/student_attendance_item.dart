import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_contaner.dart';
import 'package:mighty_school/feature/student_attendance_information/student_attendance/controller/student_attendance_controller.dart';
import 'package:mighty_school/feature/student_attendance_information/student_attendance/domain/models/student_for_attendance_model.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';

class StudentAttendanceItem extends StatelessWidget {
  final StudentItem? studentItem;
  final int index;
  const StudentAttendanceItem({super.key, this.studentItem, required this.index});

  @override
  Widget build(BuildContext context) {


    return Padding(padding: const EdgeInsets.symmetric(vertical: 5),
      child: CustomContainer(color: studentItem!.isPresent!? Theme.of(context).cardColor : Theme.of(context).highlightColor,
          showShadow: studentItem!.isPresent!,
          borderRadius: 5,
          child: Row(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                
                Text("${'name'.tr} : ${studentItem?.firstName??''} ${studentItem?.lastName??''}", style: textRegular.copyWith(),),
                Row(
                  children: [
                    Text("${'roll'.tr} : ${studentItem?.roll??''}", style: textRegular.copyWith(),),
                    const SizedBox(width: Dimensions.paddingSizeDefault,),

                    GetBuilder<StudentAttendanceController>(
                        builder: (studentAttendanceController) {
                          return Row(children: [
                            InkWell(onTap: () => studentAttendanceController.updateAttendanceStatus(index,true),
                              child: Row(children: [
                                Icon(studentItem!.isPresent!? Icons.radio_button_checked_rounded : Icons.radio_button_off,
                                  color: studentItem!.isPresent!? Theme.of(context).primaryColor : Theme.of(context).hintColor,),

                                const SizedBox(width: 5),
                                Text("present".tr, style: textRegular.copyWith(),),],),
                            ),

                            Padding(padding: const EdgeInsets.symmetric(horizontal: 10.0),
                              child: InkWell(onTap: ()=>studentAttendanceController.updateAttendanceStatus(index,false),
                                child: Row(children: [
                                  Icon(!studentItem!.isPresent!? Icons.radio_button_checked_rounded : Icons.radio_button_off,
                                    color: !studentItem!.isPresent!? Theme.of(context).primaryColor : Theme.of(context).hintColor,),
                                  const SizedBox(width: 5),
                                  Text("absent".tr, style: textRegular.copyWith(),),],),
                              ),
                            ),
                          ],
                          );
                        }
                    ),
                  ],
                ),





              ]),
              ),
            ],
          )),
    );
  }
}