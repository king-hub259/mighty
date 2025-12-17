import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/layout/list_layout_widget.dart';
import 'package:mighty_school/feature/quiz/quiz_result/controller/quiz_result_controller.dart';
import 'package:mighty_school/feature/quiz/quiz_result/domain/models/quiz_result_model.dart';
import 'package:mighty_school/feature/quiz/quiz_result/presentation/widgets/quiz_result_item_widget.dart';

class QuizResultListWidget extends StatelessWidget {
  final ScrollController scrollController;
  const QuizResultListWidget({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<QuizResultController>(
      initState: (val) => Get.find<QuizResultController>().getQuizResultList(),
      builder: (quizResultController) {
        final quizResultModel = quizResultController.quizResultModel;
        final quizResultData = quizResultModel?.data;

        return GenericListSection<QuizResulItem>(
          sectionTitle: "quiz".tr,
          pathItems: ["quiz_results".tr],
          headings: const ["title", "description", "timer", "show_answer", "action"],
          scrollController: scrollController,
          isLoading: quizResultModel == null,
          totalSize: quizResultData?.total ?? 0,
          offset: quizResultData?.currentPage ?? 0,
          onPaginate: (offset) async => await quizResultController.getQuizResultList(),
          items: quizResultData?.data ?? [],
          itemBuilder: (item, index) => QuizResultItemWidget(index: index, quizResulItem: item),
        );
      },
    );
  }
}
