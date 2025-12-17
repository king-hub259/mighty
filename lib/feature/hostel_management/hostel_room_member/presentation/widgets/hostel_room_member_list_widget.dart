
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/layout/list_layout_widget.dart';
import 'package:mighty_school/feature/hostel_management/hostel_members/domain/model/hostel_member_model.dart';
import 'package:mighty_school/feature/hostel_management/hostel_members/logic/hostel_members_controller.dart';
import 'package:mighty_school/feature/hostel_management/hostel_members/presentation/screens/add_new_hostel_member_screen.dart';
import 'package:mighty_school/feature/hostel_management/hostel_members/presentation/widgets/hostel_member_item_widget.dart';

class HostelRoomMemberListWidget extends StatelessWidget {
  final ScrollController? scrollController;

  const HostelRoomMemberListWidget({super.key, this.scrollController});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HostelMembersController>(
      initState: (val) {
        if(Get.find<HostelMembersController>().hostelMemberModel == null){
          Get.find<HostelMembersController>().getHostelMembersList();
        }
      },
      builder: (memberController) {
        final memberModel = memberController.hostelMemberModel;
        final memberData = memberModel?.data;

        return GenericListSection<HostelMemberItem>(
          sectionTitle: "hostel_management".tr,
          pathItems: ["hostel_room_members".tr],
          addNewTitle: "add_new_hostel_room_member".tr,
          onAddNewTap: () => Get.dialog(const AddNewHostelMemberScreen()),
          headings: const ["name", "roll", "class", "section", "action"],
          scrollController: scrollController ?? ScrollController(),
          isLoading: memberModel == null,
          totalSize:  0,
          offset:  0,
          onPaginate: (offset) async => await memberController.getHostelMembersList(page: offset ?? 1),

          items: memberData?.data ?? [],
          itemBuilder: (item, index) => HostelMemberItemWidget(memberItem: item, index: index),
        );
      },
    );
  }
}
