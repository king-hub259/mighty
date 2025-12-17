import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_button.dart';
import 'package:mighty_school/common/widget/custom_text_field.dart';
import 'package:mighty_school/common/widget/dialog_pattern.dart';
import 'package:mighty_school/feature/transportation_management/transport_bus/domain/model/transport_bus_body.dart';
import 'package:mighty_school/feature/transportation_management/transport_bus/domain/model/transport_bus_model.dart';
import 'package:mighty_school/feature/transportation_management/transport_bus/logic/transport_bus_controller.dart';
import 'package:mighty_school/util/dimensions.dart';

class CreateNewTransportBusDialog extends StatefulWidget {
  final TransportBusItem? transportBusItem;
  const CreateNewTransportBusDialog({super.key, this.transportBusItem});

  @override
  State<CreateNewTransportBusDialog> createState() => _CreateNewTransportBusDialogState();
}

class _CreateNewTransportBusDialogState extends State<CreateNewTransportBusDialog> {
  final TextEditingController _busNumberController = TextEditingController();
  final TextEditingController _busModelController = TextEditingController();
  final TextEditingController _busCapacityController = TextEditingController();
  final TextEditingController _registrationNumberController = TextEditingController();
  final TextEditingController _insuranceNumberController = TextEditingController();
  final TextEditingController _insuranceExpiryController = TextEditingController();
  final TextEditingController _fitnessExpiryController = TextEditingController();
  
  String selectedStatus = 'active';
  int? selectedDriverId;
  int? selectedRouteId;

  @override
  void initState() {
    super.initState();
    if (widget.transportBusItem != null) {
      _busNumberController.text = widget.transportBusItem!.busNumber ?? '';
      _busModelController.text = widget.transportBusItem!.busModel ?? '';
      _busCapacityController.text = widget.transportBusItem!.busCapacity ?? '';
      _registrationNumberController.text = widget.transportBusItem!.registrationNumber ?? '';
      _insuranceNumberController.text = widget.transportBusItem!.insuranceNumber ?? '';
      _insuranceExpiryController.text = widget.transportBusItem!.insuranceExpiry ?? '';
      _fitnessExpiryController.text = widget.transportBusItem!.fitnessExpiry ?? '';
      selectedStatus = widget.transportBusItem!.status ?? 'active';
      selectedDriverId = int.tryParse(widget.transportBusItem!.driverId ?? '');
      selectedRouteId = int.tryParse(widget.transportBusItem!.routeId ?? '');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TransportBusController>(builder: (transportBusController) {
      return DialogPattern(
        title: widget.transportBusItem != null ? "edit_transport_bus".tr : "add_new_transport_bus".tr,
        subTitle: "",
        child: Column(children: [
          Row(children: [
            Expanded(child: CustomTextField(
              title: "bus_number".tr,
              controller: _busNumberController,
              inputType: TextInputType.text,
            )),
            const SizedBox(width: Dimensions.paddingSizeDefault),
            Expanded(child: CustomTextField(
              title: "bus_model".tr,
              controller: _busModelController,
              inputType: TextInputType.text,
            )),
          ]),
          const SizedBox(height: Dimensions.paddingSizeDefault),
          
          Row(children: [
            Expanded(child: CustomTextField(
              title: "bus_capacity".tr,
              controller: _busCapacityController,
              inputType: TextInputType.number,
            )),
            const SizedBox(width: Dimensions.paddingSizeDefault),
            Expanded(child: CustomTextField(
              title: "registration_number".tr,
              controller: _registrationNumberController,
              inputType: TextInputType.text,
            )),
          ]),
          const SizedBox(height: Dimensions.paddingSizeDefault),
          
          Row(children: [
            Expanded(child: CustomTextField(
              title: "insurance_number".tr,
              controller: _insuranceNumberController,
              inputType: TextInputType.text,
            )),
            const SizedBox(width: Dimensions.paddingSizeDefault),
            Expanded(child: CustomTextField(
              title: "insurance_expiry".tr,
              controller: _insuranceExpiryController,
              inputType: TextInputType.datetime,
            )),
          ]),
          const SizedBox(height: Dimensions.paddingSizeDefault),
          
          CustomTextField(
            title: "fitness_expiry".tr,
            controller: _fitnessExpiryController,
            inputType: TextInputType.datetime,
          ),
          const SizedBox(height: Dimensions.paddingSizeDefault),

          CustomButton(
            isLoading: transportBusController.isLoading,
            text: widget.transportBusItem != null ? "update".tr : "add".tr,
            onTap: () {
              TransportBusBody transportBusBody = TransportBusBody(
                busNumber: _busNumberController.text.trim(),
                busModel: _busModelController.text.trim(),
                busCapacity: int.tryParse(_busCapacityController.text.trim()),
                driverId: selectedDriverId,
                routeId: selectedRouteId,
                status: selectedStatus,
                registrationNumber: _registrationNumberController.text.trim(),
                insuranceNumber: _insuranceNumberController.text.trim(),
                insuranceExpiry: _insuranceExpiryController.text.trim(),
                fitnessExpiry: _fitnessExpiryController.text.trim(),
              );

              if (widget.transportBusItem != null) {
                transportBusController.updateTransportBus(transportBusBody, widget.transportBusItem!.id!);
              } else {
                transportBusController.createTransportBus(transportBusBody);
              }
            },
          ),
        ]),
      );
    });
  }
}
