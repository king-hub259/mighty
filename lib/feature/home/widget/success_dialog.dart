import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_button.dart';
import 'package:mighty_school/common/widget/custom_contaner.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';

class SuccessDialog extends StatelessWidget {
  final bool success;
  const SuccessDialog({super.key,  this.success = false});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: CustomContainer(child: Padding(
        padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
           Icon(success? Icons.check_circle : Icons.cancel, color: success? Colors.green : Colors.red, size: 50),
          const SizedBox(height: 20),
          Text('success'.tr, style: textRegular.copyWith(fontSize: 20)),
          const SizedBox(height: 10),
          Text(success? 'your_payment_successfully_completed'.tr : "your_payment_failed",
              textAlign: TextAlign.center, style: textRegular.copyWith(color: Theme.of(context).disabledColor)),
          const SizedBox(height: 20),
          CustomButton(width: 120,onTap: () => Navigator.pop(context), text: 'ok'.tr)
        ]),
      )),
    );
  }
}
