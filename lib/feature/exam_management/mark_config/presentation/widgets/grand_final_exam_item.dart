import 'package:flutter/material.dart';
import 'package:mighty_school/common/widget/custom_divider.dart';
import 'package:mighty_school/common/widget/edit_delete_section.dart';
import 'package:mighty_school/feature/exam_management/exam/domain/model/exam_model.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';

class GrandFinalExamItemWidget extends StatelessWidget {
  final ExamItem? examItem;
  final int index;
  const GrandFinalExamItemWidget({super.key, this.examItem, required this.index});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault, vertical: Dimensions.paddingSizeSeven),
        child: Row(children: [

          Text("${index+1}. ", style: textSemiBold.copyWith(fontSize: Dimensions.fontSizeDefault),),
          Expanded(child: Text("${examItem?.name}", style: textRegular.copyWith(fontSize: Dimensions.fontSizeDefault),)),
          const SizedBox(width: Dimensions.paddingSizeSmall),

          EditDeleteSection(horizontal: true, onEdit: (){},)

        ],
        ),
      ),
      const CustomDivider(verticalPadding: Dimensions.paddingSizeExtraSmall,),
    ],
    );
  }
}