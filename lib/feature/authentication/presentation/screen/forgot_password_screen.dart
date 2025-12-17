import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_button.dart';
import 'package:mighty_school/common/widget/custom_text_field.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/images.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(


      body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault,vertical: Dimensions.paddingSizeLarge),
          children: [
            CustomTextField(
              title: "email".tr,hintText: "email".tr,
              filled: true, showBorder: false,
              prefixIcon: Images.mailIconSvg,
              prefixIconColor: Theme.of(context).colorScheme.onSecondary,
              prefixIconSize: 16,
              fillColor: Theme.of(context).hintColor.withValues(alpha: 0.1),
            ),

          ]),

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault,vertical: Dimensions.paddingSizeLarge),
        child: CustomButton(onTap: (){},
            height: 45, text: 'continue'.tr),
      ),
    );
  }
}
