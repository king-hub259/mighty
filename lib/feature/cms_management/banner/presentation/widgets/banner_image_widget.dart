import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_image.dart';
import 'package:mighty_school/feature/cms_management/banner/domain/model/banner_model.dart';
import 'package:mighty_school/feature/cms_management/banner/logic/banner_controller.dart';
import 'package:mighty_school/util/app_constants.dart';
import 'package:mighty_school/util/dimensions.dart';

class BannerImageWidget extends StatelessWidget {
  final BannerItem? bannerItem;
  const BannerImageWidget({super.key, this.bannerItem});

  @override
  Widget build(BuildContext context) {
    return  GetBuilder<BannerController>(
      builder: (bannerController) {
        return Align(alignment: Alignment.center, child: Stack(children: [
          ClipRRect(borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
              child: bannerController.thumbnail != null ?  GetPlatform.isWeb? Image.network((bannerController.thumbnail!.path),
                width: 150, height: 120, fit: BoxFit.cover,):Image.file(File(bannerController.thumbnail!.path),
                width: 150, height: 120, fit: BoxFit.cover,):
               CustomImage(image: '${AppConstants.imageBaseUrl}/banners/${bannerItem?.image}', height: 120, width: 150)),


          Positioned(bottom: 0, right: 0, top: 0, left: 0,
              child: InkWell(onTap: () => bannerController.pickImage(),
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
