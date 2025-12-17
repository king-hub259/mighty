
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/feature/staff_information/staff_attendance/presentation/widgets/add_new_staff_attendance_widget.dart';
import 'package:mighty_school/feature/student_attendance_information/student_attendance/domain/models/student_attendance_model.dart';
import 'package:mighty_school/util/dimensions.dart';

class AddNewStaffAttendanceScreen extends StatefulWidget {
  final AttendanceItem? attendanceItem;
  const AddNewStaffAttendanceScreen({super.key, this.attendanceItem});

  @override
  State<AddNewStaffAttendanceScreen> createState() => _AddNewStaffAttendanceScreenState();
}

class _AddNewStaffAttendanceScreenState extends State<AddNewStaffAttendanceScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: CustomAppBar(title: "add_new_attendance".tr),
    body: const CustomWebScrollView(slivers: [
      SliverToBoxAdapter(child: Column(children: [
        Padding(padding: EdgeInsets.all(Dimensions.paddingSizeSmall),
          child: AddNewStaffAttendanceWidget(),
        )
      ],),)
    ],),);
  }
}
