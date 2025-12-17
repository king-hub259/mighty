import 'package:flutter/material.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';

class CustomItemTextWidget extends StatelessWidget {
  final String? text;
  const CustomItemTextWidget({super.key, this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text ?? '',
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall),
    );
  }
}
