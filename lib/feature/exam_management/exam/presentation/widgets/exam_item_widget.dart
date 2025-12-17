import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_divider.dart';
import 'package:mighty_school/feature/exam_management/exam/controller/exam_controller.dart';
import 'package:mighty_school/feature/exam_management/exam/domain/model/exam_model.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';

class ExamItemWidget extends StatelessWidget {
  final ExamItem? examItem;
  final int index;
  const ExamItemWidget({super.key, this.examItem, required this.index});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
        Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault, vertical: Dimensions.paddingSizeSeven),
          child: Row(children: [
              SizedBox(width: 15, height: 15, child: Checkbox(value: examItem?.isSelected??false,
                  onChanged: (val){
                Get.find<ExamController>().toggleExam(index);
                  })),
              const SizedBox(width: Dimensions.paddingSizeSmall),
              Expanded(child: Text("${examItem?.name}", style: textRegular.copyWith(fontSize: Dimensions.fontSizeDefault),)),
            const SizedBox(width: Dimensions.paddingSizeSmall),

            ],
          ),
        ),
        const Padding(padding: EdgeInsets.symmetric(vertical: Dimensions.paddingSizeExtraSmall),
          child: CustomDivider()),
      ],
    );
  }
}