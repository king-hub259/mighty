import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/layout/list_layout_widget.dart';
import 'package:mighty_school/feature/students_information/student/controller/student_controller.dart';
import 'package:mighty_school/feature/students_information/student/presentation/widgets/all_student_item.dart';

class AllStudentListWidget extends StatelessWidget {
  final ScrollController scrollController;
  const AllStudentListWidget({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StudentController>(
      initState: (val) => Get.find<StudentController>().getAllStudentList(1),
      builder: (studentController) {
        final allStudentModel = studentController.allStudentModel;
        final allStudentData = allStudentModel?.data;
        return GenericListSection(
          sectionTitle: "student_management".tr,
          pathItems: ["all_student_data".tr],
          headings: const ["image", "roll", "name", "phone", "gender", "section", "class", "guardian"],
          scrollController: scrollController,
          isLoading: allStudentModel == null,
          totalSize: allStudentData?.total ?? 0,
          offset: allStudentData?.currentPage ?? 0,
          onPaginate: (offset) async => await studentController.getAllStudentList(offset ?? 1),
          items: allStudentData?.data ?? [],
          itemBuilder: (item, index) => AllStudentItemWidget(index: index, studentItem: item, isAll: true),
        );
      },
    );
  }
}