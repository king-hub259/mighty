import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_button.dart';
import 'package:mighty_school/common/widget/custom_contaner.dart';
import 'package:mighty_school/common/widget/custom_title.dart';
import 'package:mighty_school/feature/exam_management/exam_startup/controller/exam_startup_controller.dart';
import 'package:mighty_school/feature/exam_management/exam_startup/domain/model/merit_process_type_model.dart';
import 'package:mighty_school/feature/exam_management/exam_startup/presentation/widgets/merit_process_type_item_widget.dart';
import 'package:mighty_school/helper/responsive_helper.dart';


class MeritProcessTypeListWidget extends StatefulWidget {

  const MeritProcessTypeListWidget({super.key});

  @override
  State<MeritProcessTypeListWidget> createState() => _MeritProcessTypeListWidgetState();
}

class _MeritProcessTypeListWidgetState extends State<MeritProcessTypeListWidget> {
  @override
  void initState() {
    Get.find<ExamStartupController>().getMeritProcessTypeList(1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ExamStartupController>(
        builder: (examStartupController) {
          var meritType = examStartupController.meritProcessTypeModel?.data;
          MeritProcessTypeModel? meritProcessTypeModel = examStartupController.meritProcessTypeModel;
          return CustomContainer(
            child: Column(children: [

              if(ResponsiveHelper.isDesktop(context))
                const CustomTitle(title: "select_merit_process_type"),

              if(meritProcessTypeModel != null && meritProcessTypeModel.data!= null && meritProcessTypeModel.data!.data!.isNotEmpty)
                Expanded(
                  child: ListView.builder(
                      itemCount: meritType?.data?.length??0,
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemBuilder: (context, index){
                        return MeritProcessTypeItemWidget(index: index, meritProcessTypeItem: meritType?.data?[index]);
                      }),
                ),

              Align(alignment: Alignment.centerRight, child: SizedBox(width: 90,child: CustomButton(onTap: (){
                Get.back();
              }, text: "Confirm")))
            ],),
          );
        }
    );
  }
}
