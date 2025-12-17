import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/confirmation_dialog.dart';
import 'package:mighty_school/common/widget/custom_contaner.dart';
import 'package:mighty_school/common/widget/custom_divider.dart';
import 'package:mighty_school/common/widget/custom_image.dart';
import 'package:mighty_school/common/widget/edit_delete_section.dart';
import 'package:mighty_school/feature/cms_management/academic_image/domain/model/academic_image_model.dart';
import 'package:mighty_school/feature/cms_management/academic_image/logic/academic_image_controller.dart';
import 'package:mighty_school/feature/cms_management/academic_image/presentation/widgets/create_new_academic_image_widget.dart';
import 'package:mighty_school/helper/responsive_helper.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';

class AcademicImageItemWidget extends StatelessWidget {
  final AcademicImageItem? academicImageItem;
  final int index;
  const AcademicImageItemWidget({super.key, this.academicImageItem, required this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.symmetric(vertical: 5),
      child: ResponsiveHelper.isDesktop(context)?
      Column(children: [
        Row(crossAxisAlignment: CrossAxisAlignment.start, spacing: Dimensions.paddingSizeSmall, children: [
          Text("${index+1}", maxLines: 1,overflow: TextOverflow.ellipsis, style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall),),
          SizedBox(width: 120, child: CustomImage(image: "${academicImageItem?.image}", width: 120, height: 70)),
          Expanded(child: Text("${academicImageItem?.title}", maxLines: 1,overflow: TextOverflow.ellipsis, style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall),)),

          EditDeleteSection(onEdit: (){
            Get.dialog(Dialog(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                child: SizedBox(width: ResponsiveHelper.isDesktop(context)? 600 : Get.width,
                  child: Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                    child: CreateNewAcademicImageWidget(imageItem: academicImageItem,),
                  ),
                )));
          }, onDelete: (){
            Get.dialog(ConfirmationDialog(
                title: "academic_image",
                content: "are_you_sure_to_delete_this_academic_image".tr,
                onTap: (){
                  Get.back();
                  Get.find<AcademicImageController>().deleteAcademicImage(academicImageItem?.id??0);
                }));
          }, horizontal: true)
        ]),
        const Padding(padding: EdgeInsets.symmetric(vertical:Dimensions.paddingSizeExtraSmall), child: CustomDivider()),
      ],):

      CustomContainer(child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        ClipRRect(borderRadius: BorderRadius.circular(120),
            child: const CustomImage(width: Dimensions.imageSizeBig, height: Dimensions.imageSizeBig, image: "")),
        const SizedBox(width: Dimensions.paddingSizeSmall),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("${academicImageItem?.title}", maxLines: 1,overflow: TextOverflow.ellipsis,
            style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall),),
          EditDeleteSection(onEdit: (){}, onDelete: (){},),
          const SizedBox(height: Dimensions.paddingSizeExtraSmall),
        ])),
      ],
      )),
    );
  }
}

