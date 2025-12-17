import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_button.dart';
import 'package:mighty_school/common/widget/custom_snackbar.dart';
import 'package:mighty_school/common/widget/custom_text_field.dart';
import 'package:mighty_school/common/widget/custom_title.dart';
import 'package:mighty_school/feature/academic_configuration/shift/controller/shift_controller.dart';
import 'package:mighty_school/feature/academic_configuration/shift/domain/models/shift_model.dart';
import 'package:mighty_school/helper/responsive_helper.dart';
import 'package:mighty_school/util/dimensions.dart';

class CreateNewShiftScreen extends StatefulWidget {
  final ShiftItem? shiftItem;
  const CreateNewShiftScreen({super.key, this.shiftItem});

  @override
  State<CreateNewShiftScreen> createState() => _CreateNewShiftScreenState();
}

class _CreateNewShiftScreenState extends State<CreateNewShiftScreen> {
  TextEditingController nameController = TextEditingController();
   bool update = false;
  @override
  void initState() {
    if(widget.shiftItem != null){
      update = true;
      nameController.text = widget.shiftItem?.name??'';
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
          child: GetBuilder<ShiftController>(
            builder: (shiftController) {
              return Column(mainAxisSize: MainAxisSize.min, children: [
                const Padding(padding: EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
                  child: CustomTitle(title: "add_new_shift")),

                CustomTextField(title: "name".tr,
                  controller: nameController,
                  hintText: "enter_name".tr,),



                shiftController.isLoading? const Padding(padding: EdgeInsets.all(Dimensions.paddingSizeDefault),
                  child: Center(child: CircularProgressIndicator())):

                Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
                  child: CustomButton(onTap: (){
                    String name = nameController.text.trim();
                    if(name.isEmpty){
                      showCustomSnackBar("name_is_empty");
                    }else{
                      if(update){
                        shiftController.updateShift(name, widget.shiftItem!.id!);
                      }else{
                        shiftController.createNewShift(name);
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
