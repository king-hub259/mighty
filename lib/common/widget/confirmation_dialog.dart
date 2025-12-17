import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_button.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';

class ConfirmationDialog extends StatelessWidget {
  final String? title;
  final String? content;
  final Function() onTap;
  final bool backup;
  const ConfirmationDialog({super.key, this.title, this.content, required this.onTap,  this.backup = false});

  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      insetPadding: const EdgeInsets.all(5),
      content: Column(mainAxisSize: MainAxisSize.min,spacing: Dimensions.paddingSizeSmall, children: [
        if(backup)...[
          Text("${"backup_data".tr}!!!", style: textSemiBold.copyWith(fontSize: Dimensions.fontSizeOverLarge)),
          Text("${"are_you_sure_wanna_backup".tr}!!!",textAlign: TextAlign.center, style: textRegular.copyWith(fontSize: Dimensions.fontSizeDefault)),
        ] else...[
          Text("${"delete".tr} ${title?.tr}!!!", style: textSemiBold.copyWith(fontSize: Dimensions.fontSizeLarge)),
          Text("${"are_you_sure".tr} ${content?.tr}?", style: textRegular.copyWith(fontSize: Dimensions.fontSizeDefault)),
          ],

        const SizedBox(height: Dimensions.paddingSizeDefault),
        Row(children: [


          Expanded(flex: 1,child: CustomButton(onTap: () => Get.back(), text: "no".tr,
            showBorderOnly: true, textColor: Theme.of(context).colorScheme.error, borderColor: Theme.of(context).colorScheme.error,height: 35,)),
          const SizedBox(width: Dimensions.paddingSizeSmall),
          Expanded(flex: 2,child: CustomButton(onTap: onTap, text: "yes".tr)),
        ],)
      ],),);
  }
}