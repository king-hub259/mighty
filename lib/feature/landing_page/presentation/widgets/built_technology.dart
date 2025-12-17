import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_button.dart';
import 'package:mighty_school/feature/landing_page/presentation/widgets/orbit_rotation.dart';
import 'package:mighty_school/helper/responsive_helper.dart';
import 'package:mighty_school/helper/route_helper.dart';
import 'package:mighty_school/util/app_constants.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';

class BuiltTechnologySection extends StatelessWidget {
  const BuiltTechnologySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(width: Dimensions.webMaxWidth,
        child: ResponsiveHelper.isDesktop(context)?
        Row(spacing: Dimensions.paddingSizeOver, children: [
            const OrbitRotation(),
            Expanded(
              child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text("built_in_technology".tr, style: textSemiBold.copyWith(color: Theme.of(context).primaryColor, fontSize: 20),),
                  Text("empowering_education".tr, style: textBold.copyWith(color: Theme.of(context).colorScheme.primary, fontSize: 40),),
                  const SizedBox(height: 10),
                  Text("${AppConstants.appName} ${"built_in_with_modern_technology".tr}",
                      style: textRegular.copyWith(color: Theme.of(context).hintColor, )),
                  const SizedBox(height: 40),
                SizedBox(width: 160,
                  child: CustomButton(onTap: (){
                    Get.toNamed(RouteHelper.getApplyInstituteRoute());
                  }, text: "register_your_school".tr),
                )
                ]),
            )
          ],
        ): Padding(padding: const EdgeInsets.symmetric(horizontal : Dimensions.paddingSizeSmall,),
          child: Column(spacing: Dimensions.paddingSizeLarge, children: [
            const OrbitRotation(),
            const SizedBox(height: Dimensions.paddingSizeLarge),
            Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text("built_in_technology".tr, style: textSemiBold.copyWith(color: Theme.of(context).primaryColor, fontSize: 20),),
              Text("empowering_education".tr, textAlign: TextAlign.center, style: textBold.copyWith(color: Theme.of(context).colorScheme.primary, fontSize: Dimensions.fontSizeExtraOverLarge),),
              const SizedBox(height: Dimensions.paddingSizeSmall),
              Text("${AppConstants.appName} ${"built_in_with_modern_technology".tr}",
                  style: textRegular.copyWith(color: Theme.of(context).hintColor, fontSize: Dimensions.fontSizeDefault,)),
              SizedBox(height: Dimensions.landingPagePadding),
              Center(
                child: SizedBox(width: 160,
                  child: CustomButton(onTap: (){
                    Get.toNamed(RouteHelper.getApplyInstituteRoute());
                  }, text: "register_your_school".tr),
                ),
              )
            ])
          ],
          ),
        ),
      ),
    );
  }
}