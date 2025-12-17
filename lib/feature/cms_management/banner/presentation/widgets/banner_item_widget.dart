import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/confirmation_dialog.dart';
import 'package:mighty_school/common/widget/custom_contaner.dart';
import 'package:mighty_school/common/widget/custom_divider.dart';
import 'package:mighty_school/common/widget/custom_image.dart';
import 'package:mighty_school/common/widget/custom_item_text_widget.dart';
import 'package:mighty_school/common/widget/edit_delete_section.dart';
import 'package:mighty_school/common/widget/numbering_widget.dart';
import 'package:mighty_school/feature/cms_management/banner/domain/model/banner_model.dart';
import 'package:mighty_school/feature/cms_management/banner/logic/banner_controller.dart';
import 'package:mighty_school/feature/cms_management/banner/presentation/widgets/create_new_banner_widget.dart';
import 'package:mighty_school/helper/responsive_helper.dart';
import 'package:mighty_school/util/app_constants.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';


class BannerItemWidget extends StatelessWidget {
  final BannerItem? bannerItem;
  final int index;
  const BannerItemWidget({super.key, this.bannerItem, required this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.symmetric(vertical: 5),
      child: ResponsiveHelper.isDesktop(context)?
      Row(crossAxisAlignment: CrossAxisAlignment.start, spacing: Dimensions.paddingSizeSmall, children: [
        NumberingWidget(index: index),
        SizedBox(width: 70, child: CustomImage(image: "${AppConstants.imageBaseUrl}/banners/${bannerItem?.image}", width: 120,height: 60, radius: 5)),
        Expanded(child: CustomItemTextWidget(text:"${bannerItem?.title}")),
        Expanded(child: CustomItemTextWidget(text:bannerItem?.description??'')),
        Expanded(child: CustomItemTextWidget(text:bannerItem?.buttonName??'')),
        Expanded(child: CustomItemTextWidget(text:bannerItem?.buttonLink??'')),
        _buildEditDeleteSection(context),
      ]):

      CustomContainer(child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        ClipRRect(borderRadius: BorderRadius.circular(120),
            child: const CustomImage(width: Dimensions.imageSizeBig, height: Dimensions.imageSizeBig, image: "")),
        const SizedBox(width: Dimensions.paddingSizeSmall),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          CustomItemTextWidget(text:"${bannerItem?.title}"),
          CustomItemTextWidget(text:bannerItem?.description??''),
          CustomItemTextWidget(text:bannerItem?.buttonName??''),
          CustomItemTextWidget(text:bannerItem?.buttonLink??''),
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
                child: CreateNewBannerWidget(bannerItem: bannerItem),
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
              Get.find<BannerController>().deleteBanner(bannerItem?.id ?? 0);
            },
          ),
        );
      },
      horizontal: ResponsiveHelper.isDesktop(context),
    );
  }
}