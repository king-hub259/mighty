import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_button.dart';
import 'package:mighty_school/common/widget/custom_dropdown.dart';
import 'package:mighty_school/common/widget/custom_snackbar.dart';
import 'package:mighty_school/common/widget/custom_text_field.dart';
import 'package:mighty_school/common/widget/custom_title.dart';
import 'package:mighty_school/feature/academic_configuration/picklist/controller/picklist_controller.dart';
import 'package:mighty_school/feature/academic_configuration/picklist/domain/models/pick_list_model.dart';
import 'package:mighty_school/helper/responsive_helper.dart';
import 'package:mighty_school/util/dimensions.dart';

class CreateNewPickListScreen extends StatefulWidget {
  final PickListItem? pickListItem;
  const CreateNewPickListScreen({super.key, this.pickListItem});

  @override
  State<CreateNewPickListScreen> createState() => _CreateNewPickListScreenState();
}

class _CreateNewPickListScreenState extends State<CreateNewPickListScreen> {
  TextEditingController descriptionController = TextEditingController();
   bool update = false;
  @override
  void initState() {
    if(widget.pickListItem != null){
      update = true;
      descriptionController.text = widget.pickListItem?.value??'';
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Dialog(insetPadding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall)),
      child: SizedBox(width: ResponsiveHelper.isDesktop(context)? 500 : Get.width,
        child: Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
          child: GetBuilder<PickListController>(
            builder: (pickListController) {
              return Column(mainAxisSize: MainAxisSize.min, children: [
                const Padding(padding: EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
                  child: CustomTitle(title: "add_new_picklist")),

                const CustomTitle(title: "types", isRequired: true,),
                Padding(padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: CustomDropdown(width: Get.width, title: "types".tr,
                    items: pickListController.picklistTypes,
                    selectedValue: pickListController.selectedPicklistType,
                    onChanged: (val){
                      pickListController.changePicklistType(val!);
                    },
                  ),),

                CustomTextField(title: "value".tr,
                  controller: descriptionController,
                  hintText: "enter_value".tr,),


                pickListController.isLoading? const Padding(padding: EdgeInsets.all(Dimensions.paddingSizeDefault),
                  child: Center(child: CircularProgressIndicator())):

                Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
                  child: CustomButton(onTap: (){

                    String type = pickListController.selectedPicklistType;
                    String description = descriptionController.text.trim();
                    if(description.isEmpty){
                      showCustomSnackBar("priority_is_empty");
                    }else{
                      if(update){
                        pickListController.updatePickList(pickListController.selectedPicklistType, description, widget.pickListItem!.id!);
                      }else{
                        pickListController.createNewPickList(type, description);
                      }

                    }
                  }, text: update? "update".tr : "save".tr))
              ],);
            }
          ),
        ),
      ),
    );
  }
}
