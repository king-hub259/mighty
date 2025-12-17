import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/common/widget/custom_contaner.dart';
import 'package:mighty_school/common/widget/no_data_found.dart';
import 'package:mighty_school/feature/student_module/student_library/controller/student_library_controller.dart';
import 'package:mighty_school/feature/student_module/student_library/domain/model/student_library_model.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';

class StudentLibraryScreen extends StatefulWidget {
  const StudentLibraryScreen({super.key});

  @override
  State<StudentLibraryScreen> createState() => _StudentLibraryScreenState();
}

class _StudentLibraryScreenState extends State<StudentLibraryScreen> {
  @override
  void initState() {
    Get.find<StudentLibraryController>().getLibraryHistory();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: CustomAppBar(title: "library_history".tr),
    body: CustomWebScrollView(slivers: [
      SliverToBoxAdapter(child: GetBuilder<StudentLibraryController>(builder: (libraryController) {
          StudentLibraryModel? libraryModel = libraryController.libraryModel;
          var issues = libraryModel?.data?.issues;
          return libraryModel != null? (libraryModel.data != null && libraryModel.data!.issues !=null && libraryModel.data!.issues!.isNotEmpty)?
          Column(children: [
            ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: issues?.length,
              itemBuilder: (context, index){
                Issues issue = issues![index];
                return Padding(padding: const EdgeInsets.fromLTRB(Dimensions.paddingSizeDefault, Dimensions.paddingSizeDefault, Dimensions.paddingSizeDefault,0),
                  child: CustomContainer(borderRadius: Dimensions.paddingSizeExtraSmall, child: Column(children: [
                    Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeExtraSmall),
                      child: Column(children: [
                          Text(issue.bookName??'', style: textRegular.copyWith(fontSize: Dimensions.fontSizeLarge)),
                          Text("${"issue_date".tr}: ${issue.issueDate??''}", style: textRegular.copyWith()),
                        ],
                      ))
                  ],),),
                );
              })
          ]): Padding(padding: ThemeShadow.getPadding(), child: const NoDataFound()) :
          Padding(padding: ThemeShadow.getPadding(), child: const Center(child: CircularProgressIndicator()));
        }
      ),)
    ],),);
  }
}
