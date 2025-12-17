import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_image.dart';
import 'package:mighty_school/feature/parent_module/parent_profile/domain/model/parent_profile_model.dart';
import 'package:mighty_school/feature/parent_module/parent_profile/logic/parent_profile_controller.dart';
import 'package:mighty_school/feature/profile/domain/model/profile_model.dart';
import 'package:mighty_school/feature/profile/logic/profile_controller.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/images.dart';
import 'package:mighty_school/util/styles.dart';

class HeaderProfileInfo extends StatelessWidget {
  const HeaderProfileInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
        initState: (val) {
            if(Get.find<ProfileController>().profileModel == null) {
              Get.find<ProfileController>().getProfileInfo();
            }
        },
        builder: (profileController) {
          ProfileModel? profile = profileController.profileModel;

          return Row(spacing: Dimensions.paddingSizeSmall, children: [
            const CustomImage(width: 30,height: 30,radius: 120, image: '', placeholder: Images.profileIcon),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                Text(profile?.data?.name??'', style: textMedium.copyWith(fontSize: Dimensions.fontSizeDefault )),
                Icon(Icons.keyboard_arrow_down, size: 20, color: Theme.of(context).hintColor)
              ],
              ),
              Text(profile?.data?.role??'', style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).hintColor)),

            ])
          ]);
        }
    );
  }
}

class ParentHeaderProfileInfo extends StatelessWidget {
  const ParentHeaderProfileInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ParentProfileController>(
        initState: (val) {
          Get.find<ParentProfileController>().getProfileInfo();
        },
        builder: (profileController) {
          ParentProfileModel? profile = profileController.profileModel;
          return Row(spacing: Dimensions.paddingSizeSmall, children: [
            const CustomImage(width: 30,height: 30,radius: 120,),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                Text(profile?.data?.parentName??'kuddus', style: textMedium.copyWith(fontSize: Dimensions.fontSizeDefault )),
                Icon(Icons.keyboard_arrow_down, size: 20, color: Theme.of(context).hintColor)
              ],
              ),
              Text('Parents', style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).hintColor)),

            ])
          ]);
        }
    );
  }
}

