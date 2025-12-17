import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/layout/list_layout_widget.dart';
import 'package:mighty_school/feature/academic_configuration/student_categories/controller/student_categories_controller.dart';
import 'package:mighty_school/feature/academic_configuration/student_categories/domain/model/student_categories_model.dart';
import 'package:mighty_school/feature/academic_configuration/student_categories/presentation/screens/create_new_student_category_dialog.dart';
import 'package:mighty_school/feature/academic_configuration/student_categories/presentation/widgets/student_category_item.dart';

class StudentCategoryListWidget extends StatelessWidget {
  final ScrollController scrollController;
  const StudentCategoryListWidget({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StudentCategoriesController>(
      initState: (val) => Get.find<StudentCategoriesController>().getStudentCategoriesList(),
      builder: (studentCategoryController) {
        final studentCategoriesModel = studentCategoryController.studentCategoriesModel;
        final studentCategoryData = studentCategoriesModel?.data;

        return GenericListSection<StudentCategoryItem>(
          sectionTitle: "academic_configuration".tr,
          pathItems: ["student_category".tr],
          addNewTitle: "add_new_student_category".tr,
          onAddNewTap: () => Get.dialog(const CreateNewStudentCategoriesScreen()),
          headings: const ["student_category", "action"],

          scrollController: scrollController,
          isLoading: studentCategoriesModel == null,
          totalSize: studentCategoryData?.total ?? 0,
          offset: studentCategoryData?.currentPage ?? 0,
          onPaginate: (offset) async => await studentCategoryController.getStudentCategoriesList(page: offset ?? 1),

          items: studentCategoryData?.data ?? [],
          itemBuilder: (item, index) => StudentCategoryItemWidget(studentCategoryItem: item, index: index),
        );
      },
    );
  }
}