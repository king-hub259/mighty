import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/layout/list_layout_widget.dart';
import 'package:mighty_school/feature/staff_information/staff/controller/staff_controller.dart';
import 'package:mighty_school/feature/staff_information/staff/presentation/widgets/staff_item.dart';
import 'package:mighty_school/helper/route_helper.dart';

class StaffListWidget extends StatelessWidget {
  final bool showHeading;
  final ScrollController scrollController;
  const StaffListWidget({super.key, required this.scrollController, this.showHeading = true});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StaffController>(
      initState: (val) => Get.find<StaffController>().getStaffList(1),
      builder: (staffController) {
        final staffModel = staffController.staffModel;
        final staffData = staffModel?.data;

        return GenericListSection(
          sectionTitle: showHeading? "staff_information".tr : "salary_management".tr,
          pathItems: [showHeading? "staff_list".tr : "due_payment".tr],
          addNewTitle: showHeading ? "add_new_staff".tr : null,
          onAddNewTap: () => Get.toNamed(RouteHelper.getAddNewStaffRoute()),
          headings:  ["image", "name", "phone", "email", "designation", if(!showHeading)"action"],

          scrollController: scrollController,
          isLoading: staffModel == null,
          totalSize: staffData?.total ?? 0,
          offset: staffData?.currentPage ?? 0,
          onPaginate: (offset) async => await staffController.getStaffList(offset ?? 1),

          items: staffData?.data ?? [],
          itemBuilder: (item, index) => StaffItemWidget(
            duePayment: showHeading ? false : true,
            index: index,
            staffItem: item,
          ),
        );
      },
    );
  }
}