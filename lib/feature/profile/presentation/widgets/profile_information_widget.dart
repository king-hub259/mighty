import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_contaner.dart';
import 'package:mighty_school/common/widget/custom_text_field.dart';
import 'package:mighty_school/common/widget/custom_title.dart';
import 'package:mighty_school/feature/profile/domain/model/profile_model.dart';
import 'package:mighty_school/feature/profile/logic/profile_controller.dart';
import 'package:mighty_school/util/dimensions.dart';

class ProfileInformationWidget extends StatefulWidget {
  const ProfileInformationWidget({super.key});

  @override
  State<ProfileInformationWidget> createState() => _ProfileInformationWidgetState();
}

class _ProfileInformationWidgetState extends State<ProfileInformationWidget> {

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      builder: (profileController) {
        ProfileModel? profileModel = profileController.profileModel;
        return CustomContainer(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const CustomTitle(title: "profile_information"),
          const SizedBox(height: Dimensions.paddingSizeExtraSmall),
          const CustomSubTitle(title: "profile_info_sub_title"),
          const SizedBox(height: Dimensions.paddingSizeDefault),

          CustomTextField(title: "name".tr,
          controller: nameController,
          isEnabled: false,
          hintText: "${profileModel?.data?.name}"),

          CustomTextField(title: "email".tr,
            controller: emailController,
              isEnabled: false,
            hintText: "${profileModel?.data?.email}"),
          const SizedBox(height: Dimensions.paddingSizeDefault),
        ],),);
      }
    );
  }
}
