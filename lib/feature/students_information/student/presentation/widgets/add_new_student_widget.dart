import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_button.dart';
import 'package:mighty_school/common/widget/custom_snackbar.dart';
import 'package:mighty_school/common/widget/custom_text_field.dart';
import 'package:mighty_school/common/widget/custom_title.dart';
import 'package:mighty_school/common/widget/select_blood_group_section_widget.dart';
import 'package:mighty_school/common/widget/select_gender_section_widget.dart';
import 'package:mighty_school/common/widget/select_profile_image_widget.dart';
import 'package:mighty_school/common/widget/select_religion_section_widget.dart';
import 'package:mighty_school/feature/academic_configuration/class/controller/class_controller.dart';
import 'package:mighty_school/feature/academic_configuration/class/presentation/widgets/select_class_widget.dart';
import 'package:mighty_school/feature/academic_configuration/group/controller/group_controller.dart';
import 'package:mighty_school/feature/academic_configuration/group/presentation/widgets/select_group_widget.dart';
import 'package:mighty_school/feature/academic_configuration/section/controller/section_controller.dart';
import 'package:mighty_school/feature/academic_configuration/section/presentation/widgets/select_section_widget.dart';
import 'package:mighty_school/feature/students_information/student/controller/student_controller.dart';
import 'package:mighty_school/feature/students_information/student/domain/model/student_body.dart';
import 'package:mighty_school/util/dimensions.dart';

class AddNewStudentWidget extends StatefulWidget {
  const AddNewStudentWidget({super.key});

  @override
  State<AddNewStudentWidget> createState() => _AddNewStudentWidgetState();
}

class _AddNewStudentWidgetState extends State<AddNewStudentWidget> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController fathersNameController = TextEditingController();
  TextEditingController mothersNameController = TextEditingController();
  TextEditingController registrationNumberController = TextEditingController();
  TextEditingController rollNumberController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<StudentController>(
        builder: (studentController) {
          return Padding(
            padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
            child: Column(children: [
              CustomTextField(hintText: "first_name".tr, title: "first_name".tr,
                  controller: firstNameController),

              CustomTextField(hintText: "last_name".tr, title: "last_name".tr,
                  controller: lastNameController),


              CustomTextField(hintText: "fathers_name".tr, title: "fathers_name".tr,
                  controller: fathersNameController),

              CustomTextField(hintText: "mothers_name".tr, title: "mothers_name".tr,
                  controller: mothersNameController),


              const Row(
                children: [
                  Expanded(child: SelectClassWidget()),
                  SizedBox(width: Dimensions.paddingSizeDefault,),
                  Expanded(child: SelectGroupWidget()),
                ],
              ),

              const SelectSectionWidget(),


              const SelectGenderSectionWidget(),

              CustomTextField(hintText: "registration_number".tr, title: "registration_number".tr,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  controller: registrationNumberController),

              CustomTextField(hintText: "roll_number".tr, title: "roll_number".tr,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  controller: rollNumberController),



              const SelectBloodGroupSectionWidget(),


              const SelectReligionSectionWidget(),


              CustomTextField(hintText: "address".tr, title: "address".tr,
                  controller: addressController),

              CustomTextField(hintText: "email".tr, title: "email".tr,
                  controller: emailController),

              CustomTextField(hintText: "phone_number".tr, title: "phone_number".tr,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  controller: phoneNumberController),

              CustomTextField(hintText: "password".tr, title: "password".tr,
                  controller: passwordController,
                  isPassword: true),

              CustomTextField(hintText: "confirm_password".tr, title: "confirm_password".tr,
                  controller: confirmPasswordController,
                  isPassword: true),


              const CustomTitle(title: "image",),

              const SelectProfileImageWidget(),


              const SizedBox(height: Dimensions.paddingSizeDefault),

              studentController.isLoading? const Center(child: CircularProgressIndicator()):
              CustomButton(onTap: (){
                String firstName = firstNameController.text.trim();
                String lastName = lastNameController.text.trim();
                String fathersName = fathersNameController.text.trim();
                String mothersName = mothersNameController.text.trim();
                String registrationNumber = registrationNumberController.text.trim();
                String rollNumber = rollNumberController.text.trim();
                String address = addressController.text.trim();
                String email = emailController.text.trim();
                String phoneNumber = phoneNumberController.text.trim();
                String password = passwordController.text.trim();
                String confirmPassword = confirmPasswordController.text.trim();
                int? classId = Get.find<ClassController>().selectedClassItem?.id;
                int? groupId = Get.find<GroupController>().groupItem?.id;
                int? sectionId = Get.find<SectionController>().selectedSectionItem?.id;
                String gender = studentController.selectedGender;
                String bloodGroup = studentController.selectedBloodGroup;
                String religion = studentController.selectedReligion;



                if(firstName.isEmpty){
                  showCustomSnackBar("firstName_is_empty".tr);
                }
                else if(classId == null){
                  showCustomSnackBar("class_id_is_empty".tr);
                }
                else if(groupId == null){
                  showCustomSnackBar("group_id_is_empty".tr);
                }
                else if(sectionId == null){
                  showCustomSnackBar("section_id_is_empty".tr);
                }
                else if(registrationNumber.isEmpty){
                  showCustomSnackBar("registration_number_is_empty".tr);
                }
                else if(rollNumber.isEmpty){
                  showCustomSnackBar("roll_number_is_empty".tr);
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
                  StudentBody studentBody =  StudentBody(
                    firstName: firstName,
                    lastName: lastName,
                    fatherName: fathersName,
                    motherName: mothersName,
                    registerNo: registrationNumber,
                    roll: rollNumber,
                    address: address,
                    email: email,
                    phone: phoneNumber,
                    password:  password,
                    passwordConfirmation: confirmPassword,
                    classId: classId.toString(),
                    group: groupId.toString(),
                    sectionId: sectionId.toString(),
                    gender: gender,
                    bloodGroup: bloodGroup,
                    religion: religion,
                  );
                  studentController.addNewStudent(studentBody);
                }

              }, text: "add_new_student".tr)


            ],),
          );
        }
    );
  }
}
