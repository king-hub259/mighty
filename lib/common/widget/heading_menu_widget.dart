import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';

class HeadingMenu extends StatelessWidget {
  final List<String> headings;
  final List<int>? flex;

  const HeadingMenu({super.key, required this.headings, this.flex});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeSmall),
      child: Container(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault, horizontal: Dimensions.paddingSizeDefault),
        decoration: BoxDecoration(color: Theme.of(context).primaryColor.withValues(alpha: .2),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(Dimensions.radiusSmall))),
        child: Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge),
          child: Row(spacing:  Dimensions.paddingSizeDefault, children: [
               SizedBox(width: 20, child: Text("#", style: textMedium.copyWith(fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).primaryColor))),

              ...List.generate(headings.length, (index) {
                final textWidget = Text(headings[index].tr, style: textMedium.copyWith(fontSize: Dimensions.fontSizeDefault,
                    color: Theme.of(context).primaryColor));
                if (flex != null && flex!.length > index) {
                  return Expanded(flex: flex![index], child: textWidget);
                } else if (index == headings.length - 1) {
                  return textWidget;
                }else if(headings[index] == 'image'){
                  return textWidget;
                } else {
                  return Expanded(child: textWidget);
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}
