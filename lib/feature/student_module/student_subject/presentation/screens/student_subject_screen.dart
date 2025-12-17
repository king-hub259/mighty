import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/common/widget/custom_contaner.dart';
import 'package:mighty_school/common/widget/no_data_found.dart';
import 'package:mighty_school/feature/student_module/student_subject/controller/student_subject_controller.dart';
import 'package:mighty_school/feature/student_module/student_subject/domain/model/student_subject_model.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';

class StudentSubjectScreen extends StatefulWidget {
  const StudentSubjectScreen({super.key});

  @override
  State<StudentSubjectScreen> createState() => _StudentSubjectScreenState();
}

class _StudentSubjectScreenState extends State<StudentSubjectScreen> {
  @override
  void initState() {
    Get.find<StudentSubjectController>().getMySubjectList();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: CustomAppBar(title: "my_subject".tr),
    body: CustomScrollView(slivers: [
      SliverToBoxAdapter(child: GetBuilder<StudentSubjectController>(builder: (subjectController) {
          StudentSubjectModel? subjectModel = subjectController.subjectModel;
          return subjectModel != null? (subjectModel.data != null && subjectModel.data!.isNotEmpty)?
          Column(children: [
            ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: subjectModel.data?.length,
              itemBuilder: (context, index){
                SubjectItem? subjectItem = subjectModel.data?[index];
                return Padding(padding: const EdgeInsets.fromLTRB(Dimensions.paddingSizeDefault, Dimensions.paddingSizeDefault, Dimensions.paddingSizeDefault,0),
                  child: CustomContainer(borderRadius: Dimensions.paddingSizeExtraSmall, child: Column(children: [
                    Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeExtraSmall),
                      child: Column(children: [
                          Text(subjectItem?.subjectName??'', style: textRegular.copyWith(fontSize: Dimensions.fontSizeLarge)),
                          Text("${"code".tr}: ${subjectItem?.subjectCode??''}", style: textRegular.copyWith()),
                        ],
                      ))
                  ],),),
                );
              })
          ]): Padding(padding: ThemeShadow.getPadding(), child: const NoDataFound(),) :
          Padding(padding: ThemeShadow.getPadding(), child: const Center(child: CircularProgressIndicator()));
        }
      ),)
    ],),);
  }
}
