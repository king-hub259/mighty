import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/confirmation_dialog.dart';
import 'package:mighty_school/common/widget/custom_contaner.dart';
import 'package:mighty_school/common/widget/custom_item_text_widget.dart';
import 'package:mighty_school/common/widget/edit_delete_section.dart';
import 'package:mighty_school/common/widget/numbering_widget.dart';
import 'package:mighty_school/feature/hostel_management/hostel_rooms/domain/model/hostel_room_model.dart';
import 'package:mighty_school/feature/hostel_management/hostel_rooms/logic/hostel_rooms_controller.dart';
import 'package:mighty_school/feature/hostel_management/hostel_rooms/presentation/screens/add_new_hostel_room_screen.dart';
import 'package:mighty_school/util/dimensions.dart';

class HostelRoomItemWidget extends StatelessWidget {
  final HostelRoomItem roomItem;
  final int index;

  const HostelRoomItemWidget({super.key, required this.roomItem, required this.index});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HostelRoomsController>(builder: (roomsController) {
        return _buildDesktopView(context, roomsController);
      },
    );
  }

  Widget _buildDesktopView(BuildContext context, HostelRoomsController roomsController) {
    return Row(spacing: Dimensions.paddingSizeDefault, children: [

      NumberingWidget(index: index),
      Expanded(child: CustomItemTextWidget(text: roomItem.roomNumber ?? '')),
      Expanded(child: CustomItemTextWidget(text: roomItem.capacity?.toString() ?? '')),

        // Actions
        EditDeleteSection(horizontal: true, onEdit: () => Get.dialog(AddNewHostelRoomScreen(roomItem: roomItem)),
          onDelete: (){
          Get.dialog(ConfirmationDialog(title: "room".tr,
              content: "room".tr,
              onTap: (){
            Get.back();
            roomsController.deleteHostelRoom(roomItem.id!);}));
          },
        ),
      ],
    );
  }

}
