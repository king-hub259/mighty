import 'package:flutter/material.dart';
import 'package:mighty_school/common/widget/custom_contaner.dart';
import 'package:mighty_school/common/widget/custom_divider.dart';
import 'package:mighty_school/feature/exam_management/exam_result/domain/models/exam_result_model.dart';
import 'package:mighty_school/helper/responsive_helper.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';

class ExamResultItemWidget extends StatelessWidget {
  final ResultItem? resultItem;
  const ExamResultItemWidget({super.key, this.resultItem});

  @override
  Widget build(BuildContext context) {
    return ResponsiveHelper.isDesktop(context)?
    Column(children: [
        Row( children: [
        Expanded(child: Text(resultItem?.exam?.name??'', style: textRegular.copyWith(fontSize: Dimensions.fontSizeDefault),)),
          const SizedBox(width: Dimensions.paddingSizeSmall),
          Expanded(child: Text(resultItem?.student?.firstName??'', style: textRegular.copyWith(fontSize: Dimensions.fontSizeDefault),)),
          const SizedBox(width: Dimensions.paddingSizeSmall),
          Expanded(child: Text(resultItem?.gradePoint??'', style: textRegular.copyWith(fontSize: Dimensions.fontSizeDefault),)),
          const SizedBox(width: Dimensions.paddingSizeSmall),
          Expanded(child: Text(resultItem?.grade??'', style: textRegular.copyWith(fontSize: Dimensions.fontSizeDefault),)),
        ],),
        const CustomDivider(verticalPadding: Dimensions.paddingSizeSmall)
      ],
    ):
    CustomContainer(child: Column(children: [
      Row(children: [
          Expanded(child: Column(children: [
              Text(resultItem?.exam?.name??"", style: textRegular.copyWith(fontSize: Dimensions.fontSizeDefault),),
              Row(children: [
                Expanded(child: Text(resultItem?.student?.firstName??'', style: textRegular.copyWith(fontSize: Dimensions.fontSizeDefault),)),
                const SizedBox(width: Dimensions.paddingSizeSmall),
                Expanded(child: Text(resultItem?.gradePoint??'', style: textRegular.copyWith(fontSize: Dimensions.fontSizeDefault),)),
              ],)
            ],
          )),
          Expanded(child: Text(resultItem?.grade??'', style: textRegular.copyWith(fontSize: Dimensions.fontSizeDefault),)),
        ],
      ),

    ],),);
  }
}
