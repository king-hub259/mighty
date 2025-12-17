import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/edit_delete_section.dart';
import 'package:mighty_school/common/widget/numbering_widget.dart';
import 'package:mighty_school/feature/quiz/answer/controller/answer_controller.dart';
import 'package:mighty_school/feature/quiz/answer/domain/models/answer_model.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';

class AnswerItemWidget extends StatelessWidget {
  final AnswerItem answerItem;
  final int index;
  const AnswerItemWidget({super.key, required this.answerItem, required this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.fromLTRB(Dimensions.paddingSizeDefault, Dimensions.paddingSizeDefault, Dimensions.paddingSizeDefault, 0),
      child: Row(spacing: Dimensions.paddingSizeDefault, crossAxisAlignment: CrossAxisAlignment.start, children: [

        NumberingWidget(index: index),
        Expanded(child: Text("${answerItem.userId}", maxLines: 1, overflow: TextOverflow.ellipsis, style: textRegular.copyWith())),
        Expanded(child: Text(answerItem.questionId ?? '', maxLines: 1, overflow: TextOverflow.ellipsis, style: textRegular.copyWith())),
        Expanded(child: Text(answerItem.userAnswer ?? '', maxLines: 1, overflow: TextOverflow.ellipsis, style: textRegular.copyWith())),
        Expanded(child: Text(answerItem.answer ?? '', maxLines: 1, overflow: TextOverflow.ellipsis, style: textRegular.copyWith())),
        EditDeleteSection(horizontal: true, onDelete: (){
          Get.find<AnswerController>().deleteAnswer(answerItem.id!);
        }, onEdit: (){
          // No edit functionality for answers
        },)
      ],
      ),
    );
  }
}