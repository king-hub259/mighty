import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_contaner.dart';
import 'package:mighty_school/feature/parent_module/parent_exam/domain/model/parent_exam_model.dart';
import 'package:mighty_school/feature/parent_module/parent_exam/presentation/screens/parent_exam_result_screen.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';

class ParentExamItemWidget extends StatelessWidget {
  final ParentExamItem? examItem;
  final int index;
  const ParentExamItemWidget({super.key, this.examItem, required this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault, vertical: Dimensions.paddingSizeSeven),
      child: CustomContainer(
        onTap: ()=> Get.to(()=> ParentExamResultScreen(examId: examItem!.examId!)),
        showShadow: false, borderColor: Theme.of(context).hintColor.withAlpha(50), borderRadius: Dimensions.paddingSizeExtraSmall,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text("${examItem?.exam?.name}", style: textSemiBold.copyWith(fontSize: Dimensions.fontSizeLarge),),
            Text("${examItem?.meritType?.type}", style: textRegular.copyWith(fontSize: Dimensions.fontSizeDefault),),
            Text("${"position".tr}: ${examItem?.meritType?.serial}", style: textMedium.copyWith(fontSize: Dimensions.fontSizeDefault),),
            Text("view_result".tr, style: textMedium.copyWith(fontSize: Dimensions.fontSizeDefault),),
          ]),
      ));
  }
}