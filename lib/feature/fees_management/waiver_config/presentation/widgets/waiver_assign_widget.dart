import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_button.dart';
import 'package:mighty_school/feature/exam_management/exam_startup/presentation/widgets/select_section_widget.dart';
import 'package:mighty_school/feature/academic_configuration/group/presentation/widgets/select_group_widget.dart';
import 'package:mighty_school/feature/academic_configuration/session/presentation/widgets/session_selection_widget.dart';
import 'package:mighty_school/feature/academic_configuration/student_categories/presentation/widgets/select_student_category_widget.dart';
import 'package:mighty_school/feature/fees_management/waiver/controller/waiver_controller.dart';
import 'package:mighty_school/helper/responsive_helper.dart';
import 'package:mighty_school/util/dimensions.dart';

class WaiverAssignWidget extends StatelessWidget {
  const WaiverAssignWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WaiverController>(
        builder: (waiverConfigController) {
          return Column(children: [
            ResponsiveHelper.isDesktop(context)?
            Row(crossAxisAlignment: CrossAxisAlignment.end, spacing: Dimensions.paddingSizeSmall, children: [
              const Expanded(child: SelectSessionWidget()),
              const Expanded(child: SelectGroupWidget()),
              const Expanded(child: SelectSectionWidget()),
              const Expanded(child: SelectStudentCategoryWidget()),
              Padding(padding: const EdgeInsets.only(bottom: 8),
                child: SizedBox(width: 90, child: CustomButton(onTap: (){}, text: "process")))
            ]):
            Column( children: [
                const Row(crossAxisAlignment: CrossAxisAlignment.end, spacing: Dimensions.paddingSizeSmall, children: [
                  Expanded(child: SelectSessionWidget()),
                  Expanded(child: SelectGroupWidget()),

               ]),
                Row(crossAxisAlignment: CrossAxisAlignment.end, spacing: Dimensions.paddingSizeSmall, children: [
                  const Expanded(child: SelectSectionWidget()),
                  const Expanded(child: SelectStudentCategoryWidget()),
                  Padding(padding: const EdgeInsets.only(bottom: 8),
                      child: SizedBox(width: 90, child: CustomButton(onTap: (){}, text: "process")))
                ]),
              ],
            ),




          ],);
        }
    );
  }
}
