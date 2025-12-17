import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/controller/datepicker_controller.dart';
import 'package:mighty_school/common/widget/custom_button.dart';
import 'package:mighty_school/common/widget/custom_snackbar.dart';
import 'package:mighty_school/common/widget/custom_text_field.dart';
import 'package:mighty_school/common/widget/date_selection_widget.dart';
import 'package:mighty_school/feature/routine_management/assignment/controller/assignment_controller.dart';
import 'package:mighty_school/feature/routine_management/assignment/domain/models/assignment_body.dart';
import 'package:mighty_school/feature/routine_management/assignment/domain/models/assignment_model.dart';
import 'package:mighty_school/feature/routine_management/assignment/presentation/widgets/assign_image_section.dart';
import 'package:mighty_school/feature/academic_configuration/class/controller/class_controller.dart';
import 'package:mighty_school/feature/academic_configuration/class/presentation/widgets/select_class_widget.dart';
import 'package:mighty_school/feature/academic_configuration/section/controller/section_controller.dart';
import 'package:mighty_school/feature/academic_configuration/section/presentation/widgets/select_section_widget.dart';
import 'package:mighty_school/feature/academic_configuration/subject/controller/subject_controller.dart';
import 'package:mighty_school/feature/academic_configuration/subject/presentation/widgets/select_subject_widget.dart';
import 'package:mighty_school/util/dimensions.dart';

class CreateNewAssignmentWidget extends StatefulWidget {
  final AssignmentItem? assignmentItem;
  const CreateNewAssignmentWidget({super.key, this.assignmentItem});

  @override
  State<CreateNewAssignmentWidget> createState() => _CreateNewAssignmentWidgetState();
}

class _CreateNewAssignmentWidgetState extends State<CreateNewAssignmentWidget> {
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  bool update = false;
  @override
  void initState() {
    if(widget.assignmentItem != null){
      update = true;
      nameController.text = widget.assignmentItem?.title??'';
      descriptionController.text = widget.assignmentItem?.description??'';
      dateController.text = widget.assignmentItem?.deadline?.toString()??'';

    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AssignmentController>(
        builder: (assignmentController) {
          return Column(mainAxisSize: MainAxisSize.min, children: [


            CustomTextField(title: "title".tr,
              controller: nameController,
              hintText: "enter_title".tr,),

            CustomTextField(title: "description".tr,
              controller: descriptionController,
              hintText: "enter_description".tr,),


            const DateSelectionWidget(),

            const SelectClassWidget(),
            const SelectSectionWidget(),
            const SelectSubjectWidget(),
            const FileSelectionSection(),


            assignmentController.isLoading? const Padding(padding: EdgeInsets.all(Dimensions.paddingSizeDefault),
                child: Center(child: CircularProgressIndicator())):

            Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
                child: CustomButton(onTap: (){
                  String name = nameController.text.trim();
                  String description = descriptionController.text.trim();
                  String deadline = Get.find<DatePickerController>().formatedDate;
                  int? classId = Get.find<ClassController>().selectedClassItem?.id;
                  int? sectionId = Get.find<SectionController>().selectedSectionItem?.id;
                  int? subjectId = Get.find<SubjectController>().selectedSubjectItem?.id;
                  if(name.isEmpty){
                    showCustomSnackBar("title_is_empty".tr);
                  }else if(description.isEmpty){
                    showCustomSnackBar("description_is_empty".tr);
                  }
                  else if(deadline.isEmpty){
                    showCustomSnackBar("deadline_is_empty".tr);
                  }
                  else if(classId == null){
                    showCustomSnackBar("select_class".tr);
                  }
                  else if(sectionId == null){
                    showCustomSnackBar("select_section".tr);
                  }
                  else if(subjectId == null){
                    showCustomSnackBar("select_subject".tr);
                  }
                  else{
                    AssignmentBody assignmentBody = AssignmentBody(
                      title: name,
                      description: description,
                      deadline: deadline,
                      classId: classId.toString(),
                      sectionId: sectionId.toString(),
                      subjectId: subjectId.toString(),
                    );

                    if(update){

                    }else{
                      assignmentController.createNewAssignment(assignmentBody);
                    }

                  }
                }, text:  "confirm".tr))
          ],);
        }
    );
  }
}
