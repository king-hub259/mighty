import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_button.dart';
import 'package:mighty_school/common/widget/date_selection_widget.dart';
import 'package:mighty_school/util/dimensions.dart';

class FromToSelectionWidget extends StatelessWidget {
  final Function()? onTap;
  const FromToSelectionWidget({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Row(spacing: Dimensions.paddingSizeDefault, crossAxisAlignment: CrossAxisAlignment.end, children : [
       Expanded(child: DateSelectionWidget(title: "from".tr, end: false)),
       Expanded(child: DateSelectionWidget(title: "to".tr, end: true)),
      IntrinsicWidth(child: CustomButton(onTap: onTap, text: "search".tr, width: 120, height: 40))

    ]);
  }
}
