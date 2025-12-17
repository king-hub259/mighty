import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/images.dart';
import 'package:mighty_school/util/styles.dart';

import '../../feature/parent_module/parent_dashboard/views/parent_dashboard_screen.dart';


class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final bool showBackButton;
  final Function()? onBackPressed;
  final bool centerTitle;
  final double? fontSize;
  final Widget? actionWidget;

  const AppBarWidget({
    super.key,
     this.title,
    this.showBackButton = true,
    this.onBackPressed,
    this.centerTitle= false,
    this.fontSize, this.actionWidget});

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(150.0),
      child: AppBar(elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: Theme.of(context).primaryColor ,
        toolbarHeight: 80,
        automaticallyImplyLeading: false,
        title: title!= null?
        Padding(padding: const EdgeInsets.only(left: Dimensions.paddingSizeExtraSmall),
          child: Text(title!.tr, style: textRegular.copyWith(fontSize: fontSize ??   Dimensions.fontSizeLarge , color: Get.isDarkMode ? Colors.white.withValues(alpha: 0.9) : Colors.white,),
            maxLines: 1,textAlign: TextAlign.start, overflow: TextOverflow.ellipsis,)):const SizedBox(),

        centerTitle: centerTitle,
        excludeHeaderSemantics: true,
        titleSpacing: 0,

        actions: [actionWidget??const SizedBox()],

        leadingWidth: showBackButton ? 50 : 100,
        leading: showBackButton ?
        IconButton(icon: const Icon(Icons.arrow_back),
          color: Get.isDarkMode ? Colors.white.withValues(alpha:0.8) : Colors.white,
          onPressed: () => onBackPressed != null ? onBackPressed!() : Navigator.canPop(context) ? Get.back() : Get.offAll(()=> const DashboardScreen()),
        ) :
        Padding(padding: const EdgeInsets.all(Dimensions.paddingSize),
          child: Image.asset(Images.logo, height: 50, color: Colors.white,)),
      ),
    );
  }

  @override
  Size get preferredSize => const Size(Dimensions.webMaxWidth, 150);
}