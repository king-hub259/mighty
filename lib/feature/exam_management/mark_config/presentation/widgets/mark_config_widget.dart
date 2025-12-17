import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_contaner.dart';
import 'package:mighty_school/feature/exam_management/mark_config/controller/mark_config_controller.dart';
import 'package:mighty_school/feature/exam_management/mark_config/presentation/widgets/general_exam_widget.dart';
import 'package:mighty_school/feature/exam_management/mark_config/presentation/widgets/grand_final_widget.dart';
import 'package:mighty_school/feature/exam_management/mark_config/presentation/widgets/mark_config_type_selection_widget.dart';
import 'package:mighty_school/feature/exam_management/mark_config/presentation/widgets/mark_config_view_widget.dart';
import 'package:mighty_school/util/dimensions.dart';

class MarkConfigWidget extends StatefulWidget {
  final ScrollController scrollController;
  const MarkConfigWidget({super.key, required this.scrollController});

  @override
  State<MarkConfigWidget> createState() => _MarkConfigWidgetState();
}

class _MarkConfigWidgetState extends State<MarkConfigWidget> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MarkConfigController>(
      builder: (markConfigController) {
        return CustomContainer(borderRadius: Dimensions.paddingSizeExtraSmall,
            child: Column(spacing: Dimensions.paddingSizeDefault, children: [
              const MarkConfigTypeSelectionWidget(),

              if(markConfigController.markConfigTypeIndex == 0)...[
                GeneralExamWidget(scrollController: widget.scrollController),
              ]else if(markConfigController.markConfigTypeIndex == 1)...[
                GrandFinalWidget(scrollController: widget.scrollController),
                ]else...[MarkConfigViewWidget(scrollController: widget.scrollController)]

            ],));
      }
    );
  }
}
