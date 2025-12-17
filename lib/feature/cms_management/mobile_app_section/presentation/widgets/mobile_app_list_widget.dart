import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/layout/list_layout_widget.dart';
import 'package:mighty_school/feature/cms_management/mobile_app_section/domain/model/mobile_app_model.dart';
import 'package:mighty_school/feature/cms_management/mobile_app_section/logic/mobile_app_controller.dart';
import 'package:mighty_school/feature/cms_management/mobile_app_section/presentation/widgets/create_new_mobile_app_widget.dart';
import 'package:mighty_school/feature/cms_management/mobile_app_section/presentation/widgets/mobile_app_item_widget.dart';
import 'package:mighty_school/helper/responsive_helper.dart';
import 'package:mighty_school/util/dimensions.dart';

class MobileAppListWidget extends StatelessWidget {
  final ScrollController scrollController;
  const MobileAppListWidget({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MobileAppController>(
      initState: (val) => Get.find<MobileAppController>().getMobileApp(1),
      builder: (mobileAppController) {
        final mobileAppModel = mobileAppController.mobileAppModel;
        final mobileAppData = mobileAppModel?.data;

        return GenericListSection<MobileAppItem>(
          sectionTitle: "cms_management".tr,
          pathItems: ["mobile_app_section".tr],
          addNewTitle: "add".tr,
          onAddNewTap: () => Get.dialog(Dialog(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: SizedBox(width: ResponsiveHelper.isDesktop(context) ? 600 : Get.width,
              child: const Padding(padding: EdgeInsets.all(Dimensions.paddingSizeDefault),
                child: SingleChildScrollView(child: CreateNewMobileAppSectionWidget()))))),

          headings: const ["image", "title", "heading", "description", "feature_one", "feature_two", "feature_three", "play_store", "app_store","action"],

          scrollController: scrollController,
          isLoading: mobileAppData == null,
          totalSize: mobileAppData?.total ?? 0,
          offset: mobileAppData?.currentPage ?? 1,
          onPaginate: (offset) async => await mobileAppController.getMobileApp(offset ?? 1),

          items: mobileAppData?.data ?? [],
          itemBuilder: (item, index) => MobileAppItemWidget(mobileAppItem: item, index: index),
        );
      },
    );
  }
}