import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/layout/list_layout_widget.dart';
import 'package:mighty_school/feature/hostel_management/hostel/domain/model/hostel_model.dart';
import 'package:mighty_school/feature/hostel_management/hostel/logic/hostel_controller.dart';
import 'package:mighty_school/feature/hostel_management/hostel/presentation/screens/add_new_hostel_screen.dart';
import 'package:mighty_school/feature/hostel_management/hostel/presentation/widgets/hostel_item_widget.dart';

class HostelListWidget extends StatelessWidget {
  final ScrollController? scrollController;
  
  const HostelListWidget({super.key, this.scrollController});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HostelController>(
      initState: (val) => Get.find<HostelController>().getHostelList(1),
      builder: (hostelController) {
        final hostelModel = hostelController.hostelModel;
        final hostelData = hostelModel?.data;
        return GenericListSection<HostelItem>(
          sectionTitle: "hostel_management".tr,
          pathItems: ["hostels".tr],
          addNewTitle: "add_new_hostel".tr,
          onAddNewTap: () => Get.dialog(const AddNewHostelScreen()),
          headings: const ["name", "address", "type", "action"],
          
          scrollController: scrollController ?? ScrollController(),
          isLoading: hostelModel == null,
          totalSize: hostelData?.total ?? 0,
          offset: hostelData?.currentPage ?? 0,
          onPaginate: (offset) async => await hostelController.getHostelList(offset ?? 1),
          items: hostelData?.data ?? [],
          itemBuilder: (item, index) => HostelItemWidget(hostelItem: item, index: index));
      },
    );
  }
}
