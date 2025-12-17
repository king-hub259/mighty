import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_button.dart';
import 'package:mighty_school/common/widget/custom_contaner.dart';
import 'package:mighty_school/common/widget/custom_snackbar.dart';
import 'package:mighty_school/common/widget/no_data_found.dart';
import 'package:mighty_school/feature/academic_configuration/class/controller/class_controller.dart';
import 'package:mighty_school/feature/academic_configuration/class/presentation/widgets/select_class_widget.dart';
import 'package:mighty_school/feature/exam_management/exam/controller/exam_controller.dart';
import 'package:mighty_school/feature/exam_management/exam/presentation/widgets/exam_selection_widget.dart';
import 'package:mighty_school/feature/exam_management/exam_startup/presentation/widgets/select_section_widget.dart';
import 'package:mighty_school/feature/routine_management/admit_and_seat_plan/controller/admit_and_seat_plan_controller.dart';
import 'package:mighty_school/feature/routine_management/admit_and_seat_plan/domain/model/admit_card_model.dart';
import 'package:mighty_school/feature/routine_management/admit_and_seat_plan/presentation/widgets/admit_card_item_widget.dart';
import 'package:mighty_school/feature/routine_management/admit_and_seat_plan/presentation/widgets/seat_plan_item_widget.dart';
import 'package:mighty_school/feature/academic_configuration/section/controller/section_controller.dart';
import 'package:mighty_school/util/dimensions.dart';


class AdmitAndSeatPlanWidget extends StatefulWidget {
  const AdmitAndSeatPlanWidget({super.key});

  @override
  State<AdmitAndSeatPlanWidget> createState() => _AdmitAndSeatPlanWidgetState();
}

class _AdmitAndSeatPlanWidgetState extends State<AdmitAndSeatPlanWidget> {
 
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AdmitAndSeatPlanController>(
      builder: (admitCartAndSeatPlanController) {
        return Column(spacing: Dimensions.paddingSizeDefault, children: [

          const CustomContainer(
            child: Row(crossAxisAlignment: CrossAxisAlignment.end,spacing: Dimensions.paddingSizeSmall, children: [
              Expanded(child: ExamSelectionWidget()),

              Expanded(child: SelectClassWidget()),

              Expanded(child: SelectSectionWidget()),

            ],),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
            child: Row(crossAxisAlignment: CrossAxisAlignment.end,spacing: Dimensions.paddingSizeSmall, children: [
              const Spacer(),
              SizedBox(width: 100, child: Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: CustomButton(onTap: (){
                  int? classId =  Get.find<ClassController>().selectedClassItem?.id;
                  int? examId = Get.find<ExamController>().selectedExamItem?.id;
                  int? sectionId = Get.find<SectionController>().selectedSectionItem?.id;
                  if(classId == null){
                    showCustomSnackBar("select_class".tr);
                  }else if(examId == null){
                    showCustomSnackBar("select_exam".tr);
                  }else if(sectionId == null){
                    showCustomSnackBar("select_section".tr);
                  }else {
                    admitCartAndSeatPlanController.selectType(0);
                    admitCartAndSeatPlanController.getAdmitAndSeatPlan(classId, examId, sectionId, "admit_card");
                  }
                }, text: "admit_card".tr),
              )),

              SizedBox(width: 100, child: Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: CustomButton(onTap: (){
                  int? classId =  Get.find<ClassController>().selectedClassItem?.id;
                  int? examId = Get.find<ExamController>().selectedExamItem?.id;
                  int? sectionId = Get.find<SectionController>().selectedSectionItem?.id;
                  if(classId == null){
                    showCustomSnackBar("select_class".tr);
                  }else if(examId == null){
                    showCustomSnackBar("select_exam".tr);
                  }else if(sectionId == null){
                    showCustomSnackBar("select_section".tr);
                  }else {
                    admitCartAndSeatPlanController.selectType(1);
                    admitCartAndSeatPlanController.getAdmitAndSeatPlan(classId, examId, sectionId, "seat_plan");
                  }
                }, text: "seat_plan".tr),
              )),



            ],),
          ),

          GetBuilder<AdmitAndSeatPlanController>(
                builder: (admitCartAndSeatPlanController) {
                  var admitAndSeat = admitCartAndSeatPlanController.admitCardModel?.data;
                  AdmitCardModel? admitCard = admitCartAndSeatPlanController.admitCardModel;
                  return  admitCard != null? (admitCard.data?.data!= null && admitCard.data!.data!.isNotEmpty)?
                  MasonryGridView.count(
                      itemCount: admitAndSeat?.data?.length??0,
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index){
                        return admitCartAndSeatPlanController.selectedType == 0? AdmitCardItemWidget(admitCardItem: admitAndSeat?.data?[index], index: index) :
                        SeatPlanItemWidget(admitCardItem: admitAndSeat?.data?[index], index: index);
                      }, crossAxisCount: admitCartAndSeatPlanController.selectedType == 0? 1: 2,
                      crossAxisSpacing: Dimensions.paddingSizeExtraSmall,
                      mainAxisSpacing: Dimensions.paddingSizeExtraSmall) :
                  Padding(padding: EdgeInsets.symmetric(vertical: Get.height/2),
                    child: const Center(child: NoDataFound()),):

                  const SizedBox();
                }
            ),

          ],
        );
      }
    );
  }
}
