import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/layout/list_layout_widget.dart';
import 'package:mighty_school/feature/cms_management/feedback/domain/model/feedback_model.dart';
import 'package:mighty_school/feature/cms_management/feedback/logic/feedback_controller.dart';
import 'package:mighty_school/feature/cms_management/feedback/presentation/widgets/create_new_feedback_widget.dart';
import 'package:mighty_school/feature/cms_management/feedback/presentation/widgets/feedback_item_widget.dart';
import 'package:mighty_school/helper/responsive_helper.dart';
import 'package:mighty_school/util/dimensions.dart';

class FeedbackListWidget extends StatelessWidget {
  final ScrollController scrollController;
  const FeedbackListWidget({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FeedbackController>(
      initState: (val) => Get.find<FeedbackController>().getFeedback(1),
      builder: (feedbackController) {
        final feedbackModel = feedbackController.feedbackModel;
        final feedbackData = feedbackModel?.data;

        return GenericListSection<FeedbackItem>(
          sectionTitle: "cms_management".tr,
          pathItems: ["feedback".tr],
          addNewTitle: "add_new_feedback".tr,
          onAddNewTap: () => Get.dialog(Dialog(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: SizedBox(width: ResponsiveHelper.isDesktop(context) ? 600 : Get.width,
              child: const Padding(padding: EdgeInsets.all(Dimensions.paddingSizeDefault),
                child: CreateNewFeedbackWidget())))),

          headings: const [ "name",  "description",  "action"],
          scrollController: scrollController,
          isLoading: feedbackModel == null,
          totalSize: feedbackData?.total ?? 0,
          offset: feedbackData?.currentPage ?? 1,
          onPaginate: (offset) async => await feedbackController.getFeedback(offset ?? 1),
          items: feedbackData?.data ?? [],
          itemBuilder: (item, index) => FeedbackItemWidget(feedbackItem: item, index: index),
        );
      },
    );
  }
}