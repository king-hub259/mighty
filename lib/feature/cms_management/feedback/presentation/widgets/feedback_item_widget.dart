import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/confirmation_dialog.dart';
import 'package:mighty_school/common/widget/custom_contaner.dart';
import 'package:mighty_school/common/widget/custom_item_text_widget.dart';
import 'package:mighty_school/common/widget/edit_delete_section.dart';
import 'package:mighty_school/common/widget/numbering_widget.dart';
import 'package:mighty_school/feature/cms_management/feedback/domain/model/feedback_model.dart';
import 'package:mighty_school/feature/cms_management/feedback/logic/feedback_controller.dart';
import 'package:mighty_school/feature/cms_management/feedback/presentation/widgets/create_new_feedback_widget.dart';
import 'package:mighty_school/helper/responsive_helper.dart';
import 'package:mighty_school/util/dimensions.dart';

class FeedbackItemWidget extends StatelessWidget {
  final FeedbackItem? feedbackItem;
  final int index;
  const FeedbackItemWidget({super.key, this.feedbackItem, required this.index});

  void _onEdit(BuildContext context) {
    Get.dialog(Dialog(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: SizedBox(width: ResponsiveHelper.isDesktop(context)? 600 : Get.width,
          child: Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
            child: CreateNewFeedbackWidget(feedbackItem: feedbackItem,),
          ),
        )));
  }

  void _onDelete() {
    Get.dialog(ConfirmationDialog(
        title: "feedback",
        content: "are_you_sure_to_delete_this_feedback".tr,
        onTap: (){
          Get.back();
          Get.find<FeedbackController>().deleteFeedback(feedbackItem?.id??0);
        }));
  }

  @override
  Widget build(BuildContext context) {
    final editDelete = EditDeleteSection(onEdit: () => _onEdit(context), onDelete: _onDelete, horizontal: ResponsiveHelper.isDesktop(context));
    return Padding(padding: const EdgeInsets.symmetric(vertical: 5),
      child: ResponsiveHelper.isDesktop(context)?
      Row(crossAxisAlignment: CrossAxisAlignment.start, spacing: Dimensions.paddingSizeSmall, children: [
        NumberingWidget(index: index),
        Expanded(child: CustomItemTextWidget(text :feedbackItem?.name??'N/A',)),
        Expanded(child: CustomItemTextWidget(text: feedbackItem?.description??'')),
        editDelete
      ]):
      CustomContainer(child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          CustomItemTextWidget(text:feedbackItem?.name??'N/A'),
          CustomItemTextWidget(text:feedbackItem?.description??''),
        ])),
        editDelete
      ])),
    );
  }
}
