import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_contaner.dart';
import 'package:mighty_school/common/widget/custom_title.dart';
import 'package:mighty_school/feature/exam_management/exam/controller/exam_controller.dart';
import 'package:mighty_school/feature/exam_management/exam/presentation/widgets/exam_list_widget.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';

class SelectionExamWidget extends StatelessWidget {
  final String? title;
  const SelectionExamWidget({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ExamController>(
      builder: (examController) {
        return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          if(title != null)...[
            CustomTitle(title: title!),
            const SizedBox(height: Dimensions.paddingSizeSmall),
          ],

          CustomContainer(onTap: ()=> Get.bottomSheet(const ExamListWidget()), height: 40,
              borderRadius: Dimensions.paddingSizeExtraSmall,
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text("select_exam".tr, style: textRegular.copyWith(color: Theme.of(context).hintColor),),
               Icon(Icons.arrow_drop_down, size: 20, color: Theme.of(context).hintColor),
          ])),

            if(examController.selectedExamList.isNotEmpty)
            Wrap(spacing: 8.0, runSpacing: 4.0,
            children: List.generate(examController.selectedExamList.length, (index) {
              return Padding(padding: const EdgeInsets.all(5.0),
                child: CustomContainer(borderRadius: Dimensions.paddingSizeExtraSmall,
                  child: Row(mainAxisSize: MainAxisSize.min, children: [
                      Text(examController.selectedExamList[index].name ?? '',
                        style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall),),
                     InkWell(onTap: ()=> examController.removeSelectedExam(index),
                         child: Icon(Icons.clear, size: 15, color: Theme.of(context).hintColor)),
                    ],
                  ),
                ),
              );
            }),
            ),
          ],
        );
      }
    );
  }
}
