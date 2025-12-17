import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_button.dart';
import 'package:mighty_school/common/widget/custom_snackbar.dart';
import 'package:mighty_school/common/widget/custom_text_field.dart';
import 'package:mighty_school/common/widget/custom_title.dart';
import 'package:mighty_school/feature/routine_management/assignment/controller/assignment_controller.dart';
import 'package:mighty_school/feature/routine_management/assignment/presentation/widgets/assign_image_section.dart';
import 'package:mighty_school/feature/academic_configuration/class/controller/class_controller.dart';
import 'package:mighty_school/feature/academic_configuration/class/presentation/widgets/select_class_widget.dart';
import 'package:mighty_school/feature/routine_management/syllabus/controller/syllabus_controller.dart';
import 'package:mighty_school/feature/routine_management/syllabus/domain/models/syllabus_model.dart';
import 'package:mighty_school/util/dimensions.dart';

class CreateNewSyllabusWidget extends StatefulWidget {
  final SyllabusItem? syllabusItem;
  const CreateNewSyllabusWidget({super.key, this.syllabusItem});

  @override
  State<CreateNewSyllabusWidget> createState() => _CreateNewSyllabusWidgetState();
}

class _CreateNewSyllabusWidgetState extends State<CreateNewSyllabusWidget> {
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  bool update = false;
  @override
  void initState() {
    if(widget.syllabusItem != null){
      update = true;
      nameController.text = widget.syllabusItem?.title??'';
      descriptionController.text = widget.syllabusItem?.description??'';
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  GetBuilder<SyllabusController>(
        builder: (syllabusController) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
            child: Column(mainAxisSize: MainAxisSize.min, children: [


              const SelectClassWidget(),

              CustomTextField(title: "title".tr,
                controller: nameController,
                hintText: "enter_title".tr,),

              CustomTextField(title: "description".tr,
                controller: descriptionController,
                hintText: "enter_description".tr,),

              const CustomTitle(title: "image",),

              const FileSelectionSection(isSyllabus: true),



              syllabusController.isLoading? const Padding(padding: EdgeInsets.all(Dimensions.paddingSizeDefault),
                  child: Center(child: CircularProgressIndicator())):

              Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
                  child: CustomButton(onTap: (){
                    String name = nameController.text.trim();
                    String description = descriptionController.text.trim();
                    int? classId  = Get.find<ClassController>().selectedClassItem?.id;


                    if(name.isEmpty){
                      showCustomSnackBar("title_is_empty".tr);
                    }else if(description.isEmpty){
                      showCustomSnackBar("description_is_empty".tr);
                    }
                    else if(classId == null){
                      showCustomSnackBar("select_class".tr);
                    }
                    else if(Get.find<AssignmentController>().documents.isEmpty){
                      showCustomSnackBar("select_file".tr);
                    }
                    else{
                      if(update){
                        syllabusController.updateSyllabus(name, description, classId.toString(), widget.syllabusItem!.id!);
                      }else{
                        syllabusController.createNewSyllabus(name, description, classId.toString());
                      }

                    }
                  }, text: "confirm".tr))
            ],),
          );
        }
    );
  }
}
