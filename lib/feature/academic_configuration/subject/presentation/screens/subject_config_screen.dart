import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/feature/academic_configuration/subject/presentation/widgets/subject_config.dart';
import 'package:mighty_school/util/dimensions.dart';

class SubjectConfigScreen extends StatefulWidget {
  const SubjectConfigScreen({super.key});

  @override
  State<SubjectConfigScreen> createState() => _SubjectConfigScreenState();
}

class _SubjectConfigScreenState extends State<SubjectConfigScreen> {
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: CustomAppBar(title: "subject_config".tr),
    body:  CustomWebScrollView(slivers: [
      SliverToBoxAdapter(child: Padding(
        padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
        child: SubjectConfigWidget(scrollController: scrollController),
      ),)
    ],),
    );
  }
}
