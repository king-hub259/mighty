import 'package:flutter/material.dart';
import 'package:mighty_school/feature/parent_module/children/domain/model/behavior_model.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';

class BehaviourItemWidget extends StatelessWidget {
  final BehaviorItem? behaviorItem;
  final int index;
  const BehaviourItemWidget({super.key, this.behaviorItem, required this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: Dimensions.paddingSizeSmall),
      child: Container(decoration: BoxDecoration(color: index%2==1? const Color(0xFFDDFDE9): const Color(0xFFFDF6DC)),
        child: Padding(padding: const EdgeInsets.all(8),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text("${behaviorItem?.title}", style: textMedium.copyWith(fontSize: Dimensions.fontSizeDefault),),
            Text(" ${behaviorItem?.note??''}", style: textRegular.copyWith(), maxLines: 5,),
          ]))),
    );
  }
}