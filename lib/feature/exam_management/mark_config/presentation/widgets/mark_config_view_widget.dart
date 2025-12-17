import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_button.dart';
import 'package:mighty_school/common/widget/custom_divider.dart';
import 'package:mighty_school/feature/academic_configuration/class/presentation/widgets/select_class_widget.dart';
import 'package:mighty_school/feature/exam_management/exam/presentation/widgets/exam_selection_widget.dart';
import 'package:mighty_school/feature/exam_management/mark_config/controller/mark_config_controller.dart';
import 'package:mighty_school/feature/academic_configuration/group/presentation/widgets/select_group_widget.dart';
import 'package:mighty_school/helper/responsive_helper.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';

class MarkConfigViewWidget extends StatefulWidget {
  final ScrollController scrollController;
  const MarkConfigViewWidget({super.key, required this.scrollController});

  @override
  State<MarkConfigViewWidget> createState() => _MarkConfigViewWidgetState();
}

class _MarkConfigViewWidgetState extends State<MarkConfigViewWidget> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MarkConfigController>(
        builder: (markConfigController) {

          return Column(children: [

            if(ResponsiveHelper.isDesktop(context))...[

              Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
                const Expanded(child: SelectClassWidget()),
                const SizedBox(width: Dimensions.paddingSizeSmall),

                const Expanded(child: SelectGroupWidget()),
                const SizedBox(width: Dimensions.paddingSizeSmall),

                const Expanded(child: ExamSelectionWidget()),
                const SizedBox(width: Dimensions.paddingSizeSmall),
                SizedBox(width: 90, child: Padding(padding: const EdgeInsets.only(bottom: 8.0), child: CustomButton(onTap: (){}, text: "search".tr)))
              ]),


              Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault, vertical: Dimensions.paddingSizeSeven),
                child: Row(children: [

                  const SizedBox(width: Dimensions.paddingSizeSmall),
                  Expanded(child: Text("title".tr, style: textMedium.copyWith(fontSize: Dimensions.fontSizeDefault),)),
                  const SizedBox(width: Dimensions.paddingSizeSmall),

                  Expanded(child: Text("total_mark".tr, style: textMedium.copyWith(fontSize: Dimensions.fontSizeDefault),)),
                  const SizedBox(width: Dimensions.paddingSizeSmall),

                  Expanded(child: Text("pass_mark".tr, style: textMedium.copyWith(fontSize: Dimensions.fontSizeDefault),)),
                  const SizedBox(width: Dimensions.paddingSizeSmall),

                  Expanded(child: Text("accept_percent".tr, style: textMedium.copyWith(fontSize: Dimensions.fontSizeDefault),)),
                  const SizedBox(width: Dimensions.paddingSizeSmall),
                ],
                ),
              ),
              const CustomDivider(),
            ],


          ],);
        }
    );
  }
}
