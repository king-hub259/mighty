import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/layout/list_layout_widget.dart';
import 'package:mighty_school/feature/library_management/library_member/controller/library_member_controller.dart';
import 'package:mighty_school/feature/library_management/library_member/domain/model/library_member_model.dart';
import 'package:mighty_school/feature/library_management/library_member/presentation/widgets/library_member_item_widget.dart';

class LibraryMemberListWidget extends StatelessWidget {
  final ScrollController? scrollController;

  const LibraryMemberListWidget({super.key, this.scrollController});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LibraryMemberController>(
      initState: (_) => Get.find<LibraryMemberController>().getMemberList(1),
      builder: (memberController) {
        final memberModel = memberController.libraryMemberModel;
        final memberData = memberModel?.data;

        return GenericListSection<LibraryMemberItem>(
          sectionTitle: "library_management".tr,
          pathItems: ["library_member".tr],
          headings: const [ "image", "id","name", "type",],
          scrollController: scrollController ?? ScrollController(),
          isLoading: memberModel == null,
          totalSize: memberData?.total ?? 0,
          offset: memberData?.currentPage ?? 0,
          onPaginate: (offset) async =>
          await memberController.getMemberList(offset ?? 1),
          items: memberData?.data ?? [],
          itemBuilder: (item, index) =>
              LibraryMemberItemWidget(memberItem: item, index: index),
        );
      },
    );
  }
}
