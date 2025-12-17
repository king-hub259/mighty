import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/confirmation_dialog.dart';
import 'package:mighty_school/common/widget/edit_delete_section.dart';
import 'package:mighty_school/common/widget/numbering_widget.dart';
import 'package:mighty_school/feature/transportation_management/transport_bus_route/domain/model/transport_bus_route_model.dart';
import 'package:mighty_school/feature/transportation_management/transport_bus_route/logic/transport_bus_route_controller.dart';
import 'package:mighty_school/feature/transportation_management/transport_bus_route/presentation/screens/create_new_transport_bus_route_dialog.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';

class TransportBusRouteItemWidget extends StatelessWidget {
  final TransportBusRouteItem transportBusRouteItem;
  final int index;
  const TransportBusRouteItemWidget({super.key, required this.transportBusRouteItem, required this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.fromLTRB(Dimensions.paddingSizeDefault, Dimensions.paddingSizeDefault, Dimensions.paddingSizeDefault, 0),
      child: Row(spacing: Dimensions.paddingSizeDefault, crossAxisAlignment: CrossAxisAlignment.start, children: [

        NumberingWidget(index: index),
        Expanded(child: Text('${transportBusRouteItem.routeName}', style: textRegular.copyWith())),
        Expanded(child: Text('${transportBusRouteItem.routeCode}', style: textRegular.copyWith())),
        Expanded(child: Text('${transportBusRouteItem.startLocation}', style: textRegular.copyWith())),
        Expanded(child: Text('${transportBusRouteItem.endLocation}', style: textRegular.copyWith())),
        Expanded(child: Text('${transportBusRouteItem.distance} km', style: textRegular.copyWith())),
        Expanded(child: Text('\$${transportBusRouteItem.fare}', style: textRegular.copyWith())),
        Expanded(child: Text('${transportBusRouteItem.status}', style: textRegular.copyWith())),
        EditDeleteSection(horizontal: true, onDelete: (){
          Get.dialog(ConfirmationDialog(title: "transport_bus_route", content: "transport_bus_route",
            onTap: (){
              Get.back();
              Get.find<TransportBusRouteController>().deleteTransportBusRoute(transportBusRouteItem.id!);
            },));

        }, onEdit: (){
          Get.dialog(CreateNewTransportBusRouteDialog(transportBusRouteItem: transportBusRouteItem));
        },)
      ],
      ),
    );
  }
}
