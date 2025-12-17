import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/confirmation_dialog.dart';
import 'package:mighty_school/common/widget/edit_delete_section.dart';
import 'package:mighty_school/common/widget/numbering_widget.dart';
import 'package:mighty_school/feature/transportation_management/transport_bus/domain/model/transport_bus_model.dart';
import 'package:mighty_school/feature/transportation_management/transport_bus/logic/transport_bus_controller.dart';
import 'package:mighty_school/feature/transportation_management/transport_bus/presentation/screens/create_new_transport_bus_dialog.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';

class TransportBusItemWidget extends StatelessWidget {
  final TransportBusItem transportBusItem;
  final int index;
  const TransportBusItemWidget({super.key, required this.transportBusItem, required this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.fromLTRB(Dimensions.paddingSizeDefault, Dimensions.paddingSizeDefault, Dimensions.paddingSizeDefault, 0),
      child: Row(spacing: Dimensions.paddingSizeDefault, crossAxisAlignment: CrossAxisAlignment.start, children: [

        NumberingWidget(index: index),
        Expanded(child: Text('${transportBusItem.busNumber}', style: textRegular.copyWith())),
        Expanded(child: Text('${transportBusItem.busModel}', style: textRegular.copyWith())),
        Expanded(child: Text('${transportBusItem.busCapacity}', style: textRegular.copyWith())),
        Expanded(child: Text(transportBusItem.driver?.name ?? "N/A", style: textRegular.copyWith())),
        Expanded(child: Text(transportBusItem.route?.routeName ?? "N/A", style: textRegular.copyWith())),
        Expanded(child: Text('${transportBusItem.status}', style: textRegular.copyWith())),
        EditDeleteSection(horizontal: true, onDelete: (){
          Get.dialog(ConfirmationDialog(title: "transport_bus", content: "transport_bus",
            onTap: (){
              Get.back();
              Get.find<TransportBusController>().deleteTransportBus(transportBusItem.id!);
            },));

        }, onEdit: (){
          Get.dialog(CreateNewTransportBusDialog(transportBusItem: transportBusItem));
        },)
      ],
      ),
    );
  }
}
