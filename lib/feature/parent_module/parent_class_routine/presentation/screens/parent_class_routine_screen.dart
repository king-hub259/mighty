import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/common/widget/custom_delegate.dart';
import 'package:mighty_school/feature/parent_module/parent_class_routine/presentation/widgets/parent_routine_list_widget.dart';
import 'package:mighty_school/feature/parent_module/parent_class_routine/presentation/widgets/parent_week_days_list.dart';
import 'package:mighty_school/util/dimensions.dart';

class ParentClassRoutineScreen extends StatefulWidget {
  const ParentClassRoutineScreen({super.key});

  @override
  State<ParentClassRoutineScreen> createState() => _ParentClassRoutineScreenState();
}

class _ParentClassRoutineScreenState extends State<ParentClassRoutineScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "class_routine".tr),
      body: CustomWebScrollView(slivers: [

        SliverPersistentHeader(pinned: true,floating: true, delegate: SliverDelegate(height: 60, child: const ParentWeekDaysList())),
        const SliverToBoxAdapter(child: Padding(padding: EdgeInsets.all(Dimensions.paddingSizeDefault),
          child: ParentRoutineListWidget(),
        ),)
      ],),
    );
  }
}
