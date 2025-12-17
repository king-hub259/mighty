import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_button.dart';
import 'package:mighty_school/common/widget/custom_contaner.dart';
import 'package:mighty_school/common/widget/custom_title.dart';
import 'package:mighty_school/feature/exam_management/exam/controller/exam_controller.dart';
import 'package:mighty_school/feature/exam_management/exam/domain/model/exam_model.dart';
import 'package:mighty_school/feature/exam_management/exam/presentation/widgets/exam_item_widget.dart';
import 'package:mighty_school/helper/responsive_helper.dart';


class ExamListWidget extends StatefulWidget {

  const ExamListWidget({super.key});

  @override
  State<ExamListWidget> createState() => _ExamListWidgetState();
}

class _ExamListWidgetState extends State<ExamListWidget> {
  @override
  void initState() {
    Get.find<ExamController>().getExamList(1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ExamController>(
        builder: (examStartupController) {
          var exam = examStartupController.examModel?.data;
          ExamModel? examModel = examStartupController.examModel;
          return CustomContainer(
            child: Column(children: [

              if(ResponsiveHelper.isDesktop(context))
                const CustomTitle(title: "select_exam"),

              if(examModel != null && examModel.data!= null && examModel.data!.data!.isNotEmpty)
                Expanded(
                  child: ListView.builder(
                      itemCount: exam?.data?.length??0,
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemBuilder: (context, index){
                        return ExamItemWidget(index: index, examItem: exam?.data?[index]);
                      }),
                ),

              if(examModel != null && examModel.data!= null && examModel.data!.data!.isNotEmpty)
              Align(alignment: Alignment.centerRight, child: SizedBox(width: 90,child: CustomButton(onTap: (){
               Get.back();
                examStartupController.addSelectedExam();
              }, text: "Confirm")))
            ],),
          );
        }
    );
  }
}
