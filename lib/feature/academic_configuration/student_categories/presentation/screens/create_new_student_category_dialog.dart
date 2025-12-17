import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_button.dart';
import 'package:mighty_school/common/widget/custom_snackbar.dart';
import 'package:mighty_school/common/widget/custom_text_field.dart';
import 'package:mighty_school/common/widget/custom_title.dart';
import 'package:mighty_school/feature/academic_configuration/student_categories/controller/student_categories_controller.dart';
import 'package:mighty_school/feature/academic_configuration/student_categories/domain/model/student_categories_model.dart';
import 'package:mighty_school/helper/responsive_helper.dart';
import 'package:mighty_school/util/dimensions.dart';

class CreateNewStudentCategoriesScreen extends StatefulWidget {
  final StudentCategoryItem? studentCategoryItem;
  const CreateNewStudentCategoriesScreen({super.key, this.studentCategoryItem});

  @override
  State<CreateNewStudentCategoriesScreen> createState() => _CreateNewStudentCategoriesScreenState();
}

class _CreateNewStudentCategoriesScreenState extends State<CreateNewStudentCategoriesScreen> {
  TextEditingController nameController = TextEditingController();
  bool update = false;
  @override
  void initState() {
    if(widget.studentCategoryItem != null){
      update = true;
      nameController.text = widget.studentCategoryItem?.name??'';
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Dialog(insetPadding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall)),
      child: SizedBox(width: ResponsiveHelper.isDesktop(context)? 500 : Get.width,
        child: Padding(
          padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
          child: GetBuilder<StudentCategoriesController>(
              builder: (studentCategoriesController) {
                return Column(mainAxisSize: MainAxisSize.min, children: [
                   Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
                      child: CustomTitle(title: update?  "update_category".tr : "add_new_category".tr)),

                  CustomTextField(title: "name".tr,
                    controller: nameController,
                    hintText: "enter_name".tr,),



                  studentCategoriesController.isLoading? const Padding(padding: EdgeInsets.all(Dimensions.paddingSizeDefault),
                    child: Center(child: CircularProgressIndicator())):
                  Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
                      child: CustomButton(onTap: (){
                        String name = nameController.text.trim();
                        if(name.isEmpty){
                          showCustomSnackBar("name_is_empty".tr);
                        }else{
                          if(update){
                            //studentCategoriesController.updateClassList(name,  widget.studentCategoryItem!.id!);
                          }else{
                            studentCategoriesController.addNewStudentCategories(name);
                          }

                        }
                      }, text: "confirm".tr))
                ],);
              }
          ),
        ),
      ),
    );
  }
}
