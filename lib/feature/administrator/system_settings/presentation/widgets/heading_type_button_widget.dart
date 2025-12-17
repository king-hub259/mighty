import 'package:flutter/material.dart';
import 'package:mighty_school/common/widget/custom_contaner.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';

class HeadingTypeButtonWidget extends StatelessWidget {
  final Function()? onTap;
  final bool selected;
  final String title;
  const HeadingTypeButtonWidget({super.key, this.onTap, this.selected = false, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
      child: CustomContainer(color: selected? Theme.of(context).primaryColor.withValues(alpha: .25) : Theme.of(context).hintColor,
          borderRadius: Dimensions.paddingSizeExtraSmall, showShadow: false, verticalPadding: 0,
        onTap: onTap,
        borderColor: selected? Theme.of(context).hintColor : null,
        border: Border.all(color: selected? Theme.of(context).primaryColor : Theme.of(context).hintColor),
        child:  Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall, vertical: Dimensions.paddingSizeExtraSmall),
          child: Center(child: Text(title, style: textRegular.copyWith(color: selected? Theme.of(context).primaryColor : null))))),
    );
  }
}
