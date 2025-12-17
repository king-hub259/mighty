import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/common/widget/custom_delegate.dart';
import 'package:mighty_school/feature/routine_management/class_routine/presentation/widgets/class_routine_widget.dart';
import 'package:mighty_school/feature/routine_management/class_routine/presentation/widgets/week_days_list.dart';
import 'package:mighty_school/util/dimensions.dart';


class ClassRoutineScreen extends StatefulWidget {
  const ClassRoutineScreen({super.key});

  @override
  State<ClassRoutineScreen> createState() => _ClassRoutineScreenState();
}

class _ClassRoutineScreenState extends State<ClassRoutineScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "class_routine".tr),
      body: CustomWebScrollView(slivers: [
        SliverPersistentHeader(pinned: true,floating: true, delegate: SliverDelegate(height: 60, child: const WeekDaysList())),
         const SliverToBoxAdapter(child: Padding(
          padding: EdgeInsets.all(Dimensions.paddingSizeDefault),
          child: ClassRoutineWidget(),
        ),)
      ],),
    );
  }
}
