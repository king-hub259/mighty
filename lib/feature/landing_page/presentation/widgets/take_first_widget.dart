import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_button.dart';
import 'package:mighty_school/helper/route_helper.dart';
import 'package:mighty_school/util/app_constants.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';

class TakeFirstWidget extends StatelessWidget {
  const TakeFirstWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeOver),
        width: Dimensions.webMaxWidth,
        decoration: ThemeShadow.getLandingPageDecoration(),
        child: Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
          child: Column(mainAxisAlignment: MainAxisAlignment.center,
            spacing: Dimensions.paddingSizeDefault, children: [
              Text("take_first_step".tr,
                style: textBold.copyWith(color: Colors.white, fontSize: Dimensions.fontSizeExtraOverLarge),
                textAlign: TextAlign.center,),
              Text("${"join_lots_of_schools".tr} ${AppConstants.appName} ${"experience_the_difference".tr}",
                  textAlign: TextAlign.center,
                style: textRegular.copyWith(color: Colors.white)),
             const SizedBox(height: Dimensions.paddingSizeDefault),
              SizedBox(width: 180, child: CustomButton(onTap: (){
                Get.toNamed(RouteHelper.getApplyInstituteRoute());
              }, text: "register_your_school".tr))
            ],
          ),
        ),
      ),
    );
  }
}
