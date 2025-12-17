import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_image.dart';
import 'package:mighty_school/feature/cms_management/academic_image/domain/model/academic_image_model.dart';
import 'package:mighty_school/feature/cms_management/academic_image/logic/academic_image_controller.dart';
import 'package:mighty_school/util/app_constants.dart';
import 'package:mighty_school/util/dimensions.dart';

class AcademicImageWidget extends StatelessWidget {
  final AcademicImageItem? imageItem;
  const AcademicImageWidget({super.key, this.imageItem});

  @override
  Widget build(BuildContext context) {
    return  GetBuilder<AcademicImageController>(
      builder: (academicImageController) {
        return Align(alignment: Alignment.center, child: Stack(children: [
          ClipRRect(borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
              child: academicImageController.thumbnail != null ?  GetPlatform.isWeb? Image.network((academicImageController.thumbnail!.path),
                width: 150, height: 120, fit: BoxFit.cover,):Image.file(File(academicImageController.thumbnail!.path),
                width: 150, height: 120, fit: BoxFit.cover,):
               CustomImage(image: '${AppConstants.baseUrl}/storage/public/about_us/${imageItem?.image}', height: 120, width: 150)),


          Positioned(bottom: 0, right: 0, top: 0, left: 0,
              child: InkWell(onTap: () => academicImageController.pickImage(),
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
