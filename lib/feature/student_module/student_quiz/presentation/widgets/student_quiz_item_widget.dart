import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/feature/student_module/student_quiz/domain/models/student_quiz_model.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';

class StudentQuizItemWidget extends StatelessWidget {
  final Topics? topics;
  final int index;
  const StudentQuizItemWidget({super.key, this.topics, required this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.fromLTRB(Dimensions.paddingSizeDefault, Dimensions.paddingSizeDefault, Dimensions.paddingSizeDefault, 0),
      child: Container(decoration: ThemeShadow.getDecoration(),
          padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
          child: Row(
            children: [
              CircleAvatar(backgroundColor: index%2==0?
              Theme.of(context).primaryColor : index%3==0? const Color(0xFFFD7F01) :
              const Color(0xFF00B1FE), child: Text("${index+1}")),
              const SizedBox(width: Dimensions.paddingSizeSmall),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text("${topics?.title}", style: textMedium.copyWith(fontSize: Dimensions.fontSizeDefault),),
                 if(topics?.description != null)
                  Text("${"details".tr} : ${topics?.description??''}",maxLines: 1, style: textRegular.copyWith(),),
                Text(topics?.amount??"0", style: textMedium.copyWith(fontSize: Dimensions.fontSizeLarge),),
                ]),
              ),
              Column(children: [
                Icon(Icons.timer_outlined, size: 20,color: Theme.of(context).primaryColor.withValues(alpha :.7)),
                Text("${topics?.timer??'0'}m")
              ],)
            ],
      )),
    );
  }
}