import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/images.dart';
import 'package:mighty_school/util/styles.dart';

class DataSyncWidget extends StatelessWidget {
  const DataSyncWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(insetPadding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall)),
      content: Column(mainAxisSize: MainAxisSize.min,
        children: [
          Text("please_wait".tr, style: textSemiBold.copyWith(fontSize: Dimensions.fontSizeHeading)),
          SizedBox(height: Get.width/3, child: Lottie.asset(Images.dataBackup)),
        ],
    ),);
  }
}
