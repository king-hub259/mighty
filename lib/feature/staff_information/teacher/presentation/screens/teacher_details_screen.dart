import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/common/widget/custom_image.dart';
import 'package:mighty_school/feature/students_information/student/controller/student_controller.dart';
import 'package:mighty_school/feature/students_information/student/domain/model/student_details_model.dart';
import 'package:mighty_school/util/dimensions.dart';

class TeacherDetailsScreen extends StatefulWidget {
  final String name;
  final int id;
  const TeacherDetailsScreen({super.key, required this.name, required this.id});

  @override
  State<TeacherDetailsScreen> createState() => _TeacherDetailsScreenState();
}

class _TeacherDetailsScreenState extends State<TeacherDetailsScreen> {
  @override
  void initState() {
    Get.find<StudentController>().studentDetails(widget.id);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: widget.name,),
      body: CustomWebScrollView(slivers: [
        SliverToBoxAdapter(child: Padding(
          padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
          child: GetBuilder<StudentController>(
            builder: (studentController) {
              StudentDetailsModel? studentDetailsModel = studentController.studentDetailsModel;
              return studentDetailsModel != null?
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const Center(child: CustomImage(image: "", width: 120, height: 120,)),
                const SizedBox(height: Dimensions.paddingSizeDefault),
                Text('${"student_name".tr}: ${widget.name}'),
                Text('${"fathers_name".tr}: ${studentDetailsModel.data?.fatherName??''}'),
                Text('${"mothers_name".tr}: ${studentDetailsModel.data?.motherName??''}'),
                Text('${"gender".tr}: ${studentDetailsModel.data?.gender??''}'),
                Text('${"religion".tr}: ${studentDetailsModel.data?.religion??''}'),
                Text('${"phone".tr}: ${studentDetailsModel.data?.phone??''}'),
                Text('${"registration".tr}: ${studentDetailsModel.data?.registerNo??''}'),
                Text('${"blood_group".tr}: ${studentDetailsModel.data?.bloodGroup??''}'),
                Text('${"group".tr}: ${studentDetailsModel.data?.group??''}'),
                Text('${"country".tr}: ${studentDetailsModel.data?.country??''}'),
                Text('${"state".tr}: ${studentDetailsModel.data?.state??''}'),
                Text('${"address".tr}: ${studentDetailsModel.data?.address??''}'),
                Text('${"birthday".tr}: ${studentDetailsModel.data?.birthday??''}'),
              ],): const Center(child: CircularProgressIndicator());
            }
          ),
        ),)
      ],),
    );
  }
}
