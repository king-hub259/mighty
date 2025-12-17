import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:mighty_school/common/widget/side_sheet_widget.dart';
import 'package:mighty_school/feature/home/widget/subscription_widget.dart';
import 'package:mighty_school/feature/user_manual/presentation/user_manual_widget.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/images.dart';
import 'package:mighty_school/util/styles.dart';

class SidebarFooterSectionWidget extends StatelessWidget {
  final String roleType;
  const SidebarFooterSectionWidget({super.key, required this.roleType});

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: [

      InkWell(onTap: () {
        showModalSideSheet(Get.context!,
            barrierDismissible: true,
            addBackIconButton: false,
            addActions: false,
            addDivider: false,
            body: const Padding(padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                child: UserManualWidget()),
            header: "user_manual".tr);
      },
        child: Container(height: 70, decoration: BoxDecoration(color: Theme.of(context).cardColor),
            child: Row(spacing: Dimensions.paddingSizeDefault, mainAxisAlignment: MainAxisAlignment.center,children: [
              Text("user_manual".tr, style: textRegular.copyWith(color: Theme.of(context).textTheme.displayLarge?.color, fontSize: Dimensions.fontSizeLarge),),
              Lottie.asset(Images.userManual)],
            )),
      ),

      roleType == "Super Admin"?
      const SubscriptionWidget():const SizedBox()
    ],);
  }
}
