import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_title.dart';
import 'package:mighty_school/feature/academic_configuration/subject/controller/subject_controller.dart';
import 'package:mighty_school/feature/academic_configuration/subject/presentation/widgets/subject_dropdown.dart';

class SelectSubjectWidget extends StatefulWidget {
  const SelectSubjectWidget({super.key});

  @override
  State<SelectSubjectWidget> createState() => _SelectSubjectWidgetState();
}

class _SelectSubjectWidgetState extends State<SelectSubjectWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const CustomTitle(title: "subject"),
      GetBuilder<SubjectController>(
          builder: (subjectController) {
            return Padding(padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: SubjectDropdown(width: Get.width, title: "select_subject".tr,
                items: subjectController.classWiseSubjectModel?.data??[],
                selectedValue: subjectController.selectedSubjectItem,
                onChanged: (val){
                  subjectController.setSelectSubjectItem(val!);
                },
              ),);
          }
      ),
    ],);
  }
}
