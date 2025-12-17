import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_button.dart';
import 'package:mighty_school/common/widget/custom_snackbar.dart';
import 'package:mighty_school/common/widget/custom_text_field.dart';
import 'package:mighty_school/common/widget/custom_title.dart';
import 'package:mighty_school/feature/exam_management/exam/controller/exam_controller.dart';
import 'package:mighty_school/feature/exam_management/exam/domain/model/exam_model.dart';
import 'package:mighty_school/helper/responsive_helper.dart';
import 'package:mighty_school/util/dimensions.dart';

class CreateNewExamDialog extends StatefulWidget {
  final ExamItem? examItem;
  const CreateNewExamDialog({super.key, this.examItem});

  @override
  State<CreateNewExamDialog> createState() => _CreateNewExamDialogState();
}

class _CreateNewExamDialogState extends State<CreateNewExamDialog> {TextEditingController nameController = TextEditingController();
TextEditingController serialController = TextEditingController();
bool update = false;
@override
void initState() {
  if(widget.examItem != null){
    update = true;
    nameController.text = widget.examItem?.name??'';

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
          child: GetBuilder<ExamController>(
              builder: (examController) {
                return Column(mainAxisSize: MainAxisSize.min, children: [
                  Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
                      child: CustomTitle(title: update?  "update_exam".tr : "add_new_exam".tr)),

                  CustomTextField(title: "name".tr,
                    controller: nameController,
                    hintText: "enter_name".tr,),




                  examController.isLoading? const Padding(padding: EdgeInsets.all(Dimensions.paddingSizeDefault),
                      child: Center(child: CircularProgressIndicator())):
                  Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
                      child: CustomButton(onTap: (){
                        String name = nameController.text.trim();
                        serialController.text.trim();
                        if(name.isEmpty){
                          showCustomSnackBar("name_is_empty".tr);
                        }

                        else{
                          if(update){
                            examController.updateExam(name, widget.examItem!.id!);
                          }else{
                            examController.addNewExam(name);
                          }
                        }
                      }, text:  "confirm".tr))
                ],);
              }
          ),
        ),
      ),
    );
  }
}
