import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/layout/list_layout_widget.dart';
import 'package:mighty_school/feature/administrator/notice/controller/notice_controller.dart';
import 'package:mighty_school/feature/administrator/notice/domain/models/notice_model.dart';
import 'package:mighty_school/feature/administrator/notice/presentation/screens/create_new_notice_screen.dart';
import 'package:mighty_school/feature/administrator/notice/presentation/widgets/notice_item_widget.dart';

class NoticeListWidget extends StatelessWidget {
  final ScrollController scrollController;
  final bool dashBoardScreen;
  const NoticeListWidget({super.key, required this.scrollController, this.dashBoardScreen = false});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NoticeController>(
      initState: (val) => Get.find<NoticeController>().getNoticeList(1),
      builder: (noticeController) {
        final noticeModel = noticeController.noticeModel;
        final noticeData = noticeModel?.data;

        return GenericListSection<NoticeItem>(
          showRouteSection: dashBoardScreen ? false : true,
          sectionTitle: "administrator".tr,
          pathItems: ["notice_list".tr],
          addNewTitle: "add".tr,
          onAddNewTap: () => Get.dialog(const CreateNewNoticeScreen()),
          headings:  ["notice", "description", (!dashBoardScreen)?"action":''],

          scrollController: scrollController,
          isLoading: noticeModel == null,
          totalSize: noticeData?.total ?? 0,
          offset: noticeData?.currentPage ?? 0,
          onPaginate: (offset) async => await noticeController.getNoticeList(offset ?? 1),

          items: noticeData?.data ?? [],
          itemBuilder: (item, index) => NoticeItemWidget(dashBoardScreen: dashBoardScreen,
              index: index, noticeItem: item),
        );
      },
    );
  }
}