import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/common/widget/custom_delegate.dart';
import 'package:mighty_school/feature/student_module/student_class_routine/presentation/widgets/student_routine_list_widget.dart';
import 'package:mighty_school/feature/student_module/student_class_routine/presentation/widgets/student_week_days_list.dart';
import 'package:mighty_school/util/dimensions.dart';

class StudentClassRoutineScreen extends StatefulWidget {
  const StudentClassRoutineScreen({super.key});

  @override
  State<StudentClassRoutineScreen> createState() => _StudentClassRoutineScreenState();
}

class _StudentClassRoutineScreenState extends State<StudentClassRoutineScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "class_routine".tr),
      body: CustomScrollView(slivers: [
        SliverPersistentHeader(pinned: true,floating: true, delegate: SliverDelegate(height: 60, child: const StudentWeekDaysList())),
         const SliverToBoxAdapter(child: Padding(
          padding: EdgeInsets.all(Dimensions.paddingSizeDefault),
          child: StudentRoutineListWidget(),
        ),)
      ],),
    );
  }
}
