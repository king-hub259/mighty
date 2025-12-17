import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/common/widget/custom_contaner.dart';
import 'package:mighty_school/feature/parent_module/parent_exam/controller/parent_exam_controller.dart';
import 'package:mighty_school/feature/parent_module/parent_exam/domain/model/parent_exam_result_model.dart';
import 'package:mighty_school/feature/parent_module/parent_paid_info/presentation/widgets/parent_paid_report_item_widget.dart';
import 'package:mighty_school/util/dimensions.dart';

class ParentExamResultScreen extends StatelessWidget {
  final int examId;
  const ParentExamResultScreen({super.key, required this.examId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: CustomAppBar(title: "exam_result".tr),
      body: GetBuilder<ParentExamController>(
          initState: (val)=> Get.find<ParentExamController>().getExamResults(examId),
          builder: (examController) {
            ParentExamResultModel? examResultModel = examController.examResultModel;
            var examResult = examResultModel?.data;
            var subject = examResult?.subjects;
            return CustomWebScrollView(slivers: [

              SliverToBoxAdapter(child: Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, spacing: Dimensions.paddingSizeSmall, children: [
                  CustomContainer(width: Get.width, color: examResult?.exam?.result?.toLowerCase() == "pass"? Colors.green : Colors.red,
                      showShadow: false, borderColor: Theme.of(context).hintColor.withAlpha(50),borderRadius: Dimensions.paddingSizeExtraSmall,
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, spacing: Dimensions.paddingSizeExtraSmall, children: [
                        ItemInfoWithStyleWidget(title: "exam_name".tr, value: examResult?.exam?.name ?? "N/A", valueColor: Colors.white,titleColor: Colors.white, ),
                        ItemInfoWithStyleWidget(title: "total_marks".tr, value: examResult?.exam?.totalMarks.toString() ?? "N/A",  valueColor: Colors.white,titleColor: Colors.white,) ,
                        ItemInfoWithStyleWidget(title: "marks_obtained".tr, value: examResult?.exam?.obtainedMarks.toString() ?? "N/A",  valueColor: Colors.white,titleColor: Colors.white,) ,
                        ItemInfoWithStyleWidget(title: "percentage".tr, value: examResult?.exam?.percentage?.toString() ?? "N/A",  valueColor: Colors.white,titleColor: Colors.white,) ,
                        ItemInfoWithStyleWidget(title: "grade".tr, value: examResult?.exam?.grade.toString() ?? "N/A",  valueColor: Colors.white,titleColor: Colors.white,) ,
                        ItemInfoWithStyleWidget(title: "gpa".tr, value: examResult?.exam?.gradePoint?.toString() ?? "N/A",  valueColor: Colors.white,titleColor: Colors.white,) ,
                        ItemInfoWithStyleWidget(title: "result".tr, value: examResult?.exam?.result ?? "N/A",  fontSize: Dimensions.fontSizeLarge,
                          valueColor: Colors.white,titleColor: Colors.white,) ,
                      ])),

                  (examResultModel != null && subject != null && subject.isNotEmpty)?
                  ListView.builder(
                      itemCount: subject.length,
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemBuilder: (context, index){
                        return SubjectWiseMarkWidget(subjects: subject[index]);
                      }): const SizedBox()
                ]),
              ),)
            ],);
          }
      ),
    );
  }
}

class SubjectWiseMarkWidget extends StatelessWidget {
  final Subjects? subjects;
  const SubjectWiseMarkWidget({super.key, this.subjects});

  @override
  Widget build(BuildContext context) {
    return CustomContainer(showShadow: false, borderRadius: Dimensions.paddingSizeExtraSmall,
      borderColor: Theme.of(context).hintColor.withAlpha(50),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        ItemInfoWithStyleWidget(title: "subject_name".tr, value: subjects?.name ?? "N/A"),
        ItemInfoWithStyleWidget(title: "marks_obtained".tr, value: subjects?.marksObtained.toString() ?? "N/A"),
        ItemInfoWithStyleWidget(title: "total_marks".tr, value: subjects?.fullMarks.toString() ?? "N/A"),
        ItemInfoWithStyleWidget(title: "grade".tr, value: subjects?.grade.toString() ?? "N/A"),
        ItemInfoWithStyleWidget(title: "remark".tr, value: subjects?.remarks.toString() ?? "N/A"),

      ]),
    );
  }
}
