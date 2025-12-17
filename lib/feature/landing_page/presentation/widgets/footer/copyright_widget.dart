import 'package:flutter/material.dart';
import 'package:mighty_school/util/app_constants.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';

class CopyrightWidget extends StatelessWidget {
  const CopyrightWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
      color: Theme.of(context).colorScheme.primary,
      child: Center(child: Text("© ${DateTime.now().year} ${AppConstants.appName}. All Rights Reserved.",
        style: textMedium.copyWith(fontSize: Dimensions.fontSizeDefault, color: Colors.white),),),
    );
  }
}
