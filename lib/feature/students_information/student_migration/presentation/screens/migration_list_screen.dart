import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/feature/students_information/student_migration/presentation/widgets/migration_list_widget.dart';

class StudentMigrationListScreen extends StatefulWidget {
  const StudentMigrationListScreen({super.key});

  @override
  State<StudentMigrationListScreen> createState() => _StudentMigrationListScreenState();
}

class _StudentMigrationListScreenState extends State<StudentMigrationListScreen> {
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: CustomAppBar(title: "migration_list".tr),
      body: const CustomWebScrollView(slivers: [

        SliverToBoxAdapter(child: MigrationListWidget())
      ],),
    );
  }
}
