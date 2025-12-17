import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_button.dart';
import 'package:mighty_school/common/widget/custom_contaner.dart';
import 'package:mighty_school/common/widget/custom_divider.dart';
import 'package:mighty_school/common/widget/custom_snackbar.dart';
import 'package:mighty_school/common/widget/no_data_found.dart';
import 'package:mighty_school/feature/academic_configuration/class/controller/class_controller.dart';
import 'package:mighty_school/feature/academic_configuration/class/presentation/widgets/select_class_widget.dart';
import 'package:mighty_school/feature/exam_management/exam/controller/exam_controller.dart';
import 'package:mighty_school/feature/exam_management/exam/presentation/widgets/exam_selection_widget.dart';
import 'package:mighty_school/feature/academic_configuration/group/controller/group_controller.dart';
import 'package:mighty_school/feature/academic_configuration/group/presentation/widgets/select_group_widget.dart';
import 'package:mighty_school/feature/routine_management/exam_routine/controller/exam_routine_controller.dart';
import 'package:mighty_school/feature/routine_management/exam_routine/domain/model/exam_routine_model.dart';
import 'package:mighty_school/feature/routine_management/exam_routine/presentation/widgets/exam_routine_item_widget.dart';
import 'package:mighty_school/helper/responsive_helper.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';


class ExamRoutineWidget extends StatefulWidget {
  const ExamRoutineWidget({super.key});

  @override
  State<ExamRoutineWidget> createState() => _ExamRoutineWidgetState();
}

class _ExamRoutineWidgetState extends State<ExamRoutineWidget> {
 
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ExamRoutineController>(
      builder: (examRoutineController) {
        return CustomContainer(
          child: Column(children: [

            Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
              const Expanded(child: ExamSelectionWidget()),
              const SizedBox(width: Dimensions.paddingSizeSmall),
              const Expanded(child: SelectClassWidget()),
              const SizedBox(width: Dimensions.paddingSizeSmall),
              const Expanded(child: SelectGroupWidget()),
              const SizedBox(width: Dimensions.paddingSizeSmall),
              SizedBox(width: 90, child: Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: CustomButton(onTap: (){
                  int? classId =  Get.find<ClassController>().selectedClassItem?.id;
                  int? examId = Get.find<ExamController>().selectedExamItem?.id;
                  int? groupId = Get.find<GroupController>().groupItem?.id;
                  if(classId == null){
                    showCustomSnackBar("select_class".tr);
                  }else if(examId == null){
                    showCustomSnackBar("select_exam".tr);
                  }else if(groupId == null){
                    showCustomSnackBar("select_group".tr);
                  }else {
                    examRoutineController.getExamRoutineList(classId, examId);
                  }
                }, text: "search".tr),
              )),

            ],),
          if(ResponsiveHelper.isDesktop(context))...[
            const CustomDivider(),
            Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
              child: Row(spacing: Dimensions.paddingSizeSmall, children: [
                Expanded(child: Text("subject".tr, style: textRegular)),
                Expanded(child: Text("date".tr, style: textRegular)),
                Expanded(child: Text("start_time".tr, style: textRegular)),
                Expanded(child: Text("end_time".tr, style: textRegular)),
                Expanded(child: Text("room".tr, style: textRegular)),
              ],),
            ),
            const CustomDivider(),
          ],

          GetBuilder<ExamRoutineController>(
                  builder: (examRoutineController) {
                    var examRoutine = examRoutineController.examRoutineModel?.data;
                    ExamRoutineModel? examRoutineModel = examRoutineController.examRoutineModel;
                    return  examRoutineModel != null? (examRoutineModel.data!= null && examRoutineModel.data!.isNotEmpty)?
                    ListView.builder(
                        itemCount: examRoutine?.length??0,
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index){
                          return ExamRoutineItemWidget(examRoutineItem: examRoutine?[index], index: index);
                        }) :
                    Padding(padding: EdgeInsets.symmetric(vertical: Get.height/2),
                      child: const Center(child: NoDataFound()),):

                    const SizedBox();
                  }
              ),
            Align(alignment: Alignment.centerRight,
              child: SizedBox(width: 90, child: CustomButton(onTap: (){}, text: "Save".tr)),
            )
            ],
          ),
        );
      }
    );
  }
}
