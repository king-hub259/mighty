import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/confirmation_dialog.dart';
import 'package:mighty_school/common/widget/edit_delete_section.dart';
import 'package:mighty_school/common/widget/numbering_widget.dart';
import 'package:mighty_school/feature/academic_configuration/student_categories/controller/student_categories_controller.dart';
import 'package:mighty_school/feature/academic_configuration/student_categories/domain/model/student_categories_model.dart';
import 'package:mighty_school/feature/academic_configuration/student_categories/presentation/screens/create_new_student_category_dialog.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';

class StudentCategoryItemWidget extends StatelessWidget {
  final StudentCategoryItem? studentCategoryItem;
  final int index;
  const StudentCategoryItemWidget({super.key, this.studentCategoryItem, required this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.fromLTRB(Dimensions.paddingSizeDefault, Dimensions.paddingSizeDefault, Dimensions.paddingSizeDefault, 0),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start,spacing: Dimensions.paddingSizeDefault, children: [
        NumberingWidget(index: index),
        Expanded(child: Text('${studentCategoryItem?.name}', style: textRegular.copyWith(),)),
        EditDeleteSection(horizontal: true, onDelete: (){
          Get.dialog(ConfirmationDialog(
            title: "student_category",
            content: "student_category",
            onTap: (){
              Get.back();
              Get.find<StudentCategoriesController>().deleteStudentCategory(studentCategoryItem!.id!);
            }));

        }, onEdit: (){
          Get.dialog(CreateNewStudentCategoriesScreen(studentCategoryItem: studentCategoryItem));
        },)
      ]),
    );
  }
}
