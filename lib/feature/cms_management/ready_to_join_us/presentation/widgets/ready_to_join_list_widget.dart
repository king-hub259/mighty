import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/layout/list_layout_widget.dart';
import 'package:mighty_school/feature/cms_management/ready_to_join_us/domain/model/ready_to_join_model.dart';
import 'package:mighty_school/feature/cms_management/ready_to_join_us/logic/ready_to_join_controller.dart';
import 'package:mighty_school/feature/cms_management/ready_to_join_us/presentation/widgets/create_new_ready_to_join_widget.dart';
import 'package:mighty_school/feature/cms_management/ready_to_join_us/presentation/widgets/ready_to_join_item_widget.dart';
import 'package:mighty_school/helper/responsive_helper.dart';
import 'package:mighty_school/util/dimensions.dart';

class ReadyToJoinListWidget extends StatelessWidget {
  final ScrollController scrollController;
  const ReadyToJoinListWidget({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ReadyToJoinController>(
      initState: (val) => Get.find<ReadyToJoinController>().getReadyToJoin(1),
      builder: (readyToJoinController) {
        final readyToJoinModel = readyToJoinController.readyToJoinModel;
        final readyToJoinData = readyToJoinModel?.data;

        return GenericListSection<ReadyToJoinItem>(
          sectionTitle: "cms_management".tr,
          pathItems: ["ready_to_join".tr],
          addNewTitle: "add_new_ready_to_join".tr,
          onAddNewTap: () => Get.dialog(Dialog(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: SizedBox(width: ResponsiveHelper.isDesktop(context) ? 600 : Get.width,
              child: const Padding(padding: EdgeInsets.all(Dimensions.paddingSizeDefault),
                child: CreateNewReadyToJoinWidget())))),
          headings: const ["image", "title", "description", "button_name", "button_link", "action"],

          scrollController: scrollController,
          isLoading: readyToJoinModel == null,
          totalSize: readyToJoinData?.total ?? 0,
          offset: readyToJoinData?.currentPage ?? 1,
          onPaginate: (offset) async => await readyToJoinController.getReadyToJoin(offset ?? 1),
          items: readyToJoinData?.data ?? [],
          itemBuilder: (item, index) => ReadyToJoinItemWidget(index: index, readyToJoinItem: item),
        );
      },
    );
  }
}