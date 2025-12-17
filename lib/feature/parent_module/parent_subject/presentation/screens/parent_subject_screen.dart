import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/feature/parent_module/parent_subject/presentation/widgets/parent_subject_list_widget.dart';

class ParentSubjectScreen extends StatefulWidget {
  const ParentSubjectScreen({super.key});

  @override
  State<ParentSubjectScreen> createState() => _ParentSubjectScreenState();
}

class _ParentSubjectScreenState extends State<ParentSubjectScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: CustomAppBar(title: "subjects".tr),
      body: const CustomWebScrollView(slivers: [
        SliverToBoxAdapter(child: ParentSubjectListWidget())
      ],),);
  }
}
