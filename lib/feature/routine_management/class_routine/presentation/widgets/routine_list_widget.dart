import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/feature/routine_management/class_routine/domain/models/classs_routine_model.dart';
import 'package:mighty_school/feature/routine_management/class_routine/logic/class_routine_controller.dart';
import 'package:mighty_school/feature/routine_management/class_routine/presentation/widgets/day_wise_routine_list.dart';


class RoutineListWidget extends StatelessWidget {
  const RoutineListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ClassRoutineController>(
        builder: (routineController) {
          final Map<String, List<DAY>?> dayToRoutineMap = {
            routineController.days[0]: routineController.mon,
            routineController.days[1]: routineController.tue,
            routineController.days[2]: routineController.wed,
            routineController.days[3]: routineController.thu,
            routineController.days[4]: routineController.fri,
            routineController.days[5]: routineController.sat,
            routineController.days[6]: routineController.sun,
          };
          return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            DayWiseRoutineList(day: dayToRoutineMap[routineController.selectedDay] ?? [])
          ],);
        }
    );
  }
}
