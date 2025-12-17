import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/common/widget/custom_floating_button.dart';
import 'package:mighty_school/feature/exam_management/exam/presentation/widgets/create_new_exam_dialog.dart';
import 'package:mighty_school/feature/exam_management/exam/presentation/widgets/exam_listview_widget.dart';

class ExamScreen extends StatefulWidget {
  const ExamScreen({super.key});

  @override
  State<ExamScreen> createState() => _ExamScreenState();
}

class _ExamScreenState extends State<ExamScreen> {
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: CustomAppBar(title: "exam".tr),
        body: CustomWebScrollView( slivers: [
          SliverToBoxAdapter(child: ExamListviewWidget(scrollController: scrollController))
        ],),
        floatingActionButton: CustomFloatingButton(title: "add", onTap: ()=>Get.dialog(const CreateNewExamDialog())));
  }
}
