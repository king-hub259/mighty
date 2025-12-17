import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/common/widget/no_data_found.dart';
import 'package:mighty_school/feature/parent_module/parent_exam/controller/parent_exam_controller.dart';
import 'package:mighty_school/feature/parent_module/parent_exam/domain/model/parent_exam_model.dart';
import 'package:mighty_school/feature/parent_module/parent_exam/presentation/widgets/parent_exam_item_widget.dart';
import 'package:mighty_school/util/styles.dart';


class ParentExamScreen extends StatefulWidget {
  const ParentExamScreen({super.key});

  @override
  State<ParentExamScreen> createState() => _ParentExamScreenState();
}

class _ParentExamScreenState extends State<ParentExamScreen> {
  @override
  void initState() {
    super.initState();
    Get.find<ParentExamController>().getExamList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar:  CustomAppBar(title: "exams".tr),
        body: CustomWebScrollView( slivers: [

          SliverToBoxAdapter(child: GetBuilder<ParentExamController>(
              builder: (examStartupController) {
                ParentExamModel? examModel = examStartupController.examModel;
                var exam = examModel?.data;
                return examModel != null ? (examModel.data!= null && examModel.data!.isNotEmpty)?
                ListView.builder(
                    itemCount: exam?.length??0,
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    itemBuilder: (context, index){
                      return ParentExamItemWidget(index: index, examItem: exam?[index]);
                    }):
                 Center(child: Padding(
                  padding:ThemeShadow.getPadding(),
                  child: const NoDataFound(),
                )): Center(child: Padding(padding: ThemeShadow.getPadding(),
                    child: const CircularProgressIndicator()));
              }
          ))
        ]));
  }
}
