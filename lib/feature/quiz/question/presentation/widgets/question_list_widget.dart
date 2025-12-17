import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/layout/list_layout_widget.dart';
import 'package:mighty_school/feature/quiz/question/controller/question_controller.dart';
import 'package:mighty_school/feature/quiz/question/domain/models/question_model.dart';
import 'package:mighty_school/feature/quiz/question/presentation/widgets/create_new_question_widget.dart';
import 'package:mighty_school/feature/quiz/question/presentation/widgets/question_item_widget.dart';

class QuestionListWidget extends StatelessWidget {
  final ScrollController scrollController;
  const QuestionListWidget({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<QuestionController>(
      initState: (val) => Get.find<QuestionController>().getQuestionList(),
      builder: (questionController) {
        final questionModel = questionController.questionModel;
        final questionData = questionModel?.data;

        return GenericListSection<Questions>(
          sectionTitle: "quiz".tr,
          pathItems: ["questions".tr],
          addNewTitle: "add_new_question".tr,
          onAddNewTap: () => Get.dialog(const CreateNewQuestionWidget()),
          headings: const ["question", "option_a", "option_b", "option_c", "option_d", "correct_answer", "explanation", "action"],
          scrollController: scrollController,
          isLoading: questionModel == null,
          totalSize: questionData?.questions?.length ?? 0,
          offset: 1, // Questions don't have pagination in the current model
          onPaginate: (offset) async => await questionController.getQuestionList(),
          items: questionData?.questions ?? [],
          itemBuilder: (item, index) => QuestionItemWidget(index: index, questionItem: item),
        );
      },
    );
  }
}
