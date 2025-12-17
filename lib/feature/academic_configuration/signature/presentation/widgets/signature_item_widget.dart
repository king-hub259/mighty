import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_contaner.dart';
import 'package:mighty_school/common/widget/custom_image.dart';
import 'package:mighty_school/common/widget/edit_delete_section.dart';
import 'package:mighty_school/common/widget/image_dialog.dart';
import 'package:mighty_school/common/widget/numbering_widget.dart';
import 'package:mighty_school/feature/academic_configuration/signature/domain/models/signature_list_model.dart';
import 'package:mighty_school/helper/responsive_helper.dart';
import 'package:mighty_school/util/app_constants.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';

class SignatureItemWidget extends StatelessWidget {
  final SignatureItem? signatureItem;
  final int index;
  const SignatureItemWidget({super.key, this.signatureItem, required this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault, vertical: 5),
      child: ResponsiveHelper.isDesktop(context)?
      Row(spacing: Dimensions.paddingSizeDefault, children: [
        NumberingWidget(index: index),
          InkWell(onTap: ()=> Get.dialog(ImageDialog(imageUrl: "${AppConstants.imageBaseUrl}/principal_signature/${signatureItem?.image??''}")),
              child: CustomImage(width: 40, image: signatureItem?.image??'',)),
          Expanded(child: Text("${signatureItem?.title}", style: textMedium.copyWith(fontSize: Dimensions.fontSizeDefault),)),
          Expanded(child: Text(" ${signatureItem?.placeAt??''}", style: textRegular.copyWith(),)),
          EditDeleteSection(horizontal: true, onEdit: (){

          },
            onDelete: (){


          },)
        ],
      ): CustomContainer(child: Row(
        children: [
          InkWell(onTap: ()=> Get.dialog(ImageDialog(imageUrl: signatureItem?.image??'')),
              child: CustomImage(height: 50, image: signatureItem?.image??'',)),
          const SizedBox(width: Dimensions.paddingSizeExtraSmall),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text("${signatureItem?.title}", style: textMedium.copyWith(fontSize: Dimensions.fontSizeDefault),),
            const SizedBox(height: Dimensions.paddingSizeSmall,),
            Text("${"place_at".tr} : ${signatureItem?.placeAt??''}", style: textRegular.copyWith(),),
          ]),
          ),
          EditDeleteSection(onEdit: (){

          },
            onDelete: (){


            },)
        ],
      )),
    );
  }
}