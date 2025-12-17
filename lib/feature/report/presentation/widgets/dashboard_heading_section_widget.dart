import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/feature/profile/domain/model/profile_model.dart';
import 'package:mighty_school/feature/profile/logic/profile_controller.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';

class DashboardHeadingSectionWidget extends StatelessWidget {
  const DashboardHeadingSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      builder: (profileController) {
        ProfileModel? profileModel = profileController.profileModel;

        return Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
          child: Row(spacing: Dimensions.paddingSizeDefault, children: [
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("${'welcome_back'.tr} ${profileModel?.data?.name??''}",
                    style: textMedium.copyWith(fontSize: Dimensions.fontSizeOverLarge)),
                Text('dashboard_report_slogan'.tr,
                    style: textRegular.copyWith(color: Theme.of(context).hintColor)),
              ],
            )),
          ]),
        );
      }
    );
  }
}
