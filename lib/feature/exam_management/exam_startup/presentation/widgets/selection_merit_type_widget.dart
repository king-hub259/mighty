import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_contaner.dart';
import 'package:mighty_school/feature/exam_management/exam_startup/controller/exam_startup_controller.dart';
import 'package:mighty_school/feature/exam_management/exam_startup/presentation/widgets/merit_process_type_list_widget.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';

class SelectionMeritProcessTypeWidget extends StatelessWidget {
  const SelectionMeritProcessTypeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ExamStartupController>(
      builder: (examController) {
        return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          CustomContainer(onTap: ()=> Get.bottomSheet(const MeritProcessTypeListWidget()), height: 40,
              borderRadius: Dimensions.paddingSizeExtraSmall,
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text("select_type".tr, style: textRegular.copyWith(color: Theme.of(context).hintColor),),
               Icon(Icons.arrow_drop_down, size: 20, color: Theme.of(context).hintColor),
          ])),

            if(examController.selectedMeritProcessType != null)
              Padding(padding: const EdgeInsets.all(5.0),
                child: CustomContainer(borderRadius: Dimensions.paddingSizeExtraSmall,
                  child: Row(mainAxisSize: MainAxisSize.min, children: [
                    Text(examController.selectedMeritProcessType?.type ?? '',
                      style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall),),

                  ],
                  ),
                ),
              ),
          ],
        );
      }
    );
  }
}
