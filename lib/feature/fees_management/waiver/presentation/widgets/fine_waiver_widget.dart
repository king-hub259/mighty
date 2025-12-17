import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_button.dart';
import 'package:mighty_school/common/widget/custom_contaner.dart';
import 'package:mighty_school/feature/academic_configuration/class/presentation/widgets/select_class_widget.dart';
import 'package:mighty_school/feature/exam_management/exam_startup/presentation/widgets/select_section_widget.dart';
import 'package:mighty_school/feature/fees_management/waiver/controller/waiver_controller.dart';
import 'package:mighty_school/util/dimensions.dart';

class FineWaiverWidget extends StatelessWidget {
  const FineWaiverWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WaiverController>(
        builder: (waiverConfigController) {
          return CustomContainer(
            child: Column(children: [
              Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
                const Expanded(child: SelectClassWidget()),
                const SizedBox(width: Dimensions.paddingSizeSmall),

                const Expanded(child: SelectSectionWidget()),
                const SizedBox(width: Dimensions.paddingSizeSmall),

                Padding(padding: const EdgeInsets.only(bottom: 8),
                    child: SizedBox(width: 90, child: CustomButton(onTap: (){}, text: "process")))
              ]),




            ],),
          );
        }
    );
  }
}
