
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/common/widget/custom_button.dart';
import 'package:mighty_school/common/widget/custom_image.dart';
import 'package:mighty_school/common/widget/custom_snackbar.dart';
import 'package:mighty_school/common/widget/custom_text_field.dart';
import 'package:mighty_school/common/widget/custom_title.dart';
import 'package:mighty_school/feature/master_configuration/employee/controller/employee_controller.dart';
import 'package:mighty_school/feature/master_configuration/employee/presentation/widgets/employee_dropdown.dart';
import 'package:mighty_school/feature/hrm/leave_request/controller/leave_request_controller.dart';
import 'package:mighty_school/feature/hrm/leave_request/domain/models/leave_model.dart';
import 'package:mighty_school/feature/hrm/leave_request/domain/models/leave_request_body.dart';
import 'package:mighty_school/feature/hrm/leave_type/controller/leave_type_controller.dart';
import 'package:mighty_school/feature/hrm/leave_type/presentation/widgets/leave_type_dropdown.dart';
import 'package:mighty_school/helper/date_converter.dart';
import 'package:mighty_school/util/dimensions.dart';

class CreateNewLeaveRequestScreen extends StatefulWidget {
  final LeaveItem? leaveItem;
  const CreateNewLeaveRequestScreen({super.key, this.leaveItem});

  @override
  State<CreateNewLeaveRequestScreen> createState() => _CreateNewLeaveRequestScreenState();
}

class _CreateNewLeaveRequestScreenState extends State<CreateNewLeaveRequestScreen> {
  TextEditingController descriptionController = TextEditingController();


   bool update = false;
  @override
  void initState() {
    Get.find<EmployeeController>().getEmployeeList(1);
    Get.find<LeaveTypeController>().getLeaveTypeList(1);
    if(widget.leaveItem != null){
      update = true;

    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: CustomAppBar(title: "add_new_leave_request".tr,),
      body: CustomWebScrollView(slivers: [
        SliverToBoxAdapter(child: Column(children: [
          Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
            child: GetBuilder<LeaveRequestController>(
                builder: (leaveRequestController) {
                  return Column(mainAxisSize: MainAxisSize.min, children: [


                    const CustomTitle(title: "employee"),
                    GetBuilder<EmployeeController>(
                        builder: (employeeController) {
                          return Padding(padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: EmployeeDropdown(width: Get.width, title: "select_employee".tr,
                              items: employeeController.employeeModel?.data?.data??[],
                              selectedValue: leaveRequestController.selectEmployeeItem,
                              onChanged: (val){
                                leaveRequestController.selectEmployee(val!);
                              },
                            ),);
                        }
                    ),

                    const CustomTitle(title: "leave_type"),
                    GetBuilder<LeaveTypeController>(
                        builder: (leaveTypeController) {
                          return Padding(padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: LeaveTypeDropdown(width: Get.width, title: "select_type".tr,
                              items: leaveTypeController.leaveTypeModel?.data?.data??[],
                              selectedValue: leaveRequestController.selectLeaveTypeItem,
                              onChanged: (val){
                                leaveRequestController.setSelectLeaveType(val!);
                              },
                            ),);
                        }
                    ),

                    Row(children: [
                      Expanded(child: InkWell(onTap: ()=> leaveRequestController.setSelectDate(context, fromDate: true),
                          child: CustomTextField(title: "from_date".tr,
                              isEnabled : false,
                              hintText: DateConverter.quotationDate(leaveRequestController.selectedDate))),
                      ),

                      const SizedBox(width: 10,),
                      Expanded(child: InkWell(onTap: ()=> leaveRequestController.setSelectDate(context),
                          child: CustomTextField(title: "to_date".tr,
                              isEnabled : false,
                              hintText: DateConverter.quotationDate(leaveRequestController.selectedToDate))),
                      ),
                    ],
                    ),



                    CustomTextField(hintText: "description".tr,
                      title: "description".tr,
                      controller: descriptionController,),

                    const SizedBox(height: 20),

                    Align(alignment: Alignment.center, child: Stack(children: [
                      ClipRRect(borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
                          child: leaveRequestController.thumbnail != null ?  Image.file(File(leaveRequestController.thumbnail!.path),
                            width: 150, height: 120, fit: BoxFit.cover,) :
                          CustomImage(image: "${widget.leaveItem?.evidence}",  width: 150, height: 120, fit: BoxFit.cover,)),


                      Positioned(bottom: 0, right: 0, top: 0, left: 0,
                          child: InkWell(onTap: () => leaveRequestController.pickImage(),
                              child: Container(decoration: BoxDecoration(color: Colors.black.withValues(alpha: 0.3),
                                  borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
                                  border: Border.all(width: 1, color: Theme.of(context).primaryColor)),
                                  child: Container(margin: const EdgeInsets.all(25),
                                      decoration: BoxDecoration(border: Border.all(width: 2, color: Colors.white), shape: BoxShape.circle),
                                      child: const Icon(Icons.camera_alt, color: Colors.white)))))])),


                    leaveRequestController.isLoading? const Center(child: CircularProgressIndicator()):
                    Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
                        child: CustomButton(onTap: (){
                          String description = descriptionController.text.trim();
                          int? userId = leaveRequestController.selectEmployeeItem?.id;
                          int? leaveTypeId = leaveRequestController.selectLeaveTypeItem?.id;
                          String fromDate = leaveRequestController.formatedFromDate;
                          String toDate = leaveRequestController.formatedToDate;

                          if(userId == null){
                          showCustomSnackBar("user_is_empty".tr);
                          }
                          else if(leaveTypeId == null){
                            showCustomSnackBar("leave_type_is_empty".tr);
                          }
                          else if(fromDate.isEmpty){
                            showCustomSnackBar("from_date_is_empty".tr);
                          }
                          else if(toDate.isEmpty){
                            showCustomSnackBar("to_date_is_empty".tr);
                          }

                          else if(description.isEmpty){
                            showCustomSnackBar("description_is_empty".tr);
                          }

                          else{
                            LeaveRequestBody leaveRequestBody = LeaveRequestBody(
                              userId: userId,
                              leaveTypeId: leaveTypeId,
                              startDate: fromDate,
                              endDate: toDate,
                              approvalStatus: "pending",
                              notes: description);
                            if(update){
                              leaveRequestController.updateLeaveRequest(leaveRequestBody, widget.leaveItem!.id!);
                            }else{
                              leaveRequestController.createNewLeaveRequest(leaveRequestBody);
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
