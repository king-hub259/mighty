import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/controller/theme_controller.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';


class TitleButton extends StatelessWidget {
  final String icon;
  final String title;
  final bool isTheme;
  final Function()? onTap;
  const TitleButton({super.key, required this.icon, required this.title, this.isTheme = false, this.onTap});

  @override
  Widget build(BuildContext context) {
    bool darkMode = Get.find<ThemeController>().darkTheme;
    return GetBuilder<ThemeController>(
      builder: (themeController) {
        return Padding(padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: InkWell(onTap : onTap,
            child: Container(decoration: BoxDecoration(color: Theme.of(context).cardColor),
              padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall, vertical: 8),
              child: Row(children: [
                 Image.asset(icon, width: 25, height: 25, color: darkMode? Colors.white : Colors.black),
                const SizedBox(width: Dimensions.paddingSizeSmall,),
                Expanded(child: Text(title.tr, style: textRegular.copyWith(fontSize: Dimensions.fontSizeDefault))),
                (isTheme)?
                Switch.adaptive(value: !themeController.darkTheme, onChanged: (val){
                  themeController.toggleTheme();
                }, activeColor: Theme.of(context).primaryColor, ):
                Icon(Icons.arrow_forward_ios_rounded, color: Theme.of(context).hintColor, size: 18)
              ]),
            ),
          ),
        );
      }
    );
  }
}