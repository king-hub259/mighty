import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_button.dart';
import 'package:mighty_school/common/widget/custom_snackbar.dart';
import 'package:mighty_school/common/widget/custom_text_field.dart';
import 'package:mighty_school/common/widget/custom_title.dart';
import 'package:mighty_school/feature/academic_configuration/class/controller/class_controller.dart';
import 'package:mighty_school/feature/academic_configuration/class/domain/model/class_model.dart';
import 'package:mighty_school/util/dimensions.dart';

class CreateNewClassScreen extends StatefulWidget {
  final ClassItem? classItem;
  const CreateNewClassScreen({super.key, this.classItem});

  @override
  State<CreateNewClassScreen> createState() => _CreateNewClassScreenState();
}

class _CreateNewClassScreenState extends State<CreateNewClassScreen> {
  TextEditingController nameController = TextEditingController();
  bool update = false;
  @override
  void initState() {
    if(widget.classItem != null){
      update = true;
      nameController.text = widget.classItem?.className??'';
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall)),
      child: Padding(
        padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
        child: GetBuilder<ClassController>(
            builder: (classController) {
              return Column(mainAxisSize: MainAxisSize.min, children: [
                 Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
                    child: CustomTitle(title: update?  "update_class".tr : "add_new_class".tr)),

                CustomTextField(title: "class_name".tr,
                  controller: nameController,
                  hintText: "enter_class_name".tr,),



                classController.isLoading? const Padding(padding: EdgeInsets.all(Dimensions.paddingSizeDefault),
                  child: Center(child: CircularProgressIndicator())):
                Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
                    child: CustomButton(onTap: (){
                      String name = nameController.text.trim();
                      if(name.isEmpty){
                        showCustomSnackBar("name_is_empty".tr);
                      }else{
                        if(update){
                         classController.updateClassList(name,  widget.classItem!.id!);
                        }else{
                          classController.addNewClassList(name);
                        }

                      }
                    }, text: update? "update".tr : "save".tr))
              ],);
            }
        ),
      ),
    );
  }
}
