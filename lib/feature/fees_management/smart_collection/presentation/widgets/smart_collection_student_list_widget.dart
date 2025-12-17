import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_button.dart';
import 'package:mighty_school/common/widget/custom_contaner.dart';
import 'package:mighty_school/common/widget/no_data_found.dart';
import 'package:mighty_school/feature/academic_configuration/class/controller/class_controller.dart';
import 'package:mighty_school/feature/academic_configuration/class/presentation/widgets/select_class_widget.dart';
import 'package:mighty_school/feature/academic_configuration/section/controller/section_controller.dart';
import 'package:mighty_school/feature/academic_configuration/section/presentation/widgets/select_section_widget.dart';
import 'package:mighty_school/feature/fees_management/smart_collection/controller/smart_collection_controller.dart';
import 'package:mighty_school/feature/fees_management/smart_collection/presentation/widgets/smart_collection_student_item.dart';
import 'package:mighty_school/helper/responsive_helper.dart';
import 'package:mighty_school/util/dimensions.dart';

class SmartCollectionStudentListWidget extends StatelessWidget {
  const SmartCollectionStudentListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      child: Column(children: [

        if(ResponsiveHelper.isDesktop(context))...[
          Row(crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Expanded(child: SelectClassWidget()),
              const SizedBox(width: Dimensions.paddingSizeDefault,),

              const Expanded(child: SelectSectionWidget()),
              const SizedBox(width: Dimensions.paddingSizeDefault,),
              Padding(padding: const EdgeInsets.only(bottom: 8.0),
                child: GetBuilder<SmartCollectionController>(
                    builder: (studentController) {
                      return SizedBox(width: 90, child: CustomButton(onTap: (){
                        studentController.getStudentListForSmartCollection(Get.find<ClassController>().selectedClassItem!.id!,  Get.find<SectionController>().selectedSectionItem!.id!, 1);
                      }, text: "search", innerPadding: EdgeInsets.zero,));
                    }
                ),
              )
            ],
          ),
        ]else...[

          const SelectClassWidget(),

          Row(crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Expanded(child: SelectSectionWidget()),
              const SizedBox(width: Dimensions.paddingSizeDefault,),
              Padding(padding: const EdgeInsets.only(bottom: 8.0),
                child: GetBuilder<SmartCollectionController>(
                    builder: (studentController) {
                      return SizedBox(width: 90, child: CustomButton(onTap: (){
                        studentController.getStudentListForSmartCollection(Get.find<ClassController>().selectedClassItem!.id!, Get.find<SectionController>().selectedSectionItem!.id!, 1);
                      }, text: "search", innerPadding: EdgeInsets.zero,));
                    }
                ))
            ],
          ),

        ],
        const SizedBox(height: Dimensions.paddingSizeDefault),



        GetBuilder<SmartCollectionController>(
            builder: (smartCollectionController) {
              var student = smartCollectionController.smartCollectionModel?.data?.students?.data;
              return Column(children: [
                smartCollectionController.smartCollectionModel != null? (smartCollectionController.smartCollectionModel?.data?.students?.data != null && smartCollectionController.smartCollectionModel!.data!.students!.data!.isNotEmpty)?
                ListView.builder(
                    itemCount: student?.length??0,
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index){
                      return SmartCollectionStudentItemWidget(studentItem: student?[index], index: index,);
                    }):
                Padding(padding: EdgeInsets.only(top: Get.height/8),
                  child: const Center(child: NoDataFound()),
                ):
                const SizedBox(),
              ],);
            }
        )
      ]),
    );
  }
}
