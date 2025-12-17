import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/confirmation_dialog.dart';
import 'package:mighty_school/common/widget/custom_contaner.dart';
import 'package:mighty_school/common/widget/custom_divider.dart';
import 'package:mighty_school/common/widget/custom_image.dart';
import 'package:mighty_school/common/widget/custom_item_text_widget.dart';
import 'package:mighty_school/common/widget/edit_delete_section.dart';
import 'package:mighty_school/common/widget/numbering_widget.dart';
import 'package:mighty_school/feature/cms_management/faq/domain/model/faq_model.dart';
import 'package:mighty_school/feature/cms_management/faq/logic/faq_controller.dart';
import 'package:mighty_school/feature/cms_management/faq/presentation/widgets/create_new_faq_widget.dart';
import 'package:mighty_school/helper/responsive_helper.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';

class FaqItemWidget extends StatelessWidget {
  final FaqItem? faqItem;
  final int index;
  const FaqItemWidget({super.key, this.faqItem, required this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.symmetric(vertical: 5),
      child: ResponsiveHelper.isDesktop(context)?
      Row(crossAxisAlignment: CrossAxisAlignment.start, spacing: Dimensions.paddingSizeSmall, children: [
        NumberingWidget(index: index),
        Expanded(child: CustomItemTextWidget(text:"${faqItem?.question}", )),
        Expanded(child: CustomItemTextWidget(text:faqItem?.answer??'')),
        _buildEditDeleteSection(context),
      ]):

      CustomContainer(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Expanded(child: CustomItemTextWidget(text:"${faqItem?.question}", )),
        Expanded(child: CustomItemTextWidget(text:faqItem?.answer??'')),
        _buildEditDeleteSection(context),
        const SizedBox(height: Dimensions.paddingSizeExtraSmall),

      ])),
    );
  }
  Widget _buildEditDeleteSection(BuildContext context) {
    return EditDeleteSection(onEdit: () {
        Get.dialog(Dialog(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: SizedBox(width: ResponsiveHelper.isDesktop(context) ? 600 : Get.width,
              child: Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                child: CreateNewFaqWidget(faqItem: faqItem)))),
        );
      },
      onDelete: () {
        Get.dialog(ConfirmationDialog(title: "faq", content: "are_you_sure_to_delete_this_faq".tr,
            onTap: () {
              Get.back();
              Get.find<FaqController>().deleteFaq(faqItem?.id ?? 0);
            },
          ),
        );
      },
      horizontal: ResponsiveHelper.isDesktop(context),
    );
  }
}
