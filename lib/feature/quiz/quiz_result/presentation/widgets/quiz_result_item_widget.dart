import 'package:flutter/material.dart';
import 'package:mighty_school/common/widget/edit_delete_section.dart';
import 'package:mighty_school/common/widget/numbering_widget.dart';
import 'package:mighty_school/feature/quiz/quiz_result/domain/models/quiz_result_model.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';

class QuizResultItemWidget extends StatelessWidget {
  final QuizResulItem quizResulItem;
  final int index;
  const QuizResultItemWidget({super.key, required this.quizResulItem, required this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.fromLTRB(Dimensions.paddingSizeDefault, Dimensions.paddingSizeDefault, Dimensions.paddingSizeDefault, 0),
      child: Row(spacing: Dimensions.paddingSizeDefault, crossAxisAlignment: CrossAxisAlignment.start, children: [

        NumberingWidget(index: index),
        Expanded(child: Text("${quizResulItem.title}", maxLines: 1, overflow: TextOverflow.ellipsis, style: textRegular.copyWith())),
        Expanded(child: Text(quizResulItem.description ?? '', maxLines: 1, overflow: TextOverflow.ellipsis, style: textRegular.copyWith())),
        Expanded(child: Text(quizResulItem.timer ?? '', style: textRegular.copyWith())),
        Expanded(child: Text(quizResulItem.showAns ?? '', style: textRegular.copyWith())),
        EditDeleteSection(horizontal: true, onDelete: (){
          // No delete functionality for quiz results
        }, onEdit: (){
          // No edit functionality for quiz results
        },)
      ],
      ),
    );
  }
}