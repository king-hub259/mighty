
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_contaner.dart';
import 'package:mighty_school/feature/parent_module/parent_class_routine/logic/parent_class_routine_controller.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';

class ParentWeekDaysList extends StatelessWidget {
  const ParentWeekDaysList({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ParentClassRoutineController>(
      builder: (routineController) {
        return Container(height: 60,decoration: BoxDecoration(color: Theme.of(context).cardColor),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
            child: ListView.builder(
                itemCount: routineController.days.length,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.zero,
                itemBuilder: (context, index){
                  String day = routineController.days[index];
                  return Padding(padding: const EdgeInsets.fromLTRB(2,10,10,10),
                    child: CustomContainer(onTap: ()=>  routineController.selectDay(day), showShadow: false,
                        horizontalPadding: Dimensions.paddingSizeDefault,
                        borderColor: Theme.of(context).primaryColor.withValues(alpha: .25),
                        color: day == routineController.selectedDay? Theme.of(context).primaryColor : Theme.of(context).cardColor,
                        borderRadius: Dimensions.paddingSizeExtraSmall,
                        child: Text(day, style: textMedium.copyWith(color: day == routineController.selectedDay? Colors.white: null),)),
                  );
                }),
          ),
        );
      }
    );
  }
}
