import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/layout/list_layout_widget.dart';
import 'package:mighty_school/feature/transportation_management/transport_bus/domain/model/transport_bus_model.dart';
import 'package:mighty_school/feature/transportation_management/transport_bus/logic/transport_bus_controller.dart';
import 'package:mighty_school/feature/transportation_management/transport_bus/presentation/screens/create_new_transport_bus_dialog.dart';
import 'package:mighty_school/feature/transportation_management/transport_bus/presentation/widgets/transport_bus_item_widget.dart';

class TransportBusWidget extends StatelessWidget {
  final ScrollController scrollController;
  const TransportBusWidget({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TransportBusController>(builder: (transportBusController) {
      TransportBusModel? transportBusModel = transportBusController.transportBusModel;
      Data? transportBusData = transportBusModel?.data;

      return GenericListSection<TransportBusItem>(
        sectionTitle: "transportation_management".tr,
        pathItems: ["transport_bus".tr],
        addNewTitle: "add_new_transport_bus".tr,
        onAddNewTap: () => Get.dialog(const CreateNewTransportBusDialog()),
        headings: const ["bus_number", "model", "capacity", "driver", "route", "status", "action"],
        scrollController: scrollController,
        isLoading: transportBusModel == null,
        totalSize: transportBusData?.total ?? 0,
        offset: transportBusData?.currentPage ?? 0,
        onPaginate: (offset) async => await transportBusController.getTransportBusList(offset ?? 1),
        items: transportBusData?.data ?? [],
        itemBuilder: (item, index) => TransportBusItemWidget(transportBusItem: item, index: index),
      );
    });
  }
}