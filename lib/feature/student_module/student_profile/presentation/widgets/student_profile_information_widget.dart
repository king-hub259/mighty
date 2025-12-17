import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_contaner.dart';
import 'package:mighty_school/common/widget/custom_text_field.dart';
import 'package:mighty_school/common/widget/custom_title.dart';
import 'package:mighty_school/feature/student_module/student_profile/domain/model/student_profile_model.dart';
import 'package:mighty_school/feature/student_module/student_profile/logic/student_profile_controller.dart';
import 'package:mighty_school/util/dimensions.dart';

class StudentProfileInformationWidget extends StatefulWidget {
  const StudentProfileInformationWidget({super.key});

  @override
  State<StudentProfileInformationWidget> createState() => _StudentProfileInformationWidgetState();
}

class _StudentProfileInformationWidgetState extends State<StudentProfileInformationWidget> {

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return GetBuilder<StudentProfileController>(
      builder: (profileController) {
        StudentProfileModel? profileModel = profileController.profileModel;
        return CustomContainer(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const CustomTitle(title: "profile_information"),
          const SizedBox(height: Dimensions.paddingSizeExtraSmall),
          const CustomSubTitle(title: "profile_info_sub_title"),
          const SizedBox(height: Dimensions.paddingSizeDefault),

          CustomTextField(title: "name".tr,
          controller: nameController,
          hintText: "${profileModel?.data?.name}"),

          CustomTextField(title: "email".tr,
            controller: emailController,
            hintText: "${profileModel?.data?.email}"),
          const SizedBox(height: Dimensions.paddingSizeDefault),
        ],),);
      }
    );
  }
}
