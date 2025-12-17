import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_button.dart';
import 'package:mighty_school/common/widget/custom_image.dart';
import 'package:mighty_school/feature/administrator/system_settings/controller/system_settngs_controller.dart';
import 'package:mighty_school/feature/administrator/system_settings/domain/model/general_settings_model.dart';
import 'package:mighty_school/helper/responsive_helper.dart';
import 'package:mighty_school/util/app_constants.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';

class SelectLogoWidget extends StatelessWidget {
  const SelectLogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return  GetBuilder<SystemSettingsController>(
      builder: (systemSettingsController) {
        GeneralSettingModel? generalSettingModel = systemSettingsController.generalSettingModel;
        log("logo path is : ${"${AppConstants.baseUrl}/public/uploads/logos/${generalSettingModel?.data?.logo}"}");
        return Column(spacing: Dimensions.paddingSizeSmall,
          children: [
            Align(alignment: Alignment.center, child: Stack(children: [
              systemSettingsController.thumbnail != null ?  ResponsiveHelper.isMobile(context)?Image.file(File(systemSettingsController.thumbnail!.path),
                width: 150, fit: BoxFit.contain,) : Image.network((systemSettingsController.thumbnail!.path),
                width: 150, fit: BoxFit.contain,):
               CustomImage(image: '${AppConstants.baseUrl}/public/uploads/logos/${generalSettingModel?.data?.logo}', width: 150),


              Positioned(bottom: 0, right: 0, top: 0, left: 0,
                  child: InkWell(onTap: () => systemSettingsController.pickImage(),
                      child: Container(decoration: BoxDecoration(color: Colors.black.withValues(alpha: 0.3))))),

              Positioned(right: 0,top: 0,
                  child: InkWell(onTap: () => systemSettingsController.pickImage(),
                    child: CircleAvatar(backgroundColor: Theme.of(context).primaryColor,radius: 15,
                        child: const Icon(Icons.edit, color: Colors.white, size: 12,)),
                  ))
            ])),

            Text("logo_size".tr, style: textRegular.copyWith(color: Theme.of(context).hintColor, fontSize: Dimensions.fontSizeExtraSmall), textAlign: TextAlign.center),

            Center(child: systemSettingsController.loading?
                const CircularProgressIndicator():
            SizedBox(width: 120, child: CustomButton(onTap: (){
              systemSettingsController.uploadLogo();
            }, text: "upload".tr)))
          ],
        );
      }
    );
  }
}
