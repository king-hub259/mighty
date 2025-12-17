import 'package:flutter/material.dart';
import 'package:mighty_school/common/widget/custom_contaner.dart';
import 'package:mighty_school/common/widget/custom_divider.dart';
import 'package:mighty_school/common/widget/custom_text_field.dart';
import 'package:mighty_school/feature/exam_management/mark_input/domain/models/mark_input_model.dart';
import 'package:mighty_school/helper/responsive_helper.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';

class MarkInputStudentCardWidget extends StatelessWidget {
  final Students? students;
  final MarkConfigItem? markConfigItem;
  const MarkInputStudentCardWidget({super.key, this.students, this.markConfigItem});

  @override
  Widget build(BuildContext context) {
    return ResponsiveHelper.isDesktop(context)?
    Column(children: [
        Row( children: [
          Expanded(flex: 1, child: Text(students?.roll??'', style: textRegular.copyWith(fontSize: Dimensions.fontSizeDefault),)),
          const SizedBox(width: Dimensions.paddingSizeSmall),
        
          Expanded(flex: 2,child: Text(students?.name??'', style: textRegular.copyWith(fontSize: Dimensions.fontSizeDefault),)),
          const SizedBox(width: Dimensions.paddingSizeSmall),
          
          Expanded(flex: markConfigItem?.markConfig?.length?? 0,child: SizedBox(height: 40, child: ListView.builder(
            itemCount: markConfigItem?.markConfig?.length?? 0,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index){
              MarkConfig? markConfig =  markConfigItem?.markConfig?[index];
            return Padding(padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: SizedBox(width: 70, child: CustomTextField(hintText: "${markConfig?.markConfigExamCode?.passMark}",)),
            );
          }),)),
          
         
        ],),
        const CustomDivider(verticalPadding: Dimensions.paddingSizeSmall)
      ],
    ):
    CustomContainer(child: Column(children: [
      Row( children: [
        Expanded(child: Text(students?.roll??'', style: textRegular.copyWith(fontSize: Dimensions.fontSizeDefault),)),
        const SizedBox(width: Dimensions.paddingSizeSmall),

        Expanded(child: Text(students?.name??'', style: textRegular.copyWith(fontSize: Dimensions.fontSizeDefault),)),
        const SizedBox(width: Dimensions.paddingSizeSmall),

        Expanded(child: SizedBox(height: 50, child: ListView.builder(
            itemCount: markConfigItem?.markConfig?.length?? 0,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index){
              return const Expanded(child: CustomTextField());
            }),)),


      ],),

    ],),);
  }
}
