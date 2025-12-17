import 'package:flutter/material.dart';
import 'package:mighty_school/common/widget/custom_image.dart';
import 'package:mighty_school/feature/administrator/system_settings/controller/system_settngs_controller.dart';
import 'package:mighty_school/feature/administrator/system_settings/domain/model/general_settings_model.dart';
import 'package:mighty_school/helper/route_helper.dart';
import 'package:mighty_school/util/app_constants.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:get/get.dart';
import 'package:mighty_school/util/images.dart';

class LogoSection extends StatelessWidget {
  final String roleType;
  const LogoSection({super.key, required this.roleType});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SystemSettingsController>(
      builder: (systemSettingsController) {
        GeneralSettingModel? generalSettingModel = systemSettingsController.generalSettingModel;
        return Center(child: InkWell(onTap: () => Get.toNamed(RouteHelper.getDashboardRoute()),
          child: Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
            child: roleType == "SAAS Admin"? const CustomImage(image: Images.logo, localAsset: true, height: 45,):
            CustomImage(height: 45, image: "${AppConstants.baseUrl}/public/uploads/logos/${generalSettingModel?.data?.logo}",),
          ),
        ),
        );
      }
    );
  }
}
