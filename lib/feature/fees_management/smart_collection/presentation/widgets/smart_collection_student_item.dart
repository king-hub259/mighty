import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_contaner.dart';
import 'package:mighty_school/common/widget/custom_image.dart';
import 'package:mighty_school/common/widget/edit_delete_section.dart';
import 'package:mighty_school/feature/fees_management/smart_collection/controller/smart_collection_controller.dart';
import 'package:mighty_school/feature/fees_management/smart_collection/domain/model/smart_collection_model.dart';
import 'package:mighty_school/helper/responsive_helper.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/images.dart';
import 'package:mighty_school/util/styles.dart';

class SmartCollectionStudentItemWidget extends StatelessWidget {
  final StudentItem? studentItem;
  final int index;
  const SmartCollectionStudentItemWidget({super.key, this.studentItem, required this.index});

  @override
  Widget build(BuildContext context) {

    return GetBuilder<SmartCollectionController>(
      builder: (smartCollectionController) {
        return Padding(padding: const EdgeInsets.symmetric(vertical: 5),
          child: ResponsiveHelper.isDesktop(context)?
          CustomContainer(borderRadius: Dimensions.paddingSizeExtraSmall, child: Row(
            children: [
              Text("${studentItem?.id}", style: textMedium.copyWith(fontSize: Dimensions.fontSizeDefault),),
              const SizedBox(width: Dimensions.paddingSizeSmall),
              Text(studentItem?.roll??'', style: textRegular.copyWith(),),
              const SizedBox(width: Dimensions.paddingSizeSmall),
              Text("${studentItem?.name}", style: textMedium.copyWith(fontSize: Dimensions.fontSizeDefault),),
              const SizedBox(width: Dimensions.paddingSizeSmall),
              Text("${studentItem?.className}", style: textMedium.copyWith(fontSize: Dimensions.fontSizeDefault),),
              const SizedBox(width: Dimensions.paddingSizeSmall),
              Text("${studentItem?.groupName}", style: textMedium.copyWith(fontSize: Dimensions.fontSizeDefault),),
              const SizedBox(width: Dimensions.paddingSizeSmall),

              const Spacer(),
              studentItem?.loading?? false? const CircularProgressIndicator():
              CustomContainer(borderRadius: 5,onTap: (){
                smartCollectionController.getSmartCollectionDetails(studentItem!.id!, index);
              },verticalPadding: 5,horizontalPadding: 5,child: SizedBox(width: 20,height: 20,child: Image.asset(Images.cart)),),

            ],
          )): CustomContainer(child: Row(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(borderRadius: BorderRadius.circular(120),
                  child: const CustomImage(width: Dimensions.imageSizeBig, height: Dimensions.imageSizeBig, image: "")),
              const SizedBox(width: Dimensions.paddingSizeSmall),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text("${studentItem?.name}", style: textMedium.copyWith(fontSize: Dimensions.fontSizeDefault),),
                Text("${"roll".tr} : ${studentItem?.roll??''}", style: textRegular.copyWith(),),

              ]),
              ),
              EditDeleteSection(onEdit: (){})

            ],
          )),
        );
      }
    );
  }
}