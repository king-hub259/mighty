import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_contaner.dart';
import 'package:mighty_school/common/widget/custom_snackbar.dart';
import 'package:mighty_school/feature/academic_configuration/class/controller/class_controller.dart';
import 'package:mighty_school/feature/academic_configuration/class/presentation/widgets/select_class_widget.dart';
import 'package:mighty_school/feature/academic_configuration/group/controller/group_controller.dart';
import 'package:mighty_school/feature/academic_configuration/group/presentation/widgets/select_group_widget.dart';
import 'package:mighty_school/feature/academic_configuration/section/controller/section_controller.dart';
import 'package:mighty_school/feature/academic_configuration/section/presentation/widgets/select_section_widget.dart';
import 'package:mighty_school/feature/academic_configuration/session/controller/session_controller.dart';
import 'package:mighty_school/feature/academic_configuration/session/presentation/widgets/session_selection_widget.dart';
import 'package:mighty_school/feature/students_information/student/controller/student_controller.dart';
import 'package:mighty_school/feature/students_information/student/presentation/widgets/select_file_for_bulk_import.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';

class BulkImportStudentsDialog extends StatelessWidget {
  const BulkImportStudentsDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall)),
        child: GetBuilder<StudentController>(
      builder: (studentController) {
        return Padding(
          padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            InkWell(
              child: Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min,
                    spacing: Dimensions.paddingSizeDefault,
                    children: [
                      const Row(spacing: Dimensions.paddingSizeDefault, children: [

                        Expanded(child: SelectSessionWidget()),
                        Expanded(child: SelectClassWidget()),
                        Expanded(child: SelectGroupWidget()),
                        Expanded(child: SelectSectionWidget()),
                      ]),
                      Row(spacing: Dimensions.paddingSizeDefault, children: [
                        const SelectBulkStudentImportDocWidget(),
                        Expanded(child: DottedBorder(borderType: BorderType.RRect,
                          radius: const Radius.circular(5), dashPattern: const [5  ,5],
                          strokeWidth: 0.25,
                          color: Theme.of(context).hintColor,
                          padding: const EdgeInsets.all(6),
                          child: InkWell(onTap: ()=> studentController.pickDocument(),
                            child: Center(child: Padding(padding: const EdgeInsets.symmetric(vertical: 8.0),
                                child: Text.rich(TextSpan(children: [
                                  TextSpan(text: "click_to_upload".tr, style: textBold.copyWith(color: Theme.of(context).hintColor)),
                                ])))),
                          ),
                        ))
                      ]),
                      Row(spacing: Dimensions.paddingSizeDefault, mainAxisAlignment: MainAxisAlignment.end, children: [

                        CustomContainer(
                          onTap: () {
                            studentController.downloadSampleFileForBulkStudent();
                          },
                          color: Theme.of(context).primaryColor, borderRadius: 5, horizontalPadding: 15, verticalPadding: 7,
                          child: Text("download_sample_file".tr, style: textBold.copyWith(color:Colors.white)),),

                        CustomContainer(onTap: ()=> Get.back(),
                          color: Theme.of(context).colorScheme.error, borderRadius: 5, horizontalPadding: 15, verticalPadding: 7,
                          child: Text("cancel".tr, style: textBold.copyWith(color: Colors.white)),),

                        CustomContainer(onTap: (){
                          int? sessionId = Get.find<SessionController>().selectedSessionItem?.id;
                          int? classId = Get.find<ClassController>().selectedClassItem?.id;
                          int? groupId = Get.find<GroupController>().groupItem?.id;
                          int? sectionId = Get.find<SectionController>().selectedSectionItem?.id;

                          if(sectionId == null){
                            showCustomSnackBar("select_session".tr);
                          }else if(classId == null){
                            showCustomSnackBar("select_class".tr);
                          }else if(groupId == null){
                            showCustomSnackBar("select_group".tr);
                          }
                          else if(sessionId == null){
                            showCustomSnackBar("select_session".tr);
                          }
                          else if(studentController.docFile == null){
                            showCustomSnackBar("select_file".tr);
                          }

                          else{
                            studentController.uploadBulkStudent(sessionId, classId, groupId, sectionId);
                          }

                        },
                          color: Theme.of(context).primaryColor, borderRadius: 5, horizontalPadding: 15, verticalPadding: 7,
                          child: Text("upload".tr, style: textBold.copyWith(color:Colors.white)),),

                      ])
                    ],
                  )),
            )
          ]),
        );
      }
    ));
  }
}
