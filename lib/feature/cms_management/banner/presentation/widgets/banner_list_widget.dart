import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/layout/list_layout_widget.dart';
import 'package:mighty_school/feature/cms_management/banner/domain/model/banner_model.dart';
import 'package:mighty_school/feature/cms_management/banner/logic/banner_controller.dart';
import 'package:mighty_school/feature/cms_management/banner/presentation/widgets/banner_item_widget.dart';
import 'package:mighty_school/feature/cms_management/banner/presentation/widgets/create_new_banner_widget.dart';
import 'package:mighty_school/helper/responsive_helper.dart';
import 'package:mighty_school/util/dimensions.dart';

class BannerListWidget extends StatelessWidget {
  final ScrollController scrollController;
  const BannerListWidget({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BannerController>(
      initState: (val) => Get.find<BannerController>().getBanner(1),
      builder: (bannerController) {
        final bannerModel = bannerController.bannerModel;
        final bannerData = bannerModel?.data;

        return GenericListSection<BannerItem>(
          sectionTitle: "cms_management".tr,
          pathItems: ["banner".tr],
          addNewTitle: "add_new_banner".tr,
          onAddNewTap: () => Get.dialog(Dialog(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: SizedBox(width: ResponsiveHelper.isDesktop(context) ? 600 : Get.width,
              child: const Padding(padding: EdgeInsets.all(Dimensions.paddingSizeDefault),
                child: CreateNewBannerWidget())))),
          headings: const ["image", "title", "description", "button_name", "button_link", "action"],

          scrollController: scrollController,
          isLoading: bannerModel == null,
          totalSize: bannerData?.total ?? 0,
          offset: bannerData?.currentPage ?? 1,
          onPaginate: (offset) async => await bannerController.getBanner(offset ?? 1),
          items: bannerData?.data ?? [],
          itemBuilder: (item, index) => BannerItemWidget(index: index, bannerItem: item),
        );
      },
    );
  }
}