import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_contaner.dart';
import 'package:mighty_school/common/widget/custom_divider.dart';
import 'package:mighty_school/feature/academic_configuration/subject/controller/subject_controller.dart';
import 'package:mighty_school/feature/academic_configuration/subject/domain/model/subject_model.dart';
import 'package:mighty_school/helper/responsive_helper.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';

class SubjectConfigItemWidget extends StatelessWidget {
  final SubjectItem? subjectItem;
  final int index;
  const SubjectConfigItemWidget({super.key, this.subjectItem, required this.index});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SubjectController>(
      builder: (subjectController) {
        return Padding(padding: const EdgeInsets.symmetric(vertical: 5),
          child: ResponsiveHelper.isDesktop(context)?
          Column(children: [
            Row( children: [
              SizedBox(child: Checkbox(value: subjectItem?.isSelected ?? false, onChanged: (val){
                subjectController.toggleSelectSubject(index);
              })),
              const SizedBox(width: Dimensions.paddingSizeSmall),
              Expanded(child: Text("${subjectItem?.subjectName}", style: textMedium.copyWith(fontSize: Dimensions.fontSizeDefault),)),
              const SizedBox(width: Dimensions.paddingSizeSmall),
              Expanded(child: Text(subjectItem?.subjectCode??'', style: textRegular.copyWith(),)),
            ]),
            const CustomDivider(verticalPadding: Dimensions.paddingSizeExtraSmall)
          ],
          ): CustomContainer(child: Row(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(child: Checkbox(value: false, onChanged: (val){})),
              const SizedBox(width: Dimensions.paddingSizeSmall),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text("${subjectItem?.subjectName}", style: textMedium.copyWith(fontSize: Dimensions.fontSizeDefault),),
                Text("${"code".tr} : ${subjectItem?.subjectCode??''}", style: textRegular.copyWith(),),
              ]),
              ),


            ],
          )),
        );
      }
    );
  }
}