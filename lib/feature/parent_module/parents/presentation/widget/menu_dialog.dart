import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/feature/parent_module/parents/logic/menu_controller.dart';
import 'package:mighty_school/feature/parent_module/parents/presentation/widget/main_menu_item_widget.dart';
import 'package:mighty_school/feature/profile/logic/profile_controller.dart';
import 'package:mighty_school/util/app_constants.dart';
import 'package:mighty_school/util/dimensions.dart';


class DashboardMenuDialog extends StatelessWidget {
  const DashboardMenuDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ParentMenuController>(
      builder: (controller) {
        return GetBuilder<ProfileController>(
          builder: (profileController) {
            String? userType = profileController.profileModel?.data?.role;

            List<MenuItemModel> menuItems = userType == AppConstants.parent ? controller.menuItems : controller.superAdminMenuItems;
            return Container(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
              decoration: BoxDecoration(color: Theme.of(context).cardColor, borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(Dimensions.radiusExtraLarge), topLeft: Radius.circular(Dimensions.radiusExtraLarge),), ),
              child: Column(mainAxisSize: MainAxisSize.min, spacing: Dimensions.paddingSizeDefault, children:[
                 const SizedBox(height: Dimensions.paddingSizeExtraSmall),
                  InkWell(onTap: () => Get.back(),
                      child: Icon(Icons.keyboard_arrow_down,size: Dimensions.iconSizeExtraLarge,
                        color: Theme.of(context).colorScheme.primary,)),
                  GridView.builder(shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: menuItems.length,
                    padding:  EdgeInsets.zero,
                    gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(mainAxisSpacing: 20, crossAxisSpacing: 15, maxCrossAxisExtent: 100),
                    itemBuilder: (context, index) {
                      final item = menuItems[index];
                      return MainMenuItemWidget(item: item);
                    }),
                const SizedBox(height: Dimensions.paddingSizeDefault)
                ],
              ),
            );
          }
        );
      },
    );
  }
}