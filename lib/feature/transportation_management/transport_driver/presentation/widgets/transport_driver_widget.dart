import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/layout/list_layout_widget.dart';
import 'package:mighty_school/feature/transportation_management/transport_driver/domain/model/transport_driver_model.dart';
import 'package:mighty_school/feature/transportation_management/transport_driver/logic/transport_driver_controller.dart';
import 'package:mighty_school/feature/transportation_management/transport_driver/presentation/screens/create_new_transport_driver_dialog.dart';
import 'package:mighty_school/feature/transportation_management/transport_driver/presentation/widgets/transport_driver_item_widget.dart';

class TransportDriverWidget extends StatelessWidget {
  final ScrollController scrollController;
  const TransportDriverWidget({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TransportDriverController>(builder: (transportDriverController) {
      TransportDriverModel? transportDriverModel = transportDriverController.transportDriverModel;
      Data? transportDriverData = transportDriverModel?.data;

      return GenericListSection<TransportDriverItem>(
        sectionTitle: "transportation_management".tr,
        pathItems: ["transport_driver".tr],
        addNewTitle: "add_new_transport_driver".tr,
        onAddNewTap: () => Get.dialog(const CreateNewTransportDriverDialog()),
        headings: const ["name", "phone", "license_number", "experience", "salary", "status", "action"],
        scrollController: scrollController,
        isLoading: transportDriverModel == null,
        totalSize: transportDriverData?.total ?? 0,
        offset: transportDriverData?.currentPage ?? 0,
        onPaginate: (offset) async => await transportDriverController.getTransportDriverList(offset ?? 1),
        items: transportDriverData?.data ?? [],
        itemBuilder: (item, index) => TransportDriverItemWidget(transportDriverItem: item, index: index),
      );
    });
  }
}