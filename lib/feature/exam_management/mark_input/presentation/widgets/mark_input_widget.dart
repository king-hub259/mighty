import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_button.dart';
import 'package:mighty_school/common/widget/custom_contaner.dart';
import 'package:mighty_school/common/widget/custom_divider.dart';
import 'package:mighty_school/common/widget/custom_snackbar.dart';
import 'package:mighty_school/common/widget/custom_title.dart';
import 'package:mighty_school/common/widget/no_data_found.dart';
import 'package:mighty_school/feature/academic_configuration/class/controller/class_controller.dart';
import 'package:mighty_school/feature/academic_configuration/class/presentation/widgets/select_class_widget.dart';
import 'package:mighty_school/feature/exam_management/exam/controller/exam_controller.dart';
import 'package:mighty_school/feature/exam_management/exam/presentation/widgets/exam_selection_widget.dart';
import 'package:mighty_school/feature/exam_management/mark_input/controller/mark_input_controller.dart';
import 'package:mighty_school/feature/exam_management/mark_input/domain/models/mark_input_model.dart';
import 'package:mighty_school/feature/exam_management/mark_input/presentation/widgets/mark_input_card_widget.dart';
import 'package:mighty_school/feature/exam_management/mark_input/presentation/widgets/mark_input_student_card_widget.dart';
import 'package:mighty_school/feature/academic_configuration/group/controller/group_controller.dart';
import 'package:mighty_school/feature/academic_configuration/group/presentation/widgets/select_group_widget.dart';
import 'package:mighty_school/feature/academic_configuration/subject/controller/subject_controller.dart';
import 'package:mighty_school/feature/academic_configuration/subject/presentation/widgets/select_subject_widget.dart';
import 'package:mighty_school/helper/responsive_helper.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';

class MarkInputWidget extends StatelessWidget {
  final ScrollController scrollController;
  const MarkInputWidget({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      child: GetBuilder<MarkInputController>(
        builder: (markInputController) {
          MarkInputModel? markInputModel = markInputController.markInputModel;
          var markInputItem = markInputController.markInputModel?.data;
          return Column(spacing: Dimensions.paddingSizeSmall, children: [
            CustomTitle(title: "mark_input".tr, fontSize: Dimensions.fontSizeLarge, fontWeight: FontWeight.w600),
            Row(crossAxisAlignment: CrossAxisAlignment.end,  spacing : Dimensions.paddingSizeSmall, children: [
              const Expanded(child: SelectClassWidget()),

              const Expanded(child: ExamSelectionWidget()),
              const Expanded(child: SelectGroupWidget()),
              const Expanded(child: SelectSubjectWidget()),

              Padding(padding: const EdgeInsets.only(bottom: 9),
                child: SizedBox(width: 90, child: markInputController.isLoading?
                    const Center(child: CircularProgressIndicator()):
                CustomButton(onTap: (){
                  int? classId = Get.find<ClassController>().selectedClassItem?.id;
                  int? examId = Get.find<ExamController>().selectedExamItem?.id;
                  int? groupId = Get.find<GroupController>().groupItem?.id;
                  int? subjectId = Get.find<SubjectController>().selectedSubjectItem?.id;
                  if (classId == null){
                    showCustomSnackBar("select_class".tr);
                  }
                  else if(examId == null){
                    showCustomSnackBar("select_exam".tr);
                  }
                  else if(groupId == null){
                    showCustomSnackBar("select_group".tr);
                  }
                  else if(subjectId == null){
                    showCustomSnackBar("select_subject".tr);
                  }
                  else{
                    markInputController.markInputGet(classId, examId, groupId, subjectId);
                  }
                }, text: "search".tr)))
            ],),

            if(ResponsiveHelper.isDesktop(context))...[
              const CustomDivider(verticalPadding: Dimensions.paddingSizeSmall),
              Row( children: [
                Expanded(child: Text('exam_code_title'.tr, style: textMedium.copyWith(fontSize: Dimensions.fontSizeDefault),)),
                const SizedBox(width: Dimensions.paddingSizeSmall),
                Expanded(child: Text("total".tr, style: textRegular.copyWith(fontSize: Dimensions.fontSizeDefault),)),
                const SizedBox(width: Dimensions.paddingSizeSmall),
                Expanded(child: Text("pass_mark".tr, style: textRegular.copyWith(fontSize: Dimensions.fontSizeDefault),)),
                const SizedBox(width: Dimensions.paddingSizeSmall),
                Expanded(child: Text("acceptance".tr, style: textRegular.copyWith(fontSize: Dimensions.fontSizeDefault),))
              ],),
              const CustomDivider(verticalPadding: Dimensions.paddingSizeSmall),
            ],

            markInputModel != null? (markInputModel.data!= null && markInputModel.data!.markConfig!.isNotEmpty)?
            ListView.builder(
                itemCount: markInputItem?.markConfig?.length??0,
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index){
                  return MarkInputCardWidget(markConfig: markInputItem?.markConfig?[index]);
                }) :
            const Center(child: NoDataFound()):

            const SizedBox(),


            CustomTitle(title: "student_list".tr),
            markInputModel != null? (markInputModel.data!= null && markInputModel.data!.students!.isNotEmpty)?
            ListView.builder(
                itemCount: markInputItem?.students?.length??0,
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index){
                  return MarkInputStudentCardWidget(students: markInputItem?.students?[index], markConfigItem: markInputItem,);
                }) :
            Padding(padding: EdgeInsets.only(top: Get.height/2),
                child: const Center(child: NoDataFound())):

            const SizedBox(),

            Align(alignment: Alignment.centerRight, child: SizedBox(width: 90, child: CustomButton(onTap: (){}, text: "Save".tr)))


          ],);
        }
      ),
    );
  }
}
