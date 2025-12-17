import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/confirmation_dialog.dart';
import 'package:mighty_school/common/widget/custom_contaner.dart';
import 'package:mighty_school/common/widget/custom_image.dart';
import 'package:mighty_school/common/widget/custom_item_text_widget.dart';
import 'package:mighty_school/common/widget/edit_delete_section.dart';
import 'package:mighty_school/common/widget/numbering_widget.dart';
import 'package:mighty_school/feature/cms_management/why_choose_us/domain/model/why_choose_us_model.dart';
import 'package:mighty_school/feature/cms_management/why_choose_us/logic/why_choose_us_controller.dart';
import 'package:mighty_school/feature/cms_management/why_choose_us/presentation/widgets/create_new_why_choose_us_widget.dart';
import 'package:mighty_school/helper/responsive_helper.dart';
import 'package:mighty_school/util/app_constants.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';

class WhyChooseUsItemWidget extends StatelessWidget {
  final WhyChooseUsItem? whyChooseUsItem;
  final int index;

  const WhyChooseUsItemWidget({super.key, this.whyChooseUsItem, required this.index});

  @override
  Widget build(BuildContext context) {
    final title = whyChooseUsItem?.title ?? '';
    final description = whyChooseUsItem?.description ?? '';
    final image = "${AppConstants.imageBaseUrl}/why_choose_us/${whyChooseUsItem?.icon}";

    Widget buildDesktopLayout() {
      return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          NumberingWidget(index: index),
          const SizedBox(width: Dimensions.paddingSizeSmall),
          CustomImage(image: image, width: 60, height: 60, radius: 5),
          const SizedBox(width: Dimensions.paddingSizeSmall),
          Expanded(child: CustomItemTextWidget(text: title)),
          Expanded(child: CustomItemTextWidget(text: description)),
          EditDeleteSection(onEdit: () => _openEditDialog(context), onDelete: () => _confirmDelete(context), horizontal: true),
        ]);
    }

    Widget buildMobileLayout() {
      return CustomContainer(
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('${index + 1}. ', style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall)),
            ClipRRect(borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
              child: CustomImage(width: Dimensions.imageSizeBig, height: Dimensions.imageSizeBig, image: image)),
            const SizedBox(width: Dimensions.paddingSizeSmall),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, spacing: Dimensions.paddingSizeExtraSmall, children: [
              CustomItemTextWidget(text: title),
              CustomItemTextWidget(text: description),
              EditDeleteSection(onEdit: () => _openEditDialog(context), onDelete: () => _confirmDelete(context)),
                ],
              ),
            ),
          ],
        ),
      );
    }

    return Padding(padding: const EdgeInsets.symmetric(vertical: 5), child: ResponsiveHelper.isDesktop(context) ? buildDesktopLayout() : buildMobileLayout());
  }

  void _openEditDialog(BuildContext context) {
    Get.dialog(
      Dialog(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: SizedBox(width: ResponsiveHelper.isDesktop(context) ? 600 : Get.width,
          child: Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
            child: CreateNewWhyChooseUsWidget(whyChooseUsItem: whyChooseUsItem))),
      ),
    );
  }

  void _confirmDelete(BuildContext context) {
    Get.dialog(
      ConfirmationDialog(title: "benefit".tr, content: "are_you_sure_to_delete_this_benefit".tr,
        onTap: () {
          Get.back();
          Get.find<WhyChooseUsController>().deleteWhyChooseUs(whyChooseUsItem?.id ?? 0);
        },
      ),
    );
  }
}
