import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/common/widget/custom_floating_button.dart';
import 'package:mighty_school/feature/academic_configuration/student_categories/presentation/screens/create_new_student_category_dialog.dart';
import 'package:mighty_school/feature/academic_configuration/student_categories/presentation/widgets/student_category_list_widget.dart';

class StudentCategoriesScreen extends StatefulWidget {
  const StudentCategoriesScreen({super.key});

  @override
  State<StudentCategoriesScreen> createState() => _StudentCategoriesScreenState();
}

class _StudentCategoriesScreenState extends State<StudentCategoriesScreen> {
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: CustomAppBar(title: "student_categories".tr),
    body: CustomWebScrollView(controller: scrollController, slivers: [
      SliverToBoxAdapter(child: StudentCategoryListWidget(scrollController: scrollController))
    ],),
      floatingActionButton: CustomFloatingButton(onTap: ()=> Get.dialog(const CreateNewStudentCategoriesScreen())));
  }
}
