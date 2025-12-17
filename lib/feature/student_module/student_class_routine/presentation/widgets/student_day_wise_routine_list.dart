import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/feature/parent_module/parent_class_routine/domain/models/parent_classs_routine_model.dart';
import 'package:mighty_school/feature/student_module/student_class_routine/logic/student_class_routine_controller.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';

class StudentDayWiseRoutineList extends StatefulWidget {
  final List<RoutineDetails>?  day;
  final bool fromHome;
  const StudentDayWiseRoutineList({super.key, required this.day, this.fromHome = false});

  @override
  State<StudentDayWiseRoutineList> createState() => _StudentDayWiseRoutineListState();
}

class _StudentDayWiseRoutineListState extends State<StudentDayWiseRoutineList> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(height: widget.fromHome? 190 : null,
      child: GetBuilder<StudentClassRoutineController>(
        builder: (routineController) {
          return widget.day != null? GridView.builder(
            itemCount: widget.day?.length??0,
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              scrollDirection: widget.fromHome ? Axis.horizontal : Axis.vertical,
              physics: widget.fromHome? const AlwaysScrollableScrollPhysics() :const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index){
                RoutineDetails? routineDetails = widget.day![index];
            return Padding(
              padding: EdgeInsets.symmetric(vertical: widget.fromHome ? 3 : 0, horizontal:  widget.fromHome ? 3 : 0),
              child: Container(decoration: ThemeShadow.getDecoration(
                color: Theme.of(context).primaryColor, shadowColor: Theme.of(context).primaryColorDark
              ), child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(routineDetails.subjectName??'N/A', style: textSemiBold.copyWith(fontSize: widget.fromHome? Dimensions.fontSizeDefault : Dimensions.fontSizeLarge),),
                Text("${routineDetails.teacherName??'N/A'}", style: textMedium.copyWith(fontSize: Dimensions.fontSizeSmall),),
                if(routineDetails.startTime != null)
                Text("${routineController.formatTimeToAmPm(routineDetails.startTime)} - ${routineController.formatTimeToAmPm(routineDetails.endTime)}",
                  style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall),),
              ],),),
            );
          }, gridDelegate:   SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: 200,

              childAspectRatio: widget.fromHome? 0.5 : 2,
              crossAxisSpacing:  Dimensions.paddingSizeSmall,
              mainAxisSpacing: widget.fromHome? Dimensions.paddingSizeExtraSmall : Dimensions.paddingSizeSmall),): const SizedBox();
        }
      ),
    );
  }
}
