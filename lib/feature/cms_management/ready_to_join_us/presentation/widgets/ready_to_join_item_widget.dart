import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/confirmation_dialog.dart';
import 'package:mighty_school/common/widget/custom_contaner.dart';
import 'package:mighty_school/common/widget/custom_image.dart';
import 'package:mighty_school/common/widget/custom_item_text_widget.dart';
import 'package:mighty_school/common/widget/edit_delete_section.dart';
import 'package:mighty_school/common/widget/numbering_widget.dart';
import 'package:mighty_school/feature/cms_management/ready_to_join_us/domain/model/ready_to_join_model.dart';
import 'package:mighty_school/feature/cms_management/ready_to_join_us/logic/ready_to_join_controller.dart';
import 'package:mighty_school/feature/cms_management/ready_to_join_us/presentation/widgets/create_new_ready_to_join_widget.dart';
import 'package:mighty_school/helper/responsive_helper.dart';
import 'package:mighty_school/util/app_constants.dart';
import 'package:mighty_school/util/dimensions.dart';


class ReadyToJoinItemWidget extends StatelessWidget {
  final ReadyToJoinItem? readyToJoinItem;
  final int index;
  const ReadyToJoinItemWidget({super.key, this.readyToJoinItem, required this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.symmetric(vertical: 5),
      child: ResponsiveHelper.isDesktop(context)?
      Row(crossAxisAlignment: CrossAxisAlignment.start, spacing: Dimensions.paddingSizeSmall, children: [
        NumberingWidget(index: index),
        SizedBox(width: 70, child: CustomImage(image: "${AppConstants.imageBaseUrl}/ready_to_join/${readyToJoinItem?.icon}", width: 120,height: 60, radius: 5)),
        Expanded(child: CustomItemTextWidget(text:"${readyToJoinItem?.title}")),
        Expanded(child: CustomItemTextWidget(text:readyToJoinItem?.description??'')),
        Expanded(child: CustomItemTextWidget(text:readyToJoinItem?.buttonName??'')),
        Expanded(child: CustomItemTextWidget(text:readyToJoinItem?.buttonLink??'')),
        _buildEditDeleteSection(context),
      ]):

      CustomContainer(child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        ClipRRect(borderRadius: BorderRadius.circular(120),
            child: const CustomImage(width: Dimensions.imageSizeBig, height: Dimensions.imageSizeBig, image: "")),
        const SizedBox(width: Dimensions.paddingSizeSmall),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          CustomItemTextWidget(text:"${readyToJoinItem?.title}"),
          CustomItemTextWidget(text:readyToJoinItem?.description??''),
          CustomItemTextWidget(text:readyToJoinItem?.buttonName??''),
          CustomItemTextWidget(text:readyToJoinItem?.buttonLink??''),
          _buildEditDeleteSection(context),
          const SizedBox(height: Dimensions.paddingSizeExtraSmall),
        ])),
      ],
      )),
    );
  }
  Widget _buildEditDeleteSection(BuildContext context) {
    return EditDeleteSection(
      onEdit: () {
        Get.dialog(
          Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: SizedBox(
              width: ResponsiveHelper.isDesktop(context) ? 600 : Get.width,
              child: Padding(
                padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                child: CreateNewReadyToJoinWidget(readyToJoinItem: readyToJoinItem),
              ),
            ),
          ),
        );
      },
      onDelete: () {
        Get.dialog(
          ConfirmationDialog(
            title: "banner",
            content: "are_you_sure_to_delete_this_banner".tr,
            onTap: () {
              Get.back();
              Get.find<ReadyToJoinController>().deleteReadyToJoin(readyToJoinItem?.id ?? 0);
            },
          ),
        );
      },
      horizontal: ResponsiveHelper.isDesktop(context),
    );
  }
}