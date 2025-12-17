
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_image.dart';
import 'package:mighty_school/feature/profile/domain/model/profile_model.dart';
import 'package:mighty_school/feature/profile/logic/profile_controller.dart';
import 'package:mighty_school/helper/route_helper.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/images.dart';
import 'package:mighty_school/util/styles.dart';

class SubscriptionWidget extends StatelessWidget {
  const SubscriptionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: 70,
      child: GetBuilder<ProfileController>(
        builder: (profileController) {
          ProfileModel? profileModel = profileController.profileModel;
          int remainingDays = 0;
          if(profileModel?.data?.instituteInfo?.subscription?.plan != null){
            DateTime endDate = DateTime.parse(profileModel!.data!.instituteInfo!.subscription!.endDate!);
            DateTime now = DateTime.now();
            remainingDays = endDate.difference(now).inDays;
          }
          return InkWell(onTap: () {
            Get.toNamed(RouteHelper.getSubscriptionRoute());
          },
            child: Container(padding: const EdgeInsets.all(10),decoration: BoxDecoration(
              color: Theme.of(context).secondaryHeaderColor,
            ),

              child: Row(spacing: Dimensions.paddingSizeSmall, children: [
                const CustomImage(localAsset: true, image: Images.package, width: 40),
                Expanded(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Row(children: [
                        Expanded(child: Text("upgrade".tr, style: textMedium.copyWith(color: Colors.white, fontSize: Dimensions.fontSizeLarge))),
                        const Icon(Icons.arrow_forward_ios_rounded, size: 12,color: Colors.white)
                      ],
                    ),
                    Text("${profileModel?.data?.instituteInfo?.subscription?.plan?.name??''}: $remainingDays ${"days".tr}",
                      style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Colors.white)),

                  ]),
                )
              ]),
            ),
          );
        }
      ),
    );
  }
}
