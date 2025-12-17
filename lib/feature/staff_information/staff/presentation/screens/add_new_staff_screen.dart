
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/feature/staff_information/teacher/presentation/widgets/add_new_teacher_widget.dart';
import 'package:mighty_school/helper/responsive_helper.dart';
import 'package:mighty_school/util/dimensions.dart';

class AddNewStaffScreen extends StatefulWidget {
  const AddNewStaffScreen({super.key, });

  @override
  State<AddNewStaffScreen> createState() => _AddNewStaffScreenState();
}

class _AddNewStaffScreenState extends State<AddNewStaffScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ResponsiveHelper.isDesktop(context)? null : CustomAppBar(title: "add_new_staff".tr),
      body: const CustomWebScrollView(slivers: [

        SliverToBoxAdapter(child: Padding(padding: EdgeInsets.all(Dimensions.paddingSizeDefault),
            child: AddNewTeacherWidget(fromStaff: true)))
      ],),
    );
  }
}
