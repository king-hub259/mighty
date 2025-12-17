import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_button.dart';
import 'package:mighty_school/common/widget/custom_contaner.dart';
import 'package:mighty_school/common/widget/custom_snackbar.dart';
import 'package:mighty_school/common/widget/custom_text_field.dart';
import 'package:mighty_school/feature/master_configuration/role/controller/role_controller.dart';
import 'package:mighty_school/feature/master_configuration/role/domain/models/permission_model.dart';
import 'package:mighty_school/feature/master_configuration/role/domain/models/role_body.dart';
import 'package:mighty_school/feature/master_configuration/role/domain/models/role_model.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';

class CreateNewRoleWidget extends StatefulWidget {
  final RoleItem? roleItem;
  const CreateNewRoleWidget({super.key, this.roleItem});

  @override
  State<CreateNewRoleWidget> createState() => _CreateNewRoleWidgetState();
}

class _CreateNewRoleWidgetState extends State<CreateNewRoleWidget> {
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  bool update = false;
  @override
  void initState() {
    Get.find<RoleController>().getPermissionListList().then((val){
      if(widget.roleItem != null){
        update = true;
        nameController.text = widget.roleItem?.name??'';
        descriptionController.text = widget.roleItem?.description??'';
        if(widget.roleItem!.permissions != null && widget.roleItem!.permissions!.isNotEmpty){
          for(Permissions permissions in widget.roleItem!.permissions!){
            Get.find<RoleController>().selectPermission(PermissionItem(id: permissions.id, name: permissions.name, isSelected: true));
          }
        }

      }
    });

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder<RoleController>(
        builder: (roleController) {
          return Padding(
            padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
            child: Column(mainAxisSize: MainAxisSize.min, children: [



              CustomTextField(title: "role_name".tr,
                controller: nameController,
                hintText: "enter_name".tr,),

              CustomTextField(title: "description".tr,
                controller: descriptionController,
                hintText: "enter_description".tr,),


              ListView.builder(
                shrinkWrap: true,
                itemCount: roleController.permissionList.length,
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {

                  return Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: CustomContainer(horizontalPadding: 0, verticalPadding: 0,

                      child: ExpansionTile(
                        title: Text("${roleController.permissionList[index]?.capitalize} Permission", maxLines: 1, overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.start, style: textRegular.copyWith(fontSize: Dimensions.fontSizeLarge)),
                        children: [
                          GridView.builder(physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            itemCount: roleController.permissionItemList[index].length,
                            itemBuilder: (context, i) {
                              return Row(
                                children: [
                                  Checkbox(value: roleController.permissionItemList[index][i].isSelected,
                                      onChanged: (val){
                                        roleController.selectPermission(roleController.permissionItemList[index][i]);
                                      }),
                                  Text("${roleController.permissionItemList[index][i].name}", style: textRegular,),
                                ],
                              );
                            }, gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                childAspectRatio: 4,
                                crossAxisCount: 2),
                          ),],
                      ),
                    ),
                  );
                },
              ),





              Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
                  child: CustomButton(onTap: (){
                    String name = nameController.text.trim();
                    if(name.isEmpty){
                      showCustomSnackBar("name_is_empty".tr);
                    }else if(roleController.selectedPermissionIds.isEmpty){
                      showCustomSnackBar("select_permission".tr);
                    }else{
                      RoleBody roleBody =RoleBody(
                        name: name,
                        description: descriptionController.text,
                        permissions: roleController.selectedPermissionIds,
                      );
                      if(update){
                        roleController.updateRole(roleBody, widget.roleItem!.id!);
                      }else{
                        roleController.addNewRole(roleBody);
                      }

                    }
                  }, text: update? "update".tr : "submit".tr))
            ],),
          );
        }
    );
  }
}
