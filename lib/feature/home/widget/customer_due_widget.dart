import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/images.dart';
import 'package:mighty_school/util/styles.dart';


class CustomCardWidget extends StatelessWidget {
  final String? icon;
  final String? title;
  final String? subTitle;
  final double? price;
  final Color? color;
  final double? padding;
  final Color? textColor;
  final Function()? onTap;
  const CustomCardWidget({super.key, this.title, this.price, this.color, this.icon, this.textColor, this.padding, this.subTitle, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(onTap: onTap,
      child: Container(decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        boxShadow: [BoxShadow(color: Theme.of(context).primaryColor.withValues(alpha:.5), offset: const Offset(0, 1), blurRadius: 2, spreadRadius: 1)],
        color: color?? Theme.of(context).secondaryHeaderColor,
      ),padding:  EdgeInsets.symmetric(vertical: padding?? Dimensions.paddingSizeSmall, horizontal: Dimensions.paddingSizeSmall),
        width: Get.width,

        child: Row(children: [
          SizedBox(width: subTitle != null? 70 : 20, child: Image.asset(icon?? Images.pay)),
          const SizedBox(width: Dimensions.paddingSizeSmall,),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [
                  Expanded(child: Text(title??"today_fees_collection".tr, style: textMedium.copyWith(color: textColor,
                      fontSize: subTitle != null? Dimensions.fontSizeExtraOverLarge : Dimensions.fontSizeSmall))),
                  if(subTitle != null)
                  const Padding(padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraSmall),
                    child: Icon(Icons.arrow_forward_ios_rounded, size: 15,),
                  ),
                ],
              ),
              if(subTitle != null)
              Text(subTitle??"", style: textRegular.copyWith(color: textColor)),
            ],
          )),
          if(price != null)
          Text(price!.toStringAsFixed(0), style: textMedium.copyWith(color: textColor),)

        ],),
      ),
    );
  }
}
