import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/feature/routine_management/class_routine/domain/models/classs_routine_model.dart';
import 'package:mighty_school/feature/routine_management/class_routine/logic/class_routine_controller.dart';
import 'package:mighty_school/helper/responsive_helper.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';


class DayWiseRoutineList extends StatefulWidget {
  final List<DAY>?  day;
  const DayWiseRoutineList({super.key, required this.day});

  @override
  State<DayWiseRoutineList> createState() => _DayWiseRoutineListState();
}

class _DayWiseRoutineListState extends State<DayWiseRoutineList> {
  @override
  Widget build(BuildContext context) {
    log("day==> ${widget.day}");
    return GetBuilder<ClassRoutineController>(
      builder: (routineController) {
        return widget.day != null? GridView.builder(
          itemCount: widget.day?.length??0,
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index){
              DAY? routineDetails = widget.day![index];
          return Container(decoration: ThemeShadow.getDecoration(), child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text("${routineDetails.subjectName}", style: textSemiBold.copyWith(fontSize: Dimensions.fontSizeLarge)),
            Text("${routineDetails.teacherName}", style: textMedium.copyWith(fontSize: Dimensions.fontSizeSmall)),
            if(routineDetails.startTime != null)
            Text("${routineController.formatTimeToAmPm(routineDetails.startTime??DateTime.now().toString())} - ${routineController.formatTimeToAmPm(routineDetails.endTime??DateTime.now().toString())}",
              style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall),),
          ],),);
        }, gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: ResponsiveHelper.isDesktop(context)?3 : 2,
            childAspectRatio: 2,
            crossAxisSpacing:  Dimensions.paddingSizeSmall,
            mainAxisSpacing:  Dimensions.paddingSizeSmall),): const SizedBox();
      }
    );
  }
}
