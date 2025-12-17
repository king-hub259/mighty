import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/layout/list_layout_widget.dart';
import 'package:mighty_school/feature/quiz/quiz_topic/controller/quiz_topic_controller.dart';
import 'package:mighty_school/feature/quiz/quiz_topic/domain/models/quiz_topic_model.dart';
import 'package:mighty_school/feature/quiz/quiz_topic/presentation/widgets/quiz_topic_item_widget.dart';

class QuestionTopicListWidget extends StatelessWidget {
  final ScrollController scrollController;
  const QuestionTopicListWidget({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<QuizTopicController>(
      initState: (val) => Get.find<QuizTopicController>().getQuizList(1),
      builder: (quizTopicController) {
        final quizTopicModel = quizTopicController.quizTopicModel;
        final quizTopicData = quizTopicModel?.data;

        return GenericListSection<QuizTopicItem>(
          sectionTitle: "quiz".tr,
          pathItems: ["select_topic".tr],
          addNewTitle: null, // No add button for topic selection
          onAddNewTap: null,
          headings: const ["topic", "description", "marks", "timer"],
          scrollController: scrollController,
          isLoading: quizTopicModel == null,
          totalSize: quizTopicData?.total ?? 0,
          offset: quizTopicData?.currentPage ?? 0,
          onPaginate: (offset) async => await quizTopicController.getQuizList(offset ?? 1),
          items: quizTopicData?.data ?? [],
          itemBuilder: (item, index) => QuizTopicItemWidget(
            index: index,
            fromQuestion: true,
            quizTopicItem: item,
          ),
        );
      },
    );
  }
}
