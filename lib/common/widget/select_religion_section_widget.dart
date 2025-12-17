import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_dropdown.dart';
import 'package:mighty_school/common/widget/custom_title.dart';
import 'package:mighty_school/feature/students_information/student/controller/student_controller.dart';

class SelectReligionSectionWidget extends StatelessWidget {
  const SelectReligionSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StudentController>(
      builder: (commonController) {
        return Column(children: [
          const CustomTitle(title: "religion"),
          Padding(padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: CustomDropdown(width: Get.width, title: "select".tr,
              items: commonController.religions,
              selectedValue: commonController.selectedReligion,
              onChanged: (val){
                commonController.setSelectedReligion(val!);
              },
            ),),
        ],);
      }
    );
  }
}
