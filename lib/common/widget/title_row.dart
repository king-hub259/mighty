import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';



class TitleRowWidget extends StatelessWidget {
  final String? title;
  final Function? icon;
  final Function()? onTap;
  final double? padding;
  const TitleRowWidget({super.key, required this.title,this.icon, this.onTap, this.padding});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeDefault, top: Dimensions.paddingSizeLarge),
      child: Row( children: [

        Expanded(
          child: Padding(padding: EdgeInsets.symmetric(horizontal: padding?? Dimensions.paddingSizeDefault),
            child: Text(title!.tr, style: textMedium.copyWith(fontSize: Get.width * 0.044,
                color: Theme.of(context).textTheme.bodyLarge?.color))),
        ),

        InkWell(onTap: onTap,
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
             Text("View All", style: textRegular.copyWith(color : Theme.of(context).primaryColor, fontSize: Dimensions.fontSizeDefault)),
          ]),
        )
      ]),
    );
  }
}


