import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';

class CustomTitle extends StatelessWidget {
  final String title;
  final bool isRequired;
  final double? fontSize;
  final FontWeight? fontWeight;
  final double? leftPadding;
  final Widget? widget;
  final bool webTitle;
  const CustomTitle({super.key, required this.title,  this.isRequired = false, this.fontSize, this.widget, this.fontWeight, this.leftPadding, this.webTitle = false});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(child: Row(children: [
        Padding(padding:  EdgeInsets.only(left: leftPadding??0),
            child: webTitle?
            Padding(padding:  EdgeInsets.only(left: leftPadding?? Dimensions.paddingSizeDefault),
                child: Text(title.tr, style: textSemiBold.copyWith(fontSize:  Dimensions.fontSizeOverLarge))):
            Text(title.tr, style: textRegular.copyWith(fontSize: fontSize?? Dimensions.fontSizeDefault, fontWeight: fontWeight))
        ),
        if(isRequired)
          Text('*',style: textSemiBold.copyWith( fontSize: Dimensions.fontSizeDefault),),

      ])),

      const SizedBox(width: Dimensions.paddingSizeSmall),
      widget??const SizedBox()
    ],
    );
  }
}
class CustomSubTitle extends StatelessWidget {
  final String title;
  const CustomSubTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(title.tr, style: textMedium.copyWith(fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).textTheme.bodyMedium?.color),);
  }
}