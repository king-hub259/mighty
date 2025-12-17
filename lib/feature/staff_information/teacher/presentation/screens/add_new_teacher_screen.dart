
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/feature/staff_information/teacher/presentation/widgets/add_new_teacher_widget.dart';
import 'package:mighty_school/helper/responsive_helper.dart';
import 'package:mighty_school/util/dimensions.dart';
import '../../domain/model/teacher_model.dart';

class AddNewTeacherScreen extends StatefulWidget {
  final TeacherItem? teacherItem;
  const AddNewTeacherScreen({super.key, this.teacherItem});

  @override
  State<AddNewTeacherScreen> createState() => _AddNewTeacherScreenState();
}

class _AddNewTeacherScreenState extends State<AddNewTeacherScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ResponsiveHelper.isDesktop(context)? null : CustomAppBar(title: "add_new_teacher".tr),
      body: CustomWebScrollView(slivers: [

        SliverToBoxAdapter(child: Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
          child: AddNewTeacherWidget(fromStaff: false, teacherItem: widget.teacherItem,)))
      ],),
    );
  }
}
