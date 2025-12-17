import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_button.dart';
import 'package:mighty_school/common/widget/custom_snackbar.dart';
import 'package:mighty_school/common/widget/custom_text_field.dart';
import 'package:mighty_school/common/widget/custom_title.dart';
import 'package:mighty_school/feature/academic_configuration/group/controller/group_controller.dart';
import 'package:mighty_school/feature/academic_configuration/group/domain/model/group_model.dart';
import 'package:mighty_school/helper/responsive_helper.dart';
import 'package:mighty_school/util/dimensions.dart';

class CreateNewGroupDialog extends StatefulWidget {
  final GroupItem? groupItem;
  const CreateNewGroupDialog({super.key, this.groupItem});

  @override
  State<CreateNewGroupDialog> createState() => _CreateNewGroupDialogState();
}

class _CreateNewGroupDialogState extends State<CreateNewGroupDialog> {TextEditingController nameController = TextEditingController();
TextEditingController serialController = TextEditingController();
bool update = false;
@override
void initState() {
  if(widget.groupItem != null){
    update = true;
    nameController.text = widget.groupItem?.groupName??'';

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
          child: GetBuilder<GroupController>(
              builder: (groupController) {
                return Column(mainAxisSize: MainAxisSize.min, children: [
                  Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
                      child: CustomTitle(title: update?  "update_period".tr : "add_new_period".tr)),

                  CustomTextField(title: "name".tr,
                    controller: nameController,
                    hintText: "enter_name".tr,),




                  groupController.isLoading? const Padding(padding: EdgeInsets.all(Dimensions.paddingSizeDefault),
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
                            groupController.updateGroup(name, widget.groupItem!.id!);
                          }else{
                            groupController.addNewGroup(name);
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
