import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/confirmation_dialog.dart';
import 'package:mighty_school/common/widget/custom_contaner.dart';
import 'package:mighty_school/common/widget/custom_image.dart';
import 'package:mighty_school/common/widget/custom_item_text_widget.dart';
import 'package:mighty_school/common/widget/edit_delete_section.dart';
import 'package:mighty_school/common/widget/numbering_widget.dart';
import 'package:mighty_school/feature/cms_management/mobile_app_section/domain/model/mobile_app_model.dart';
import 'package:mighty_school/feature/cms_management/mobile_app_section/logic/mobile_app_controller.dart';
import 'package:mighty_school/feature/cms_management/mobile_app_section/presentation/widgets/create_new_mobile_app_widget.dart';
import 'package:mighty_school/helper/responsive_helper.dart';
import 'package:mighty_school/util/app_constants.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';

class MobileAppItemWidget extends StatelessWidget {
  final MobileAppItem? mobileAppItem;
  final int index;
  const MobileAppItemWidget({super.key, this.mobileAppItem, required this.index});

  @override
  Widget build(BuildContext context) {
    final title = mobileAppItem?.title ?? '';
    final head = mobileAppItem?.heading ?? '';
    final description = mobileAppItem?.description ?? '';
    final featureOne = mobileAppItem?.featureOne ?? '';
    final featureTwo = mobileAppItem?.featureTwo ?? '';
    final featureThree = mobileAppItem?.featureThree ?? '';
    final playStore = mobileAppItem?.playStoreLink ?? '';
    final appStore = mobileAppItem?.appStoreLink ?? '';


    final image = "${AppConstants.imageBaseUrl}/mobile_app_sections/${mobileAppItem?.image}";

    Widget buildDesktopLayout() {
      return Row(crossAxisAlignment: CrossAxisAlignment.start, spacing: Dimensions.paddingSizeDefault,  children: [
          NumberingWidget(index: index),
          CustomImage(image: image, width: 40, height: 40),
          Expanded(child: CustomItemTextWidget(text: title)),
          Expanded(child: CustomItemTextWidget(text: head)),
          Expanded(child: CustomItemTextWidget(text: description)),
          Expanded(child: CustomItemTextWidget(text: featureOne)),
          Expanded(child: CustomItemTextWidget(text: featureTwo)),
          Expanded(child: CustomItemTextWidget(text: featureThree)),
          Expanded(child: CustomItemTextWidget(text: playStore)),
          Expanded(child: CustomItemTextWidget(text: appStore)),

          EditDeleteSection(onEdit: () => _openEditDialog(context),
            onDelete: () => _confirmDelete(context), horizontal: true),
        ]);
    }

    Widget buildMobileLayout() {
      return CustomContainer(
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, spacing: Dimensions.paddingSizeSmall, children: [
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              CustomItemTextWidget(text: title),
              CustomItemTextWidget(text: head),
              CustomItemTextWidget(text: description),
              CustomItemTextWidget(text: featureOne),
              CustomItemTextWidget(text: featureTwo),
              CustomItemTextWidget(text: featureThree),
              CustomItemTextWidget(text: playStore),
              CustomItemTextWidget(text: appStore),

              EditDeleteSection(onEdit: () => _openEditDialog(context),
                  onDelete: () => _confirmDelete(context)),
                ],
              ),
            ),
          ],
        ),
      );
    }

    return Padding(padding: const EdgeInsets.symmetric(vertical: 5),
      child: ResponsiveHelper.isDesktop(context) ? buildDesktopLayout() : buildMobileLayout());
  }

  void _openEditDialog(BuildContext context) {
    Get.dialog(
      Dialog(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: SizedBox(width: ResponsiveHelper.isDesktop(context) ? 600 : Get.width,
          child: Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
            child: CreateNewMobileAppSectionWidget(mobileAppItem: mobileAppItem))),
      ),
    );
  }

  void _confirmDelete(BuildContext context) {
    Get.dialog(
      ConfirmationDialog(title: "mobile_app_item".tr, content: "mobile_app_item".tr,
        onTap: () {
          Get.back();
          Get.find<MobileAppController>().deleteMobileApp(mobileAppItem?.id ?? 0);
        },
      ),
    );
  }
}
