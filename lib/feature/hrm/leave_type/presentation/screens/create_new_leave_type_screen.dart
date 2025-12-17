
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/common/widget/custom_button.dart';
import 'package:mighty_school/common/widget/custom_snackbar.dart';
import 'package:mighty_school/common/widget/custom_text_field.dart';
import 'package:mighty_school/feature/hrm/leave_type/controller/leave_type_controller.dart';
import 'package:mighty_school/feature/hrm/leave_type/domain/models/leave_type_model.dart';
import 'package:mighty_school/util/dimensions.dart';

class CreateNewLeaveTypeScreen extends StatefulWidget {
  final LeaveTypeItem? leaveTypeItem;
  const CreateNewLeaveTypeScreen({super.key, this.leaveTypeItem});

  @override
  State<CreateNewLeaveTypeScreen> createState() => _CreateNewLeaveTypeScreenState();
}

class _CreateNewLeaveTypeScreenState extends State<CreateNewLeaveTypeScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();


   bool update = false;
  @override
  void initState() {
    if(widget.leaveTypeItem != null){
      update = true;
      titleController.text = widget.leaveTypeItem!.name??'';
      descriptionController.text = widget.leaveTypeItem!.description??'';
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: CustomAppBar(title: "add_new_leave_type".tr,),
      body: CustomWebScrollView(slivers: [
        SliverToBoxAdapter(child: Column(children: [
          Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
            child: GetBuilder<LeaveTypeController>(
                builder: (leaveTypeController) {
                  return Column(mainAxisSize: MainAxisSize.min, children: [
                    

                    CustomTextField(hintText: "enter_name".tr,
                      title: "leave_type_title".tr,
                      controller: titleController,),


                    CustomTextField(hintText: "description".tr,
                      title: "description".tr,
                      controller: descriptionController,),

                    
                    leaveTypeController.isLoading? const Center(child: CircularProgressIndicator()):
                    Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
                        child: CustomButton(onTap: (){
                          String title = titleController.text.trim();
                          String description = descriptionController.text.trim();
                          if(title.isEmpty){
                            showCustomSnackBar("name_is_empty".tr);
                          }
                          else{
                            if(update){
                              leaveTypeController.updateLeaveType(title,description, widget.leaveTypeItem!.id!);
                            }else{
                              leaveTypeController.createNewLeaveType(title, description);
                            }
                          }
                        }, text: update? "update".tr : "submit".tr))
                  ],);
                }
            ),
          )
        ],),)
      ],),
    );
  }
}
