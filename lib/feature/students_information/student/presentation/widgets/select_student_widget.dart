import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_title.dart';
import 'package:mighty_school/feature/students_information/student/controller/student_controller.dart';
import 'package:mighty_school/feature/students_information/student/presentation/widgets/student_dropdown.dart';

class SelectStudentWidget extends StatefulWidget {
  const SelectStudentWidget({super.key});

  @override
  State<SelectStudentWidget> createState() => _SelectStudentWidgetState();
}

class _SelectStudentWidgetState extends State<SelectStudentWidget> {
  @override
  void initState() {
    super.initState();
    // Load all students if not already loaded
    if (Get.find<StudentController>().allStudentModel == null) {
      Get.find<StudentController>().getAllStudentList(1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CustomTitle(title: "student", isRequired: true),
        GetBuilder<StudentController>(
          builder: (studentController) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: StudentDropdown(
                width: Get.width,
                title: "select_student".tr,
                items: studentController.allStudentModel?.data?.data ?? [],
                selectedValue: studentController.selectedStudentItem,
                onChanged: (val) {
                  studentController.setSelectedStudent(val!);
                },
              ),
            );
          }
        ),
      ],
    );
  }
}
