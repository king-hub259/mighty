import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/feature/students_information/student_migration/presentation/widgets/student_list_for_migration_widget.dart';
import 'package:mighty_school/util/dimensions.dart';

class StudentMigrationScreen extends StatefulWidget {
  final bool isMigrationPushback;
  const StudentMigrationScreen({super.key, this.isMigrationPushback = false});

  @override
  State<StudentMigrationScreen> createState() => _StudentMigrationScreenState();
}

class _StudentMigrationScreenState extends State<StudentMigrationScreen> {
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: CustomAppBar(title: "student_migration".tr),
        body: CustomWebScrollView(slivers: [

           SliverToBoxAdapter(child: Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
            child: StudentListForMigrationWidget(fromPushBack: widget.isMigrationPushback,)))
        ],),
    );
  }
}
