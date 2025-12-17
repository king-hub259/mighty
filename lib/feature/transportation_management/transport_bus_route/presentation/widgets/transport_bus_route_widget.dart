import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/layout/list_layout_widget.dart';
import 'package:mighty_school/feature/transportation_management/transport_bus_route/domain/model/transport_bus_route_model.dart';
import 'package:mighty_school/feature/transportation_management/transport_bus_route/logic/transport_bus_route_controller.dart';
import 'package:mighty_school/feature/transportation_management/transport_bus_route/presentation/screens/create_new_transport_bus_route_dialog.dart';
import 'package:mighty_school/feature/transportation_management/transport_bus_route/presentation/widgets/transport_bus_route_item_widget.dart';

class TransportBusRouteWidget extends StatelessWidget {
  final ScrollController scrollController;
  const TransportBusRouteWidget({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TransportBusRouteController>(builder: (transportBusRouteController) {
      TransportBusRouteModel? transportBusRouteModel = transportBusRouteController.transportBusRouteModel;
      Data? transportBusRouteData = transportBusRouteModel?.data;

      return GenericListSection<TransportBusRouteItem>(
        sectionTitle: "transportation_management".tr,
        pathItems: ["transport_bus_route".tr],
        addNewTitle: "add_new_transport_bus_route".tr,
        onAddNewTap: () => Get.dialog(const CreateNewTransportBusRouteDialog()),
        headings: const ["route_name", "route_code", "start_location", "end_location", "distance", "fare", "status", "action"],
        scrollController: scrollController,
        isLoading: transportBusRouteModel == null,
        totalSize: transportBusRouteData?.total ?? 0,
        offset: transportBusRouteData?.currentPage ?? 0,
        onPaginate: (offset) async => await transportBusRouteController.getTransportBusRouteList(offset ?? 1),
        items: transportBusRouteData?.data ?? [],
        itemBuilder: (item, index) => TransportBusRouteItemWidget(transportBusRouteItem: item, index: index),
      );
    });
  }
}