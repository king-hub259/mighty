import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_button.dart';
import 'package:mighty_school/common/widget/custom_text_field.dart';
import 'package:mighty_school/common/widget/dialog_pattern.dart';
import 'package:mighty_school/feature/transportation_management/transport_bus_stop/domain/model/transport_bus_stop_body.dart';
import 'package:mighty_school/feature/transportation_management/transport_bus_stop/domain/model/transport_bus_stop_model.dart';
import 'package:mighty_school/feature/transportation_management/transport_bus_stop/logic/transport_bus_stop_controller.dart';
import 'package:mighty_school/util/dimensions.dart';

class CreateNewTransportBusStopDialog extends StatefulWidget {
  final TransportBusStopItem? transportBusStopItem;
  const CreateNewTransportBusStopDialog({super.key, this.transportBusStopItem});

  @override
  State<CreateNewTransportBusStopDialog> createState() => _CreateNewTransportBusStopDialogState();
}

class _CreateNewTransportBusStopDialogState extends State<CreateNewTransportBusStopDialog> {
  final TextEditingController _stopNameController = TextEditingController();
  final TextEditingController _stopCodeController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _latitudeController = TextEditingController();
  final TextEditingController _longitudeController = TextEditingController();
  final TextEditingController _landmarkController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  
  String selectedStatus = 'active';

  @override
  void initState() {
    super.initState();
    if (widget.transportBusStopItem != null) {
      _stopNameController.text = widget.transportBusStopItem!.stopName ?? '';
      _stopCodeController.text = widget.transportBusStopItem!.stopCode ?? '';
      _addressController.text = widget.transportBusStopItem!.address ?? '';
      _latitudeController.text = widget.transportBusStopItem!.latitude ?? '';
      _longitudeController.text = widget.transportBusStopItem!.longitude ?? '';
      _landmarkController.text = widget.transportBusStopItem!.landmark ?? '';
      _descriptionController.text = widget.transportBusStopItem!.description ?? '';
      selectedStatus = widget.transportBusStopItem!.status ?? 'active';
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TransportBusStopController>(builder: (transportBusStopController) {
      return DialogPattern(
        title: widget.transportBusStopItem != null ? "edit_transport_bus_stop".tr : "add_new_transport_bus_stop".tr,
        subTitle: "",
        child: Column(children: [
          Row(children: [
            Expanded(child: CustomTextField(
              title: "stop_name".tr,
              controller: _stopNameController,
              inputType: TextInputType.text,
            )),
            const SizedBox(width: Dimensions.paddingSizeDefault),
            Expanded(child: CustomTextField(
              title: "stop_code".tr,
              controller: _stopCodeController,
              inputType: TextInputType.text,
            )),
          ]),
          const SizedBox(height: Dimensions.paddingSizeDefault),
          
          Row(children: [
            Expanded(child: CustomTextField(
              title: "latitude".tr,
              controller: _latitudeController,
              inputType: TextInputType.number,
            )),
            const SizedBox(width: Dimensions.paddingSizeDefault),
            Expanded(child: CustomTextField(
              title: "longitude".tr,
              controller: _longitudeController,
              inputType: TextInputType.number,
            )),
          ]),
          const SizedBox(height: Dimensions.paddingSizeDefault),
          
          CustomTextField(
            title: "landmark".tr,
            controller: _landmarkController,
            inputType: TextInputType.text,
          ),
          const SizedBox(height: Dimensions.paddingSizeDefault),

          CustomTextField(
            title: "address".tr,
            controller: _addressController,
            inputType: TextInputType.multiline,
            maxLines: 3,
          ),
          const SizedBox(height: Dimensions.paddingSizeDefault),

          CustomTextField(
            title: "description".tr,
            controller: _descriptionController,
            inputType: TextInputType.multiline,
            maxLines: 3,
          ),
          const SizedBox(height: Dimensions.paddingSizeDefault),

          CustomButton(
            isLoading: transportBusStopController.isLoading,
            text: widget.transportBusStopItem != null ? "update".tr : "add".tr,
            onTap: () {
              TransportBusStopBody transportBusStopBody = TransportBusStopBody(
                stopName: _stopNameController.text.trim(),
                stopCode: _stopCodeController.text.trim(),
                address: _addressController.text.trim(),
                latitude: _latitudeController.text.trim(),
                longitude: _longitudeController.text.trim(),
                landmark: _landmarkController.text.trim(),
                status: selectedStatus,
                description: _descriptionController.text.trim(),
              );

              if (widget.transportBusStopItem != null) {
                transportBusStopController.updateTransportBusStop(transportBusStopBody, widget.transportBusStopItem!.id!);
              } else {
                transportBusStopController.createTransportBusStop(transportBusStopBody);
              }
            },
          ),
        ]),
      );
    });
  }
}
