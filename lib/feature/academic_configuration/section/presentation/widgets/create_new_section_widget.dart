import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_button.dart';
import 'package:mighty_school/common/widget/custom_snackbar.dart';
import 'package:mighty_school/common/widget/custom_text_field.dart';
import 'package:mighty_school/feature/academic_configuration/class/controller/class_controller.dart';
import 'package:mighty_school/feature/academic_configuration/class/presentation/widgets/select_class_widget.dart';
import 'package:mighty_school/feature/academic_configuration/group/controller/group_controller.dart';
import 'package:mighty_school/feature/academic_configuration/group/presentation/widgets/select_group_widget.dart';
import 'package:mighty_school/feature/academic_configuration/section/controller/section_controller.dart';
import 'package:mighty_school/feature/academic_configuration/section/domain/model/section_body.dart';
import 'package:mighty_school/feature/academic_configuration/section/domain/model/section_model.dart';
import 'package:mighty_school/feature/staff_information/teacher/controller/teacher_controller.dart';
import 'package:mighty_school/feature/staff_information/teacher/presentation/widgets/teacher_selection_widget.dart';
import 'package:mighty_school/util/dimensions.dart';

class CreateNewSectionWidget extends StatefulWidget {
  final SectionItem? sectionItem;
  const CreateNewSectionWidget({super.key, this.sectionItem});

  @override
  State<CreateNewSectionWidget> createState() => _CreateNewSectionWidgetState();
}

class _CreateNewSectionWidgetState extends State<CreateNewSectionWidget> {
  TextEditingController nameController = TextEditingController();
  TextEditingController roomController = TextEditingController();
  bool update = false;
  @override
  void initState() {
    if(widget.sectionItem != null){
      update = true;
      nameController.text = widget.sectionItem?.sectionName??'';
      roomController.text = widget.sectionItem?.roomNo??'';
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SectionController>(
        builder: (sectionController) {
          return Column(mainAxisSize: MainAxisSize.min, children: [

            const SelectClassWidget(),
            const SelectGroupWidget(),
            const SelectTeacherWidget(),

            CustomTextField(title: "name".tr,
              controller: nameController,
              hintText: "enter_name".tr,),



            CustomTextField(title: "room".tr,
              controller: roomController,
              hintText: "room_number".tr,),





            sectionController.isLoading? const Padding(padding: EdgeInsets.all(Dimensions.paddingSizeDefault),
                child: Center(child: CircularProgressIndicator())):

            Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
                child: CustomButton(onTap: (){
                  String name = nameController.text.trim();
                  String room = roomController.text.trim();
                  int? classId = Get.find<ClassController>().selectedClassItem?.id;
                  int? groupId = Get.find<GroupController>().groupItem?.id;
                  int? teacherId = Get.find<TeacherController>().selectedTeacherItem?.id;
                  if(name.isEmpty){
                    showCustomSnackBar("name_is_empty".tr);
                  }
                  else if(room.isEmpty){
                    showCustomSnackBar("room_number_is_empty".tr);
                  }
                  else if(classId == null){
                    showCustomSnackBar("select_class".tr);
                  }
                  else if(groupId == null){
                    showCustomSnackBar("select_group".tr);
                  }
                  else if(teacherId == null){
                    showCustomSnackBar("select_teacher".tr);
                  }

                  else{

                    SectionBody sectionBody = SectionBody(
                        sectionName: name,
                        classId: classId.toString(),
                        studentGroup: groupId.toString(),
                        classTeacher: teacherId.toString(),
                        method: update? "PUT":"POST"
                    );

                    if(update){
                      sectionController.updateSection(sectionBody, widget.sectionItem!.id!);
                    }else{
                      sectionController.addNewSection(sectionBody);
                    }

                  }
                }, text: update? "update".tr : "save".tr))
          ],);
        }
    );
  }
}
