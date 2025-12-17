
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/feature/students_information/student/presentation/widgets/add_new_student_widget.dart';
import 'package:mighty_school/util/dimensions.dart';

import '../../domain/model/student_model.dart';

class AddNewStudentScreen extends StatefulWidget {
  final StudentItem? studentItem;
  const AddNewStudentScreen({super.key, this.studentItem});

  @override
  State<AddNewStudentScreen> createState() => _AddNewStudentScreenState();
}

class _AddNewStudentScreenState extends State<AddNewStudentScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  CustomAppBar(title: "add_new_student".tr),
      body: const CustomWebScrollView(slivers: [

        SliverToBoxAdapter(child: Padding(padding: EdgeInsets.all(Dimensions.paddingSizeDefault),
          child: AddNewStudentWidget()))
      ],),
    );
  }
}
