import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/common/widget/custom_text_field.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/images.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: CustomAppBar(title: "${"reset_password".tr} "),

      body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault,vertical: Dimensions.paddingSizeLarge),
          children: [

            const SizedBox(height: Dimensions.paddingSize,),
            CustomTextField(
              title: "old_password".tr,hintText: "enter_old_password".tr,
              filled: true, showBorder: false,
              isPassword: true,
              prefixIcon: Images.lockIconSvg,
              prefixIconSize: 20,
              prefixIconColor: Theme.of(context).colorScheme.onSecondary,
              fillColor: Theme.of(context).hintColor.withValues(alpha: 0.1),
            ),

            const SizedBox(height: Dimensions.paddingSize,),
            CustomTextField(
              title: "newPassword".tr,hintText: "newPassword".tr,
              filled: true, showBorder: false,
              isPassword: true,
              prefixIcon: Images.lockIconSvg,
              prefixIconSize: 20,
              prefixIconColor: Theme.of(context).colorScheme.onSecondary,
              fillColor: Theme.of(context).hintColor.withValues(alpha: 0.1),
            ),

            const SizedBox(height: Dimensions.paddingSize,),
            CustomTextField(
              title: "confirmNewPassword".tr,hintText: "confirmNewPassword".tr,
              filled: true, showBorder: false,
              isPassword: true,
              prefixIcon: Images.lockIconSvg,
              prefixIconSize: 20,
              prefixIconColor: Theme.of(context).colorScheme.onSecondary,
              fillColor: Theme.of(context).hintColor.withValues(alpha: 0.1),
            ),

            const SizedBox(height: Dimensions.paddingSize,)]),
    );
  }
}
