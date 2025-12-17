import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/layout/list_layout_widget.dart';
import 'package:mighty_school/feature/transportation_management/transport_bus_stop/domain/model/transport_bus_stop_model.dart';
import 'package:mighty_school/feature/transportation_management/transport_bus_stop/logic/transport_bus_stop_controller.dart';
import 'package:mighty_school/feature/transportation_management/transport_bus_stop/presentation/screens/create_new_transport_bus_stop_dialog.dart';
import 'package:mighty_school/feature/transportation_management/transport_bus_stop/presentation/widgets/transport_bus_stop_item_widget.dart';

class TransportBusStopWidget extends StatelessWidget {
  final ScrollController scrollController;
  const TransportBusStopWidget({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TransportBusStopController>(builder: (transportBusStopController) {
      TransportBusStopModel? transportBusStopModel = transportBusStopController.transportBusStopModel;
      Data? transportBusStopData = transportBusStopModel?.data;

      return GenericListSection<TransportBusStopItem>(
        sectionTitle: "transportation_management".tr,
        pathItems: ["transport_bus_stop".tr],
        addNewTitle: "add_new_transport_bus_stop".tr,
        onAddNewTap: () => Get.dialog(const CreateNewTransportBusStopDialog()),
        headings: const ["stop_name", "stop_code", "address", "landmark", "status", "action"],
        scrollController: scrollController,
        isLoading: transportBusStopModel == null,
        totalSize: transportBusStopData?.total ?? 0,
        offset: transportBusStopData?.currentPage ?? 0,
        onPaginate: (offset) async => await transportBusStopController.getTransportBusStopList(offset ?? 1),
        items: transportBusStopData?.data ?? [],
        itemBuilder: (item, index) => TransportBusStopItemWidget(transportBusStopItem: item, index: index),
      );
    });
  }
}