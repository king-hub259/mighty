import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_button.dart';
import 'package:mighty_school/common/widget/custom_contaner.dart';
import 'package:mighty_school/common/widget/custom_snackbar.dart';
import 'package:mighty_school/common/widget/custom_text_field.dart';
import 'package:mighty_school/common/widget/custom_title.dart';
import 'package:mighty_school/feature/institute/controller/institute_controller.dart';
import 'package:mighty_school/feature/institute/domain/models/institute_body_model.dart';
import 'package:mighty_school/feature/institute/presentation/widgets/select_institute_image_widget.dart';
import 'package:mighty_school/feature/institute/presentation/widgets/select_user_image_widget.dart';
import 'package:mighty_school/helper/responsive_helper.dart';
import 'package:mighty_school/util/app_constants.dart';
import 'package:mighty_school/util/dimensions.dart';


class ApplyForInstituteWidget extends StatefulWidget {
  const ApplyForInstituteWidget({super.key});

  @override
  State<ApplyForInstituteWidget> createState() => _ApplyForInstituteWidgetState();
}

class _ApplyForInstituteWidgetState extends State<ApplyForInstituteWidget> {
  TextEditingController instituteNameController = TextEditingController();
  TextEditingController instituteEmailController = TextEditingController();
  TextEditingController institutePhoneController = TextEditingController();
  TextEditingController instituteDomainController = TextEditingController();
  TextEditingController instituteTypeController = TextEditingController();
  TextEditingController instituteAddressController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
      child: ResponsiveHelper.isDesktop(context)?
      CustomContainer(showShadow: false, horizontalPadding: Dimensions.paddingSizeLarge, verticalPadding: Dimensions.paddingSizeLarge,
        child: Column(spacing: Dimensions.paddingSizeDefault, mainAxisSize: MainAxisSize.min,children: [
          CustomTitle(title: "apply_for_enroll".tr, webTitle: true,leftPadding: 0, widget: IconButton(onPressed: (){
            Get.back();
          }, icon: const Icon(Icons.clear)),),
          CustomContainer(child: Column(children: [
            Row(spacing: Dimensions.paddingSizeDefault, children: [

              Expanded(child: CustomTextField(hintText: "institute_name".tr, title: "institute_name".tr, controller: instituteNameController)),
              Expanded(child: CustomTextField(hintText: "institute_email".tr, title: "institute_email".tr, controller: instituteEmailController),),
            ],),

            Row(spacing: Dimensions.paddingSizeDefault, children: [
              Expanded(child: CustomTextField(hintText: "institute_phone".tr, title: "institute_phone".tr, controller: institutePhoneController,
                  inputFormatters: [AppConstants.phoneNumberFormat])),
              Expanded(child: CustomTextField(hintText: "institute_domain".tr, title: "institute_domain".tr, controller: instituteDomainController)),
            ],),

            Row(spacing: Dimensions.paddingSizeDefault, children: [
              Expanded(child: CustomTextField(hintText: "institute_type".tr, title: "institute_type".tr, controller: instituteTypeController)),
              Expanded(child: CustomTextField(hintText: "institute_address".tr, title: "institute_address".tr, controller: instituteAddressController)),
            ],),

          ])),

          CustomContainer(child: Column(children: [
            Row(spacing: Dimensions.paddingSizeDefault, children: [
              Expanded(child:  CustomTextField(hintText: "user_name".tr, title: "user_name".tr, controller: userNameController),),
              Expanded(child: CustomTextField(hintText: "email".tr, title: "email".tr, controller: emailController),),
            ],),



            Row(spacing: Dimensions.paddingSizeDefault, children: [
              Expanded(child:  CustomTextField(hintText: "phone".tr, title: "phone".tr, controller: phoneController,
                  inputFormatters: [AppConstants.phoneNumberFormat])),
              Expanded(child:  CustomTextField(hintText: "password".tr, title: "password".tr, controller: passwordController, isPassword: true),),
              Expanded(child:   CustomTextField(hintText: "confirm_password".tr, isPassword: true,
                  title: "confirm_password".tr, controller: confirmPasswordController),),
            ],),


          ])),


          const Row(spacing : Dimensions.paddingSizeDefault, children: [
            SelectInstituteImageWidget(),
            SelectUserImageWidget()
          ]),

          Align(alignment: Alignment.centerRight,
            child: GetBuilder<InstituteController>(
                builder: (instituteController) {
                  return instituteController.isLoading? const SizedBox(width: 120,child: Center(child: CircularProgressIndicator())) : SizedBox(width: 120,
                    child: CustomButton(text: "apply".tr, onTap: () {
                      String instituteName = instituteNameController.text.trim();
                      String instituteEmail = instituteEmailController.text.trim();
                      String institutePhone = institutePhoneController.text.trim();
                      String instituteDomain = instituteDomainController.text.trim();
                      String instituteType = instituteTypeController.text.trim();
                      String instituteAddress = instituteAddressController.text.trim();
                      String userName = userNameController.text.trim();
                      String email = emailController.text.trim();
                      String phone = phoneController.text.trim();
                      String password = passwordController.text.trim();
                      String confirmPassword = confirmPasswordController.text.trim();

                      if(instituteName.isEmpty){
                        showCustomSnackBar("institute_name_is_required".tr);
                      }else if(instituteEmail.isEmpty){
                        showCustomSnackBar("institute_email_is_required".tr);

                      }
                      else if(!GetUtils.isEmail(instituteEmail)) {
                        showCustomSnackBar("invalid_institute_email".tr);
                      }
                      else if(institutePhone.isEmpty){
                        showCustomSnackBar("institute_phone_is_required".tr);
                      }

                      else if(instituteDomain.isEmpty){
                        showCustomSnackBar("domain_is_required".tr);
                      }

                      else if(userName.isEmpty){
                        showCustomSnackBar("user_name_is_required".tr);
                      }
                      else if(email.isEmpty){
                        showCustomSnackBar("email_is_required".tr);
                      }
                      else if(!GetUtils.isEmail(email)) {
                        showCustomSnackBar("invalid_email".tr);
                      }
                      else if(phone.isEmpty){
                        showCustomSnackBar("phone_is_required".tr);
                      }
                      else if(password.isEmpty){
                        showCustomSnackBar("password_is_required".tr);
                      }
                      else if(password.length < 8){
                        showCustomSnackBar("password_must_be_at_least_8_characters".tr);
                      }
                      else if(confirmPassword.isEmpty){
                        showCustomSnackBar("confirm_password_is_required".tr);
                      }
                      else if(password != confirmPassword){
                        showCustomSnackBar("password_and_confirm_password_does_not_match".tr);
                      }
                      else {
                        InstituteBodyModel instituteBodyModel = InstituteBodyModel(
                            instituteName: instituteName,
                            instituteEmail: instituteEmail,
                            institutePhone: institutePhone,
                            instituteDomain: instituteDomain,
                            instituteType: instituteType,
                            instituteAddress: instituteAddress,
                            userName: userName,
                            userEmail: email,
                            userPhone: phone,
                            password:  password,
                            passwordConfirmation: confirmPassword
                        );
                        instituteController.createInstitute(instituteBodyModel);

                      }
                    }),
                  );
                }
            ),
          ),

        ]),
      ):
      Column(spacing: Dimensions.paddingSizeDefault, children: [
        CustomTextField(hintText: "institute_name".tr, title: "institute_name".tr, controller: instituteNameController,),
        CustomTextField(hintText: "institute_email".tr, title: "institute_email".tr, controller: instituteEmailController),
        CustomTextField(hintText: "institute_phone".tr, title: "institute_phone".tr, controller: institutePhoneController),
        CustomTextField(hintText: "institute_domain".tr, title: "institute_domain".tr, controller: instituteDomainController),
        CustomTextField(hintText: "institute_type".tr, title: "institute_type".tr, controller: instituteTypeController),
        CustomTextField(hintText: "institute_address".tr, title: "institute_address".tr, controller: instituteAddressController),
        CustomTextField(hintText: "user_name".tr, title: "user_name".tr, controller: userNameController),
        CustomTextField(hintText: "email".tr, title: "email".tr, controller: emailController),
        CustomTextField(hintText: "phone".tr, title: "phone".tr, controller: phoneController),
        CustomTextField(hintText: "password".tr, title: "password".tr, controller: passwordController),
        CustomTextField(hintText: "confirm_password".tr, title: "confirm_password".tr, controller: confirmPasswordController),
        const Row(spacing : Dimensions.paddingSizeDefault, children: [
          SelectInstituteImageWidget(),
          SelectUserImageWidget()
        ]),

        GetBuilder<InstituteController>(
            builder: (instituteController) {
              return instituteController.isLoading? const Center(child: CircularProgressIndicator()) : CustomButton(text: "apply".tr, onTap: () {
                String instituteName = instituteNameController.text.trim();
                String instituteEmail = instituteEmailController.text.trim();
                String institutePhone = institutePhoneController.text.trim();
                String instituteDomain = instituteDomainController.text.trim();
                String instituteType = instituteTypeController.text.trim();
                String instituteAddress = instituteAddressController.text.trim();
                String userName = userNameController.text.trim();
                String email = emailController.text.trim();
                String phone = phoneController.text.trim();
                String password = passwordController.text.trim();
                String confirmPassword = confirmPasswordController.text.trim();

                if(instituteName.isEmpty){
                  showCustomSnackBar("institute_name_is_required".tr);
                }else if(instituteEmail.isEmpty){
                  showCustomSnackBar("institute_email_is_required".tr);

                }
                else if(!GetUtils.isEmail(instituteEmail)) {
                  showCustomSnackBar("invalid_email".tr);
                }
                else if(institutePhone.isEmpty){
                  showCustomSnackBar("institute_phone_is_required".tr);
                }

                else if(userName.isEmpty){
                  showCustomSnackBar("user_name_is_required".tr);
                }
                else if(email.isEmpty){
                  showCustomSnackBar("email_is_required".tr);
                }
                else if(!GetUtils.isEmail(email)) {
                  showCustomSnackBar("invalid_email".tr);
                }
                else if(phone.isEmpty){
                  showCustomSnackBar("phone_is_required".tr);
                }
                else if(password.isEmpty){
                  showCustomSnackBar("password_is_required".tr);
                }
                else if(password.length < 8){
                  showCustomSnackBar("password_must_be_at_least_8_characters".tr);
                }
                else if(confirmPassword.isEmpty){
                  showCustomSnackBar("confirm_password_is_required".tr);
                }
                else if(password != confirmPassword){
                  showCustomSnackBar("password_and_confirm_password_does_not_match".tr);
                }
                else {
                  InstituteBodyModel instituteBodyModel = InstituteBodyModel(
                      instituteName: instituteName,
                      instituteEmail: instituteEmail,
                      institutePhone: institutePhone,
                      instituteDomain: instituteDomain,
                      instituteType: instituteType,
                      instituteAddress: instituteAddress,
                      userName: userName,
                      userEmail: email,
                      userPhone: phone,
                      password:  password,
                      passwordConfirmation: confirmPassword
                  );
                  instituteController.createInstitute(instituteBodyModel);

                }
              });
            }
        ),

      ]),
    );
  }
}
