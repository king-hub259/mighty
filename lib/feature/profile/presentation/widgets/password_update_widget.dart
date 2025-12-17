import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_button.dart';
import 'package:mighty_school/common/widget/custom_contaner.dart';
import 'package:mighty_school/common/widget/custom_snackbar.dart';
import 'package:mighty_school/common/widget/custom_text_field.dart';
import 'package:mighty_school/common/widget/custom_title.dart';
import 'package:mighty_school/feature/profile/logic/profile_controller.dart';
import 'package:mighty_school/util/dimensions.dart';

class PasswordUpdateWidget extends StatefulWidget {
  const PasswordUpdateWidget({super.key});

  @override
  State<PasswordUpdateWidget> createState() => _PasswordUpdateWidgetState();
}

class _PasswordUpdateWidgetState extends State<PasswordUpdateWidget> {
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return  GetBuilder<ProfileController>(
      builder: (profileController) {
        return CustomContainer(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const CustomTitle(title: "update_password"),
          const SizedBox(height: Dimensions.paddingSizeExtraSmall),
          const CustomSubTitle(title: "update_password_info"),

          CustomTextField(title: "current_password".tr,
              controller: oldPasswordController,
              hintText: "•••••••••••••••"),

          CustomTextField(title: "new_password".tr,
              controller: newPasswordController,
              hintText: "•••••••••••••••"),

          const SizedBox(height: Dimensions.paddingSizeSmall),

          CustomTextField(title: "confirm_password".tr,
              controller: confirmPasswordController,
              hintText: "•••••••••••••••"),
          const SizedBox(height: Dimensions.paddingSizeDefault),

          SizedBox(width: 100, child: CustomButton(borderRadius: 5,
              onTap: (){
            String password = oldPasswordController.text.trim();
            String newPassword = newPasswordController.text.trim();
            String confirmPassword = confirmPasswordController.text.trim();
            if(password.isEmpty){
              showCustomSnackBar("old_password_is_empty".tr);
            }
            else if(newPassword.isEmpty){
              showCustomSnackBar("new_password_is_empty".tr);
            }
            else if(confirmPassword.isEmpty){
                showCustomSnackBar("confirm_password_is_empty".tr);
            }
            else if(newPassword!= confirmPassword){
              showCustomSnackBar("password_and_confirm_password_not_match".tr);
            }else{
              profileController.changePassword(password, newPassword);
            }

              }, text: "submit".tr))

        ],),);
      }
    );
  }
}
