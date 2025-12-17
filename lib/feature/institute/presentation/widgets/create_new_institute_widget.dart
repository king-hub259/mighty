import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_button.dart';
import 'package:mighty_school/common/widget/custom_snackbar.dart';
import 'package:mighty_school/common/widget/custom_text_field.dart';
import 'package:mighty_school/common/widget/custom_title.dart';
import 'package:mighty_school/feature/institute/controller/institute_controller.dart';
import 'package:mighty_school/feature/institute/domain/models/institute_model.dart';
import 'package:mighty_school/util/dimensions.dart';

class CreateNewInstituteWidget extends StatefulWidget {
  final InstituteItem? instituteItem;
  const CreateNewInstituteWidget({super.key, this.instituteItem});

  @override
  State<CreateNewInstituteWidget> createState() => _CreateNewInstituteWidgetState();
}

class _CreateNewInstituteWidgetState extends State<CreateNewInstituteWidget> {
  TextEditingController instituteTitleController = TextEditingController();
  bool update = false;
  @override
  void initState() {
    if(widget.instituteItem != null){
      update = true;
      instituteTitleController.text = widget.instituteItem?.name??'';
      
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: GetBuilder<InstituteController>(
          builder: (instituteController) {
            return Padding(
              padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                const Padding(padding: EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
                    child: CustomTitle(title: "add_new_institute")),

                CustomTextField(title: "institute".tr,
                  controller: instituteTitleController,
                  hintText: "name".tr,),


                instituteController.isLoading? const Padding(padding: EdgeInsets.all(Dimensions.paddingSizeDefault),
                    child: Center(child: CircularProgressIndicator())):

                Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
                    child: CustomButton(onTap: (){

                      String institute = instituteTitleController.text.trim();

                      if(institute.isEmpty){
                        showCustomSnackBar("institute_is_empty".tr);
                      }

                      else{

                      }
                    }, text: "confirm".tr))
              ],),
            );
          }
      ),
    );
  }
}
