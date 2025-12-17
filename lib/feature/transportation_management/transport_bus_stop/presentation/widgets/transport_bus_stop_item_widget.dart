import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/confirmation_dialog.dart';
import 'package:mighty_school/common/widget/edit_delete_section.dart';
import 'package:mighty_school/common/widget/numbering_widget.dart';
import 'package:mighty_school/feature/transportation_management/transport_bus_stop/domain/model/transport_bus_stop_model.dart';
import 'package:mighty_school/feature/transportation_management/transport_bus_stop/logic/transport_bus_stop_controller.dart';
import 'package:mighty_school/feature/transportation_management/transport_bus_stop/presentation/screens/create_new_transport_bus_stop_dialog.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';

class TransportBusStopItemWidget extends StatelessWidget {
  final TransportBusStopItem transportBusStopItem;
  final int index;
  const TransportBusStopItemWidget({super.key, required this.transportBusStopItem, required this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.fromLTRB(Dimensions.paddingSizeDefault, Dimensions.paddingSizeDefault, Dimensions.paddingSizeDefault, 0),
      child: Row(spacing: Dimensions.paddingSizeDefault, crossAxisAlignment: CrossAxisAlignment.start, children: [

        NumberingWidget(index: index),
        Expanded(child: Text('${transportBusStopItem.stopName}', style: textRegular.copyWith())),
        Expanded(child: Text('${transportBusStopItem.stopCode}', style: textRegular.copyWith())),
        Expanded(child: Text('${transportBusStopItem.address}', style: textRegular.copyWith())),
        Expanded(child: Text('${transportBusStopItem.landmark}', style: textRegular.copyWith())),
        Expanded(child: Text('${transportBusStopItem.status}', style: textRegular.copyWith())),
        EditDeleteSection(horizontal: true, onDelete: (){
          Get.dialog(ConfirmationDialog(title: "transport_bus_stop", content: "transport_bus_stop",
            onTap: (){
              Get.back();
              Get.find<TransportBusStopController>().deleteTransportBusStop(transportBusStopItem.id!);
            },));

        }, onEdit: (){
          Get.dialog(CreateNewTransportBusStopDialog(transportBusStopItem: transportBusStopItem));
        },)
      ],
      ),
    );
  }
}
