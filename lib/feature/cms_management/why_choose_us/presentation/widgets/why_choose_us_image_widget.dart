import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_image.dart';
import 'package:mighty_school/feature/cms_management/why_choose_us/domain/model/why_choose_us_model.dart';
import 'package:mighty_school/feature/cms_management/why_choose_us/logic/why_choose_us_controller.dart';
import 'package:mighty_school/util/app_constants.dart';
import 'package:mighty_school/util/dimensions.dart';

class WhyChooseUsImageWidget extends StatelessWidget {
  final WhyChooseUsItem? whyChooseUsItem;
  const WhyChooseUsImageWidget({super.key, this.whyChooseUsItem});

  @override
  Widget build(BuildContext context) {
    return  GetBuilder<WhyChooseUsController>(
      builder: (whyChooseUsController) {
        return Align(alignment: Alignment.center, child: Stack(children: [
          ClipRRect(borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
              child: whyChooseUsController.benefitImage != null ?  GetPlatform.isWeb? Image.network((whyChooseUsController.benefitImage!.path),
                width: 150, height: 120, fit: BoxFit.cover,):Image.file(File(whyChooseUsController.benefitImage!.path),
                width: 150, height: 120, fit: BoxFit.cover,):
               CustomImage(image: '${AppConstants.imageBaseUrl}/why_choose_us/${whyChooseUsItem?.icon}', height: 120, width: 150)),


          Positioned(bottom: 0, right: 0, top: 0, left: 0,
              child: InkWell(onTap: () => whyChooseUsController.pickImage(),
                  child: Container(decoration: BoxDecoration(color: Colors.black.withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
                      border: Border.all(width: 1, color: Theme.of(context).primaryColor)),
                      child: Container(margin: const EdgeInsets.all(25),
                          decoration: BoxDecoration(border: Border.all(width: 2, color: Colors.white), shape: BoxShape.circle),
                          child: const Icon(Icons.camera_alt, color: Colors.white)))))]));
      }
    );
  }
}
