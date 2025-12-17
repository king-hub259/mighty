import 'package:flutter/material.dart';
import 'package:mighty_school/common/widget/custom_contaner.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';

class TaskSummeryCardWidget extends StatelessWidget {
  final Color? color;
  final String title;
  final String value;
  const TaskSummeryCardWidget({super.key, this.color, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return CustomContainer(showShadow: false, borderRadius: 8,
      color: color?? Theme.of(context).primaryColor,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
        const Icon(Icons.school, color: Colors.white, size: Dimensions.iconSizeDefault),
        Text(value, style:  textBold.copyWith(fontSize: Dimensions.fontSizeOverLarge,color: Colors.white,),),
        Text(title,style:  textRegular.copyWith(color: Colors.white,fontSize: Dimensions.fontSizeLarge)),
      ]),
    );
  }
}
