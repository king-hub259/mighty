import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_contaner.dart';
import 'package:mighty_school/common/widget/custom_item_text_widget.dart';
import 'package:mighty_school/common/widget/edit_delete_section.dart';
import 'package:mighty_school/common/widget/numbering_widget.dart';
import 'package:mighty_school/feature/hostel_management/hostel_members/domain/model/hostel_member_model.dart';
import 'package:mighty_school/feature/hostel_management/hostel_members/logic/hostel_members_controller.dart';
import 'package:mighty_school/feature/hostel_management/hostel_members/presentation/screens/add_new_hostel_member_screen.dart';
import 'package:mighty_school/util/dimensions.dart';

class HostelMemberItemWidget extends StatelessWidget {
  final HostelMemberItem memberItem;
  final int index;
  
  const HostelMemberItemWidget({super.key, required this.memberItem, required this.index});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HostelMembersController>(builder: (memberController) {
        return  _buildDesktopView(context, memberController);
      },
    );
  }

  Widget _buildDesktopView(BuildContext context, HostelMembersController memberController) {
    return Row(spacing: Dimensions.paddingSizeDefault, children: [
      NumberingWidget(index: index),
      Expanded(child: CustomItemTextWidget(text: memberItem.name ?? '')),
      Expanded(child: CustomItemTextWidget(text: memberItem.roll ?? '')),
      Expanded(child: CustomItemTextWidget(text: memberItem.className ?? '')),
      Expanded(child: CustomItemTextWidget(text: memberItem.sectionName ?? '')),

        EditDeleteSection(horizontal: true,
          onEdit: () => Get.dialog(AddNewHostelMemberScreen(memberId: memberItem.id)),
          onDelete: () => memberController.deleteHostelMember(memberItem.id!),
        ),
      ],
    );
  }

}
