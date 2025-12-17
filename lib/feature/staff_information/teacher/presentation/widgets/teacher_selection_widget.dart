import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_title.dart';
import 'package:mighty_school/feature/staff_information/teacher/controller/teacher_controller.dart';
import 'package:mighty_school/feature/staff_information/teacher/presentation/widgets/teacher_dropdown.dart';

class SelectTeacherWidget extends StatefulWidget {
  const SelectTeacherWidget({super.key});

  @override
  State<SelectTeacherWidget> createState() => _SelectTeacherWidgetState();
}

class _SelectTeacherWidgetState extends State<SelectTeacherWidget> {
  @override
  void initState() {
    if(Get.find<TeacherController>().teacherModel == null){
      Get.find<TeacherController>().getTeacherList(1);
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const CustomTitle(title: "teacher"),
      GetBuilder<TeacherController>(
          builder: (teacherController) {
            return Padding(padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: TeacherDropdown(width: Get.width, title: "select".tr,
                items: teacherController.teacherModel?.data?.data??[],
                selectedValue: teacherController.selectedTeacherItem,
                onChanged: (val){
                  teacherController.selectTeacher(val!);
                },
              ),);
          }
      ),
    ],);
  }
}
