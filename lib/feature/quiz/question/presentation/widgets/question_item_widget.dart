import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/edit_delete_section.dart';
import 'package:mighty_school/common/widget/numbering_widget.dart';
import 'package:mighty_school/feature/quiz/question/controller/question_controller.dart';
import 'package:mighty_school/feature/quiz/question/domain/models/question_model.dart';
import 'package:mighty_school/feature/quiz/question/presentation/widgets/create_new_question_widget.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';

class QuestionItemWidget extends StatelessWidget {
  final Questions questionItem;
  final int index;
  const QuestionItemWidget({super.key, required this.questionItem, required this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.fromLTRB(Dimensions.paddingSizeDefault, Dimensions.paddingSizeDefault, Dimensions.paddingSizeDefault, 0),
      child: Row(spacing: Dimensions.paddingSizeDefault, crossAxisAlignment: CrossAxisAlignment.start, children: [

        NumberingWidget(index: index),
        Expanded(child: Text("${questionItem.question}", maxLines: 1, overflow: TextOverflow.ellipsis, style: textRegular.copyWith())),
        Expanded(child: Text(questionItem.a ?? '', maxLines: 1, overflow: TextOverflow.ellipsis, style: textRegular.copyWith())),
        Expanded(child: Text(questionItem.b ?? '', maxLines: 1, overflow: TextOverflow.ellipsis, style: textRegular.copyWith())),
        Expanded(child: Text(questionItem.c ?? '', maxLines: 1, overflow: TextOverflow.ellipsis, style: textRegular.copyWith())),
        Expanded(child: Text(questionItem.d ?? '', maxLines: 1, overflow: TextOverflow.ellipsis, style: textRegular.copyWith())),
        Expanded(child: Text(questionItem.answer ?? '', style: textRegular.copyWith())),
        Expanded(child: Text(questionItem.answerExp ?? '', maxLines: 1, overflow: TextOverflow.ellipsis, style: textRegular.copyWith())),
        EditDeleteSection(horizontal: true, onDelete: (){
          Get.find<QuestionController>().deleteQuestion(questionItem.id!);
        }, onEdit: (){
          Get.dialog(CreateNewQuestionWidget(questionItem: questionItem));
        },)
      ],
      ),
    );
  }
}