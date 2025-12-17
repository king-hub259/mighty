import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_contaner.dart';
import 'package:mighty_school/common/widget/custom_snackbar.dart';
import 'package:mighty_school/feature/academic_configuration/class/controller/class_controller.dart';
import 'package:mighty_school/feature/exam_management/exam/controller/exam_controller.dart';
import 'package:mighty_school/feature/exam_management/exam_startup/controller/exam_startup_controller.dart';
import 'package:mighty_school/feature/exam_management/exam_startup/domain/model/exam_assign_store_body.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';

class ExamAssignSubmitButtonWidget extends StatelessWidget {
  const ExamAssignSubmitButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ExamStartupController>(
      builder: (examStartupController) {
        return GetBuilder<ExamController>(
          builder: (examController) {
            return Align(alignment: Alignment.centerRight,
                child: CustomContainer(borderRadius: Dimensions.paddingSizeExtraSmall,
                  onTap: (){

                    int? classId = Get.find<ClassController>().selectedClassItem?.id;

                    List<String> selectedExams = [];
                    if(examController.selectedExamList.isNotEmpty){
                      selectedExams = examController.selectedExamList.map((e) => e.id!.toString()).toList();
                    }

                    if(classId == null){
                      showCustomSnackBar("select_class".tr);
                    }
                    else if(selectedExams.isEmpty){
                      showCustomSnackBar("select_exam".tr);
                    }
                    else if(examStartupController.selectedMeritProcessType == null){
                      showCustomSnackBar("select_merit_process_type".tr);
                    }
                    else{
                      ExamAssignStoreBody body = ExamAssignStoreBody(classId: classId.toString(), examIds: selectedExams, meritProcessTypeId:examStartupController.selectedMeritProcessType?.id.toString());
                      examStartupController.examAssignStore(body);
                    }
                  },
                  horizontalPadding: 20,
                  color: Theme.of(context).primaryColor,
                  child: examStartupController.isLoading?
                  const Center(child: CircularProgressIndicator()):
                  Text("confirm".tr, style: textRegular.copyWith(color: Colors.white)),));
          }
        );
      }
    );
  }
}
