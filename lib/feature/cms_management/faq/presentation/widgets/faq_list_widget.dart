import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/layout/list_layout_widget.dart';
import 'package:mighty_school/feature/cms_management/faq/domain/model/faq_model.dart';
import 'package:mighty_school/feature/cms_management/faq/logic/faq_controller.dart';
import 'package:mighty_school/feature/cms_management/faq/presentation/widgets/create_new_faq_widget.dart';
import 'package:mighty_school/feature/cms_management/faq/presentation/widgets/faq_item_widget.dart';
import 'package:mighty_school/helper/responsive_helper.dart';
import 'package:mighty_school/util/dimensions.dart';

class FaqListWidget extends StatelessWidget {
  final ScrollController scrollController;
  const FaqListWidget({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FaqController>(
      initState: (val) => Get.find<FaqController>().getFaq(1),
      builder: (faqController) {
        final faqModel = faqController.faqModel;
        final faqData = faqModel?.data;

        return GenericListSection<FaqItem>(
          sectionTitle: "cms_management".tr,
          pathItems: ["faq".tr],
          addNewTitle: "add_new_faq".tr,
          onAddNewTap: () => Get.dialog(Dialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: SizedBox(width: ResponsiveHelper.isDesktop(context) ? 600 : Get.width,
              child: const Padding(padding: EdgeInsets.all(Dimensions.paddingSizeDefault),
                child: CreateNewFaqWidget())))),

          headings: const ["question", "answer", "action"],

          scrollController: scrollController,
          isLoading: faqModel == null,
          totalSize: faqData?.total ?? 0,
          offset: faqData?.currentPage ?? 1,
          onPaginate: (offset) async => await faqController.getFaq(offset ?? 1),
          items: faqData?.data ?? [],
          itemBuilder: (item, index) => FaqItemWidget(faqItem: item, index: index),
        );
      },
    );
  }
}