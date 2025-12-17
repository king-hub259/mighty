import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_button.dart';
import 'package:mighty_school/common/widget/custom_contaner.dart';
import 'package:mighty_school/common/widget/custom_snackbar.dart';
import 'package:mighty_school/feature/academic_configuration/class/controller/class_controller.dart';
import 'package:mighty_school/feature/academic_configuration/class/presentation/widgets/select_class_widget.dart';
import 'package:mighty_school/feature/exam_management/exam_startup/presentation/widgets/select_section_widget.dart';
import 'package:mighty_school/feature/routine_management/class_routine/logic/class_routine_controller.dart';
import 'package:mighty_school/feature/routine_management/class_routine/presentation/widgets/routine_list_widget.dart';
import 'package:mighty_school/feature/routine_management/class_routine/presentation/widgets/week_days_list.dart';
import 'package:mighty_school/feature/academic_configuration/section/controller/section_controller.dart';

import 'package:mighty_school/util/dimensions.dart';


class ClassRoutineWidget extends StatefulWidget {
  const ClassRoutineWidget({super.key});

  @override
  State<ClassRoutineWidget> createState() => _ClassRoutineWidgetState();
}

class _ClassRoutineWidgetState extends State<ClassRoutineWidget> {

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ClassRoutineController>(
        builder: (classRoutineController) {
          return CustomContainer(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

              Row(crossAxisAlignment: CrossAxisAlignment.end, children: [

                const Expanded(child: SelectClassWidget()),
                const SizedBox(width: Dimensions.paddingSizeSmall),
                const Expanded(child: SelectSectionWidget()),
                const SizedBox(width: Dimensions.paddingSizeSmall),
                SizedBox(width: 90, child: Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: CustomButton(onTap: (){
                    int? classId = Get.find<ClassController>().selectedClassItem?.id;
                    int? sectionId = Get.find<SectionController>().selectedSectionItem?.id;
                    if(classId == null){
                      showCustomSnackBar("select_class".tr);
                    }else if(sectionId == null){
                      showCustomSnackBar("select_section".tr);
                    }else{
                      classRoutineController.getClassRoutineList(classId, sectionId);
                    }
                  }, text: "search".tr),
                )),

              ],),

              const WeekDaysList(),
              const RoutineListWidget(),

            ],
            ),
          );
        }
    );
  }
}