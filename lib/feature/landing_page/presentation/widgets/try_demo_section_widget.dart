import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_button.dart';
import 'package:mighty_school/common/widget/custom_image.dart';
import 'package:mighty_school/helper/responsive_helper.dart';
import 'package:mighty_school/helper/route_helper.dart';
import 'package:mighty_school/util/app_constants.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/images.dart';
import 'package:mighty_school/util/styles.dart';

class TryDemoSectionWidget extends StatelessWidget {
  const TryDemoSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container( decoration: ThemeShadow.getLandingPageDecoration(),
      width: Get.width,
      padding: const EdgeInsets.only(top : 50),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          SizedBox(width: 700,
            child: Text("all_in_one_school_management_system".tr,
              style: textBold.copyWith(color: Colors.white, fontSize: Dimensions.fontSizeExtraOverLarge),textAlign: TextAlign.center)),
          const SizedBox(height: 20),
          Text("easy_to_use_tool".tr, style: textRegular.copyWith(color: Colors.white, fontSize: Dimensions.fontSizeDefault),),
          const SizedBox(height: 40),
          ResponsiveHelper.isDesktop(context)?
          Row(mainAxisAlignment: MainAxisAlignment.center, spacing: Dimensions.paddingSizeDefault, children: [


            SizedBox(width: 160,child: CustomButton(onTap: (){
              Get.toNamed(RouteHelper.getApplyInstituteRoute());
            }, text: "register_your_school".tr)),

            SizedBox(width: 120,child: CustomButton(height: 35,

              showBorderOnly: true, borderColor: Colors.white,  textColor: Colors.white,
                onTap: (){
                Get.toNamed(RouteHelper.getSignInRoute());
                }, text: "demo_school".tr)),


            if(AppConstants.demo)
            SizedBox(width: 120,child: CustomButton(height: 35,
                showBorderOnly: true, borderColor: Colors.white,  textColor: Colors.white,
                onTap: (){
                  AppConstants.openUrl("https://codecanyon.net/item/mighty-school-allinone-school-management-system-for-mobile-web-and-desktop-offline-support/56909015");
                }, text: "buy_now".tr)),

          ]):Padding(
            padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, spacing: Dimensions.paddingSizeDefault, children: [


              Expanded(child: CustomButton(onTap: (){
                Get.toNamed(RouteHelper.getApplyInstituteRoute());
              }, text: "register_your_school".tr)),

              Expanded(child: CustomButton(height: 35,

                  showBorderOnly: true, borderColor: Colors.white,  textColor: Colors.white,
                  onTap: (){
                    Get.toNamed(RouteHelper.getSignInRoute());
                  }, text: "demo_school".tr)),


              if(AppConstants.demo)
                Expanded(child: CustomButton(height: 35,
                    showBorderOnly: true, borderColor: Colors.white,  textColor: Colors.white,
                    onTap: (){
                      AppConstants.openUrl("https://codecanyon.net/item/mighty-school-allinone-school-management-system-for-mobile-web-and-desktop-offline-support/56909015");
                    }, text: "buy_now".tr)),

            ]),
          ),
         const SizedBox(height: Dimensions.paddingSizeOver),
          const CustomImage(image: Images.introDashboardImage, localAsset: true, width: 1000,)

      ],
      ),

    );
  }
}
