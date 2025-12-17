import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/common/widget/custom_floating_button.dart';
import 'package:mighty_school/feature/staff_information/teacher/controller/teacher_controller.dart';
import 'package:mighty_school/feature/staff_information/teacher/presentation/screens/add_new_teacher_screen.dart';
import 'package:mighty_school/feature/staff_information/teacher/presentation/widgets/teacher_list_widget.dart';
import 'package:mighty_school/util/dimensions.dart';

class TeacherScreen extends StatefulWidget {
  const TeacherScreen({super.key});

  @override
  State<TeacherScreen> createState() => _TeacherScreenState();
}

class _TeacherScreenState extends State<TeacherScreen> {

  Future<void> loadData()async {
    if(Get.find<TeacherController>().teacherModel == null){
      Get.find<TeacherController>().getTeacherList(1);
    }

  }
  ScrollController scrollController = ScrollController();


  @override
  void initState() {
    loadData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(appBar: CustomAppBar(title: "teachers".tr),
    body: CustomWebScrollView(controller: scrollController, slivers: [

      SliverToBoxAdapter(child: Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
        child: TeacherListWidget(scrollController: scrollController)))
    ],),
      floatingActionButton: CustomFloatingButton(onTap: ()=> Get.to(()=> const AddNewTeacherScreen()))
    );
  }
}
