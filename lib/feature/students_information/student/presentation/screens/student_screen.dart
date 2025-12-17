import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/common/widget/custom_floating_button.dart';
import 'package:mighty_school/feature/students_information/student/presentation/screens/add_new_student_screen.dart';
import 'package:mighty_school/feature/students_information/student/presentation/widgets/student_info_list_widget.dart';
import 'package:mighty_school/util/dimensions.dart';

class StudentScreen extends StatefulWidget {
  const StudentScreen({super.key});

  @override
  State<StudentScreen> createState() => _StudentScreenState();
}

class _StudentScreenState extends State<StudentScreen> {
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: CustomAppBar(title: "students".tr),
        body: const CustomWebScrollView(slivers: [

          SliverToBoxAdapter(child: Padding(padding: EdgeInsets.all(Dimensions.paddingSizeDefault),
            child: StudentInfoListWidget(),
          ),)
        ],),
      floatingActionButton:  CustomFloatingButton(onTap: ()=> Get.to(()=> const AddNewStudentScreen()))
    );
  }
}
