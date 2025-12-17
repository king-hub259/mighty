
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/feature/staff_information/staff_attendance/presentation/widgets/add_new_staff_attendance_widget.dart';
import 'package:mighty_school/feature/staff_information/staff_attendance/presentation/widgets/staff_list_for_attendance_section.dart';

class StaffAttendanceScreen extends StatefulWidget {
  const StaffAttendanceScreen({super.key});

  @override
  State<StaffAttendanceScreen> createState() => _StaffAttendanceScreenState();
}

class _StaffAttendanceScreenState extends State<StaffAttendanceScreen> {
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: CustomAppBar(title: "staff_attendance".tr),
        body: CustomWebScrollView(controller: scrollController, slivers: const [

          SliverToBoxAdapter(child: Column(children: [
            AddNewStaffAttendanceWidget(),
            StaffListForAttendanceWidget()
          ]))
        ],),
    );
  }
}



