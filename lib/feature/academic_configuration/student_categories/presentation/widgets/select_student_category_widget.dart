import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_title.dart';
import 'package:mighty_school/feature/academic_configuration/student_categories/controller/student_categories_controller.dart';
import 'package:mighty_school/feature/academic_configuration/student_categories/presentation/widgets/student_category_dropdown.dart';

class SelectStudentCategoryWidget extends StatefulWidget {
  const SelectStudentCategoryWidget({super.key});

  @override
  State<SelectStudentCategoryWidget> createState() => _SelectStudentCategoryWidgetState();
}

class _SelectStudentCategoryWidgetState extends State<SelectStudentCategoryWidget> {
  @override
  void initState() {
    if(Get.find<StudentCategoriesController>().studentCategoriesModel == null){
      Get.find<StudentCategoriesController>().getStudentCategoriesList(perPage: 100, page: 1);
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const CustomTitle(title: "student_category"),
      GetBuilder<StudentCategoriesController>(
          builder: (studentCategoryController) {
            return Padding(padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: StudentCategoryDropdown(width: Get.width, title: "select".tr,
                items: studentCategoryController.studentCategoriesModel?.data?.data??[],
                selectedValue: studentCategoryController.selectedStudentCategories,
                onChanged: (val){
                  studentCategoryController.setSelectStudentCategories(val!);
                },
              ),);
          }
      ),
    ],);
  }
}
