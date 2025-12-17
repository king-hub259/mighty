import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/controller/datepicker_controller.dart';
import 'package:mighty_school/common/widget/custom_button.dart';
import 'package:mighty_school/common/widget/custom_contaner.dart';
import 'package:mighty_school/common/widget/custom_pick_image_widget.dart';
import 'package:mighty_school/common/widget/custom_snackbar.dart';
import 'package:mighty_school/common/widget/custom_text_field.dart';
import 'package:mighty_school/common/widget/custom_title.dart';
import 'package:mighty_school/common/widget/date_selection_widget.dart';
import 'package:mighty_school/common/widget/select_blood_group_section_widget.dart';
import 'package:mighty_school/common/widget/select_gender_section_widget.dart';
import 'package:mighty_school/common/widget/select_religion_section_widget.dart';
import 'package:mighty_school/feature/academic_configuration/department/controller/department_controller.dart';
import 'package:mighty_school/feature/academic_configuration/department/presentation/widgets/department_selection_widget.dart';
import 'package:mighty_school/feature/academic_configuration/picklist/controller/picklist_controller.dart';
import 'package:mighty_school/feature/academic_configuration/picklist/presentation/widgets/picklist_selection_widget.dart';
import 'package:mighty_school/feature/staff_information/staff/controller/staff_controller.dart';
import 'package:mighty_school/feature/students_information/student/controller/student_controller.dart';
import 'package:mighty_school/feature/staff_information/teacher/controller/teacher_controller.dart';
import 'package:mighty_school/feature/staff_information/teacher/domain/model/teacher_body.dart';
import 'package:mighty_school/util/app_constants.dart';
import 'package:mighty_school/util/dimensions.dart';
import '../../domain/model/teacher_model.dart';

class AddNewTeacherWidget extends StatefulWidget {
  final bool fromStaff;
  final TeacherItem? teacherItem;
  const AddNewTeacherWidget({super.key, required this.fromStaff, this.teacherItem});

  @override
  State<AddNewTeacherWidget> createState() => _AddNewTeacherWidgetState();
}

class _AddNewTeacherWidgetState extends State<AddNewTeacherWidget> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController serialController = TextEditingController();



  @override
  void initState() {
    nameController.text = widget.teacherItem?.name ?? '';
    emailController.text = widget.teacherItem?.email ?? '';
    phoneNumberController.text = widget.teacherItem?.phone ?? '';
    serialController.text = widget.teacherItem?.sl??'';


    super.initState();
  }




  @override
  Widget build(BuildContext context) {
    return GetBuilder<TeacherController>(builder: (teacherController) {
      return GetBuilder<StudentController>(builder: (commonController) {
        return GetBuilder<StaffController>(builder: (staffController) {
          return CustomContainer(
            child: SingleChildScrollView(
              child: Column(spacing: Dimensions.paddingSizeSmall, children: [

                Row(spacing: Dimensions.paddingSizeDefault, children: [
                  Expanded(child: CustomTextField(hintText: "name".tr, title: "name".tr,
                      controller: nameController)),

                  Expanded(child: CustomTextField(hintText: "serial".tr, title: "serial".tr,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      inputType: TextInputType.phone, controller: serialController))
                ]),

                const Row(spacing: Dimensions.paddingSizeDefault, children: [
                  Expanded(child: SelectPicklistWidget()),
                  Expanded(child: SelectDepartmentWidget()),
                ]),


                const Row(spacing: Dimensions.paddingSizeDefault, children: [
                  Expanded(child: SelectGenderSectionWidget()),
                  Expanded(child: SelectBloodGroupSectionWidget()),
                ]),

                const Row(spacing: Dimensions.paddingSizeDefault, children: [
                  Expanded(child: SelectReligionSectionWidget()),
                  Expanded(child: DateSelectionWidget()),
                ]),



                Row(spacing: Dimensions.paddingSizeDefault, children: [
                  Expanded(child: CustomTextField(hintText: "email".tr, title: "email".tr,
                      controller: emailController)),

                  Expanded(child: CustomTextField(hintText: "phone_number".tr, title: "phone_number".tr,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      inputType: TextInputType.phone,
                      controller: phoneNumberController),)
                ]),



                Row(spacing: Dimensions.paddingSizeDefault, children: [
                  Expanded(child: CustomTextField(hintText: "password".tr, title: "password".tr,
                      controller: passwordController, isPassword: true)),

                  Expanded(child:  CustomTextField(hintText: "confirm_password".tr, title: "confirm_password".tr,
                      controller: confirmPasswordController, isPassword: true),)
                ]),


                const CustomTitle(title: "image",),
                 CustomPickImageWidget(imageUrl: "${AppConstants.baseUrl}/storage/users/${widget.teacherItem?.image}",),
                // const SelectProfileImageWidget(),
                const SizedBox(height: Dimensions.paddingSizeDefault),


                (teacherController.isLoading || staffController.isLoading)? const Center(child: CircularProgressIndicator()):
                CustomButton(onTap: (){
                  String name = nameController.text.trim();
                  String? designation = Get.find<PickListController>().selectedPicklistItem?.value;
                  String email = emailController.text.trim();
                  String phoneNumber = phoneNumberController.text.trim();
                  String password = passwordController.text.trim();
                  String confirmPassword = confirmPasswordController.text.trim();
                  String gender = commonController.selectedGender;
                  String bloodGroup = commonController.selectedBloodGroup;
                  String religion = commonController.selectedReligion;
                  String serial = serialController.text.trim();
                  String joiningDate = Get.find<DatePickerController>().formatedDate;
                  int? departmentId = Get.find<DepartmentController>().selectedDepartmentItem?.id;


                  if(name.isEmpty){
                    showCustomSnackBar("name_is_empty".tr);
                  }
                  else if(phoneNumber.isEmpty){
                    showCustomSnackBar("phone_number_is_empty".tr);
                  }
                  else if(password.isEmpty){
                    showCustomSnackBar("password_is_empty".tr);
                  }
                  else if(password.length < 8){
                    showCustomSnackBar("password_should_be_at_least_8_characters".tr);
                  }
                  else if(confirmPassword.isEmpty){
                    showCustomSnackBar("confirm_password_is_empty".tr);
                  }
                  else if(password!= confirmPassword){
                    showCustomSnackBar("password_and_confirm_password_not_match".tr);
                  }
                  else{
                    TeacherBody teacherBody =  TeacherBody(
                      name: name,
                      designation: designation.toString(),
                      departmentId: departmentId.toString(),
                      gender: gender,
                      religion: religion,
                      blood: bloodGroup,
                      joiningDate: joiningDate,
                      sl: serial,
                      email: email,
                      phone: phoneNumber,
                      password:  password,
                      passwordConfirmation: confirmPassword,
                      sMethod: widget.teacherItem != null? "put":"post"
                    );
                    if(widget.fromStaff){
                      Get.find<StaffController>().addNewStaff(teacherBody);
                    }else{
                      if(widget.teacherItem != null){
                        teacherController.updateTeacher(teacherBody, widget.teacherItem!.id!);
                      }else {
                        teacherController.addNewTeacher(teacherBody);
                      }
                    }
                  }
                }, text: "add".tr)
              ],),
            ),
          );
        }
        );
      }
      );
    });
  }
}
