import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/layout/list_layout_widget.dart';
import 'package:mighty_school/feature/hostel_management/hostel_rooms/domain/model/hostel_room_model.dart';
import 'package:mighty_school/feature/hostel_management/hostel_rooms/logic/hostel_rooms_controller.dart';
import 'package:mighty_school/feature/hostel_management/hostel_rooms/presentation/screens/add_new_hostel_room_screen.dart';
import 'package:mighty_school/feature/hostel_management/hostel_rooms/presentation/widgets/hostel_room_item_widget.dart';

class HostelRoomsListWidget extends StatelessWidget {
  final ScrollController? scrollController;

  const HostelRoomsListWidget({super.key, this.scrollController});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HostelRoomsController>(
      initState: (val){
        if(Get.find<HostelRoomsController>().hostelRoomModel == null){
          Get.find<HostelRoomsController>().getHostelRoomsList();
        }
      },
      builder: (roomsController) {
        var roomsModel = roomsController.hostelRoomModel;
        var roomsData = roomsModel?.data;

        return GenericListSection<HostelRoomItem>(
          sectionTitle: "hostel_management".tr,
          pathItems: ["hostel_rooms".tr],
          addNewTitle: "add_new_hostel_room".tr,
          onAddNewTap: () => Get.dialog( const AddNewHostelRoomScreen()),
          headings: const [
            "room_number",
            "capacity",
            "action"
          ],

          scrollController: scrollController ?? ScrollController(),
          isLoading: roomsModel == null,
          totalSize: roomsData?.total ?? 0,
          offset: roomsData?.currentPage ?? 0,
          onPaginate: (offset) async => await roomsController.getHostelRoomsList(page: offset ?? 1),

          items: roomsData?.data ?? [],
          itemBuilder: (item, index) => HostelRoomItemWidget(
            roomItem: item,
            index: index
          ),
        );
      },
    );
  }
}