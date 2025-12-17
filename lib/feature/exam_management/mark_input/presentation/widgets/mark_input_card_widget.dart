import 'package:flutter/material.dart';
import 'package:mighty_school/common/widget/custom_contaner.dart';
import 'package:mighty_school/common/widget/custom_divider.dart';
import 'package:mighty_school/feature/exam_management/mark_input/domain/models/mark_input_model.dart';
import 'package:mighty_school/helper/responsive_helper.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';

class MarkInputCardWidget extends StatelessWidget {
  final MarkConfig? markConfig;
  const MarkInputCardWidget({super.key, this.markConfig});

  @override
  Widget build(BuildContext context) {
    return ResponsiveHelper.isDesktop(context)?
    Column(children: [
        Row( children: [
        Expanded(child: Text(markConfig?.markConfigExamCode?.title??'', style: textRegular.copyWith(fontSize: Dimensions.fontSizeDefault),)),
          const SizedBox(width: Dimensions.paddingSizeSmall),
          Expanded(child: Text(markConfig?.markConfigExamCode?.totalMarks??'', style: textRegular.copyWith(fontSize: Dimensions.fontSizeDefault),)),
          const SizedBox(width: Dimensions.paddingSizeSmall),
          Expanded(child: Text(markConfig?.markConfigExamCode?.passMark??'', style: textRegular.copyWith(fontSize: Dimensions.fontSizeDefault),)),
          const SizedBox(width: Dimensions.paddingSizeSmall),
          Expanded(child: Text(markConfig?.markConfigExamCode?.acceptance??'', style: textRegular.copyWith(fontSize: Dimensions.fontSizeDefault),)),
        ],),
        const CustomDivider(verticalPadding: Dimensions.paddingSizeSmall)
      ],
    ):
    CustomContainer(child: Column(children: [
      Row(children: [
          Expanded(child: Column(children: [
              Text(markConfig?.markConfigExamCode?.title??'', style: textRegular.copyWith(fontSize: Dimensions.fontSizeDefault),),
              Row(children: [
                Expanded(child: Text(markConfig?.markConfigExamCode?.totalMarks??'', style: textRegular.copyWith(fontSize: Dimensions.fontSizeDefault),)),
                const SizedBox(width: Dimensions.paddingSizeSmall),
                Expanded(child: Text(markConfig?.markConfigExamCode?.passMark??'', style: textRegular.copyWith(fontSize: Dimensions.fontSizeDefault),)),
              ],)
            ],
          )),
          Expanded(child: Text(markConfig?.markConfigExamCode?.acceptance??'', style: textRegular.copyWith(fontSize: Dimensions.fontSizeDefault),)),
        ],
      ),

    ],),);
  }
}
