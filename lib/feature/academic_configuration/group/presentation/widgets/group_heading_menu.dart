import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';

class GroupHeadingMenu extends StatelessWidget {
  const GroupHeadingMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return  Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge),
        child: Row(spacing: Dimensions.paddingSizeDefault,  children: [
          Text("#".tr, style: textMedium.copyWith(fontSize: Dimensions.fontSizeDefault)),
          Expanded(child: Text("group".tr, style: textMedium.copyWith(fontSize: Dimensions.fontSizeDefault))),
          Text("action".tr, style: textMedium.copyWith(fontSize: Dimensions.fontSizeDefault))]));
  }
}
