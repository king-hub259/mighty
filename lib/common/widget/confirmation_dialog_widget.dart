import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_button.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';

class ConfirmationDialogWidget extends StatelessWidget {
  final String icon;
  final String? title;
  final String description;
  final Function onYesPressed;
  final bool isLogOut;
  final bool hasCancel;
   const ConfirmationDialogWidget({super.key, required this.icon, this.title, required this.description, required this.onYesPressed, this.isLogOut = false, this.hasCancel = true});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.radiusSmall)),
      child: Padding(
        padding:  const EdgeInsets.all(Dimensions.paddingSizeLarge),
        child: Column(mainAxisSize: MainAxisSize.min, children: [

          Padding(
            padding:  const EdgeInsets.all(Dimensions.paddingSizeLarge),
            child: Image.asset(icon, width: 50, height: 50),
          ),

          title != null ? Padding(
            padding:  const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge),
            child: Text(
              title!, textAlign: TextAlign.center,
              style: textMedium.copyWith(fontSize: Dimensions.fontSizeExtraLarge, color: Colors.red),
            ),
          ) :  const SizedBox(),

          Padding(
            padding:  const EdgeInsets.all(Dimensions.paddingSizeSmall),
            child: Text(description, style: textMedium.copyWith(fontSize: Dimensions.fontSizeLarge), textAlign: TextAlign.center),
          ),
           const SizedBox(height: Dimensions.paddingSizeLarge),

          Row(children: [
            hasCancel ? Expanded(child: TextButton(
              onPressed: () => isLogOut ? onYesPressed() : Get.back(),
              style: TextButton.styleFrom(
                backgroundColor: Theme.of(context).disabledColor.withValues(alpha: 0.3), minimumSize:  const Size(1170, 50), padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.paddingSizeOverLarge)),
              ),
              child: Text(
                isLogOut ? 'yes'.tr : 'no'.tr, textAlign: TextAlign.center,
                style: textRegular.copyWith(color: Theme.of(context).textTheme.bodyLarge!.color),
              ),
            )) :  const SizedBox(),
            SizedBox(width: hasCancel ? Dimensions.paddingSizeLarge : 0),

            Expanded(child: CustomButton(
              text: isLogOut ? 'no'.tr : hasCancel ? 'yes'.tr : 'ok'.tr,
              onTap: () => isLogOut ? Get.back() : onYesPressed(),
            )),
          ])

        ]),
      ),
    );
  }
}