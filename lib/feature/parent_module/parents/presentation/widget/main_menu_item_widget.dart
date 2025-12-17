import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_contaner.dart';
import 'package:mighty_school/feature/parent_module/parents/logic/menu_controller.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';

class MainMenuItemWidget extends StatelessWidget {
  final MenuItemModel item;
  const MainMenuItemWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return InkWell(onTap: item.route != null ?(){
      Get.toNamed(item.route!);
    } : null,
      child: Column(spacing: Dimensions.paddingSizeSmall, children: [
        CustomContainer(
          showShadow: false,
          horizontalPadding: 12, verticalPadding: 7, borderRadius: Dimensions.paddingSizeExtraSmall,
          color: Get.isDarkMode? Theme.of(context).highlightColor : Theme.of(context).primaryColor.withValues(alpha: .125),
          child: Icon(item.icon,size: Dimensions.iconSizeExtraLarge, color: Get.isDarkMode? Colors.white : Theme.of(context).primaryColor,),),
        Text(item.title.tr, style: textRegular.copyWith( fontSize: Dimensions.fontSizeSmall,
           height: 1.2),
          maxLines: 2, overflow: TextOverflow.ellipsis,textAlign: TextAlign.center,)
      ],
      ),
    );
  }
}
