import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/confirmation_dialog.dart';
import 'package:mighty_school/common/widget/edit_delete_section.dart';
import 'package:mighty_school/common/widget/numbering_widget.dart';
import 'package:mighty_school/feature/academic_configuration/group/controller/group_controller.dart';
import 'package:mighty_school/feature/academic_configuration/group/domain/model/group_model.dart';
import 'package:mighty_school/feature/academic_configuration/group/presentation/widgets/create_new_group_dialog.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';

class GroupItemWidget extends StatelessWidget {
  final GroupItem? groupItem;
  final int index;
  const GroupItemWidget({super.key, this.groupItem, required this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.fromLTRB(Dimensions.paddingSizeDefault, Dimensions.paddingSizeDefault, Dimensions.paddingSizeDefault, 0),
      child: Row(spacing: Dimensions.paddingSizeDefault, crossAxisAlignment: CrossAxisAlignment.start, children: [

        NumberingWidget(index: index),
        Expanded(child: Text('${groupItem?.groupName}', style: textRegular.copyWith())),
        EditDeleteSection(horizontal: true, onDelete: (){
          Get.dialog(ConfirmationDialog(title: "group", content: "group",
            onTap: (){
              Get.back();
              Get.find<GroupController>().deleteGroup(groupItem!.id!);
            },));

        }, onEdit: (){
          Get.dialog(CreateNewGroupDialog(groupItem: groupItem));
        },)
      ],
      ),
    );
  }

}
