import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_dropdown.dart';
import 'package:mighty_school/common/widget/custom_title.dart';
import 'package:mighty_school/feature/students_information/student/controller/student_controller.dart';

class SelectBloodGroupSectionWidget extends StatelessWidget {
  const SelectBloodGroupSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StudentController>(
      builder: (studentController) {
        return Column(children: [
          const CustomTitle(title: "blood_group", isRequired: true,),
          Padding(padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: CustomDropdown(width: Get.width, title: "select".tr,
              items: studentController.bloodGroups,
              selectedValue: studentController.selectedBloodGroup,
              onChanged: (val){
                studentController.setSelectedBloodGroup(val!);
              },
            ),),
        ],);
      }
    );
  }
}
