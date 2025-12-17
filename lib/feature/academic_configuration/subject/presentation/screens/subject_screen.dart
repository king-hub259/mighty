import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/common/widget/custom_floating_button.dart';
import 'package:mighty_school/feature/academic_configuration/subject/presentation/screens/add_new_subject_screen.dart';
import 'package:mighty_school/feature/academic_configuration/subject/presentation/widgets/subject_list_widget.dart';
import 'package:mighty_school/util/dimensions.dart';

class SubjectScreen extends StatefulWidget {
  const SubjectScreen({super.key});

  @override
  State<SubjectScreen> createState() => _SubjectScreenState();
}

class _SubjectScreenState extends State<SubjectScreen> {
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: CustomAppBar(title: "subjects".tr),
    body:  CustomWebScrollView(controller: scrollController, slivers: [

      SliverToBoxAdapter(child: Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
        child: SubjectListWidget(scrollController: scrollController)))
    ]),
      floatingActionButton: CustomFloatingButton(onTap: ()=> Get.to(()=> const AddNewSubjectScreen()))
    );
  }
}
