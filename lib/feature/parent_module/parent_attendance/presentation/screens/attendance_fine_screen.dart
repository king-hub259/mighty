
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/feature/parent_module/parent_attendance/presentation/widgets/attendance_fine_list_widget.dart';

class AttendanceFineScreen extends StatefulWidget {
  const AttendanceFineScreen({super.key});

  @override
  State<AttendanceFineScreen> createState() => _AttendanceFineScreenState();
}

class _AttendanceFineScreenState extends State<AttendanceFineScreen> {
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar : CustomAppBar(title: "attendance_fine".tr),
      body: CustomWebScrollView(controller: scrollController, slivers: [

        SliverToBoxAdapter(child: AttendanceFineListWidget(scrollController: scrollController))
      ],),

    );
  }
}



