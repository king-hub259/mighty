import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/feature/parent_module/parent_class_routine/domain/models/parent_classs_routine_model.dart';
import 'package:mighty_school/feature/parent_module/parent_class_routine/logic/parent_class_routine_controller.dart';
import 'package:mighty_school/feature/parent_module/parent_class_routine/presentation/widgets/parent_day_wise_routine_list.dart';

class ParentRoutineListWidget extends StatelessWidget {
  final bool fromHome;
  const ParentRoutineListWidget({super.key, this.fromHome = false});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ParentClassRoutineController>(
      initState: (val){
        if(Get.find<ParentClassRoutineController>().classRoutineModel == null) {
          Get.find<ParentClassRoutineController>().getClassRoutineList();
        }
      },
        builder: (routineController) {
          final Map<String, List<RoutineDetails>?> dayToRoutineMap = {
            routineController.days[0]: routineController.mon,
            routineController.days[1]: routineController.tue,
            routineController.days[2]: routineController.wed,
            routineController.days[3]: routineController.thu,
            routineController.days[4]: routineController.fri,
            routineController.days[5]: routineController.sat,
            routineController.days[6]: routineController.sun,
          };
          return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            ParentDayWiseRoutineList(day: dayToRoutineMap[routineController.selectedDay] ?? [], fromHome: fromHome,)
          ],);
        }
    );
  }
}
