import 'package:flutter/material.dart';
import 'package:mighty_school/common/widget/custom_contaner.dart';
import 'package:mighty_school/util/styles.dart';

class CustomAddNewButtonWidget extends StatelessWidget {
  final String? title;
  final Function()? onTap;
  const CustomAddNewButtonWidget({super.key, this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return CustomContainer(onTap: onTap,
        verticalPadding: 5, borderRadius: 5, color: Theme.of(context).primaryColor,
        child: Text(title?? '', style: textRegular.copyWith(color: Colors.white)));
  }
}
