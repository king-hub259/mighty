import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_divider.dart';
import 'package:mighty_school/feature/exam_management/exam_startup/controller/exam_startup_controller.dart';
import 'package:mighty_school/feature/exam_management/exam_startup/domain/model/merit_process_type_model.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';

class MeritProcessTypeItemWidget extends StatelessWidget {
  final MeritProcessTypeItem? meritProcessTypeItem;
  final int index;
  const MeritProcessTypeItemWidget({super.key, this.meritProcessTypeItem, required this.index});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
        Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault, vertical: Dimensions.paddingSizeSeven),
          child: Row(children: [
              SizedBox(width: 15, height: 15, child: Checkbox(value: meritProcessTypeItem?.isSelected??false,
                  onChanged: (val){
                Get.find<ExamStartupController>().toggleMeritProcessType(index);
                  })),
              const SizedBox(width: Dimensions.paddingSizeSmall),
              Expanded(child: Text("${meritProcessTypeItem?.type}", style: textRegular.copyWith(fontSize: Dimensions.fontSizeDefault),)),
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