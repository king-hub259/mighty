import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/layout/list_layout_widget.dart';
import 'package:mighty_school/feature/quiz/answer/controller/answer_controller.dart';
import 'package:mighty_school/feature/quiz/answer/domain/models/answer_model.dart';
import 'package:mighty_school/feature/quiz/answer/presentation/widgets/answer_item_widget.dart';

class AnswerListWidget extends StatelessWidget {
  final ScrollController scrollController;
  const AnswerListWidget({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AnswerController>(
      initState: (val) => Get.find<AnswerController>().getAnswerList(),
      builder: (answerController) {
        final answerModel = answerController.answerModel;
        final answerData = answerModel?.data;

        return GenericListSection<AnswerItem>(
          sectionTitle: "quiz".tr,
          pathItems: ["answers".tr],
          headings: const ["student_name", "question", "student_answer", "correct_answer", "action"],
          scrollController: scrollController,
          isLoading: answerModel == null,
          totalSize: answerData?.total ?? 0,
          offset: answerData?.currentPage ?? 0,
          onPaginate: (offset) async => await answerController.getAnswerList(),
          items: answerData?.data ?? [],
          itemBuilder: (item, index) => AnswerItemWidget(index: index, answerItem: item),
        );
      },
    );
  }
}
