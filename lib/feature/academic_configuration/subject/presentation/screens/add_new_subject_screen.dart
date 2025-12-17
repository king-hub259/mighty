
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/feature/academic_configuration/subject/presentation/widgets/add_new_subject_widget.dart';
import 'package:mighty_school/util/dimensions.dart';

class AddNewSubjectScreen extends StatefulWidget {
  const AddNewSubjectScreen({super.key});

  @override
  State<AddNewSubjectScreen> createState() => _AddNewSubjectScreenState();
}

class _AddNewSubjectScreenState extends State<AddNewSubjectScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: CustomAppBar(title: "add_new_subject".tr),
      body: const CustomWebScrollView(slivers: [

        SliverToBoxAdapter(child: Padding(padding: EdgeInsets.all(Dimensions.paddingSizeDefault),
            child: AddNewSubjectWidget()))
      ],),
    );
  }
}
