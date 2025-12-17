import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_button.dart';
import 'package:mighty_school/common/widget/custom_text_field.dart';
import 'package:mighty_school/common/widget/dialog_pattern.dart';
import 'package:mighty_school/feature/transportation_management/transport_bus_route/domain/model/transport_bus_route_body.dart';
import 'package:mighty_school/feature/transportation_management/transport_bus_route/domain/model/transport_bus_route_model.dart';
import 'package:mighty_school/feature/transportation_management/transport_bus_route/logic/transport_bus_route_controller.dart';
import 'package:mighty_school/util/dimensions.dart';

class CreateNewTransportBusRouteDialog extends StatefulWidget {
  final TransportBusRouteItem? transportBusRouteItem;
  const CreateNewTransportBusRouteDialog({super.key, this.transportBusRouteItem});

  @override
  State<CreateNewTransportBusRouteDialog> createState() => _CreateNewTransportBusRouteDialogState();
}

class _CreateNewTransportBusRouteDialogState extends State<CreateNewTransportBusRouteDialog> {
  final TextEditingController _routeNameController = TextEditingController();
  final TextEditingController _routeCodeController = TextEditingController();
  final TextEditingController _startLocationController = TextEditingController();
  final TextEditingController _endLocationController = TextEditingController();
  final TextEditingController _distanceController = TextEditingController();
  final TextEditingController _durationController = TextEditingController();
  final TextEditingController _fareController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  
  String selectedStatus = 'active';

  @override
  void initState() {
    super.initState();
    if (widget.transportBusRouteItem != null) {
      _routeNameController.text = widget.transportBusRouteItem!.routeName ?? '';
      _routeCodeController.text = widget.transportBusRouteItem!.routeCode ?? '';
      _startLocationController.text = widget.transportBusRouteItem!.startLocation ?? '';
      _endLocationController.text = widget.transportBusRouteItem!.endLocation ?? '';
      _distanceController.text = widget.transportBusRouteItem!.distance ?? '';
      _durationController.text = widget.transportBusRouteItem!.duration ?? '';
      _fareController.text = widget.transportBusRouteItem!.fare ?? '';
      _descriptionController.text = widget.transportBusRouteItem!.description ?? '';
      selectedStatus = widget.transportBusRouteItem!.status ?? 'active';
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TransportBusRouteController>(builder: (transportBusRouteController) {
      return DialogPattern(
        title: widget.transportBusRouteItem != null ? "edit_transport_bus_route".tr : "add_new_transport_bus_route".tr,
        subTitle: "",
        child: Column(children: [
          Row(children: [
            Expanded(child: CustomTextField(
              title: "route_name".tr,
              controller: _routeNameController,
              inputType: TextInputType.text,
            )),
            const SizedBox(width: Dimensions.paddingSizeDefault),
            Expanded(child: CustomTextField(
              title: "route_code".tr,
              controller: _routeCodeController,
              inputType: TextInputType.text,
            )),
          ]),
          const SizedBox(height: Dimensions.paddingSizeDefault),
          
          Row(children: [
            Expanded(child: CustomTextField(
              title: "start_location".tr,
              controller: _startLocationController,
              inputType: TextInputType.text,
            )),
            const SizedBox(width: Dimensions.paddingSizeDefault),
            Expanded(child: CustomTextField(
              title: "end_location".tr,
              controller: _endLocationController,
              inputType: TextInputType.text,
            )),
          ]),
          const SizedBox(height: Dimensions.paddingSizeDefault),
          
          Row(children: [
            Expanded(child: CustomTextField(
              title: "distance".tr,
              controller: _distanceController,
              inputType: TextInputType.number,
            )),
            const SizedBox(width: Dimensions.paddingSizeDefault),
            Expanded(child: CustomTextField(
              title: "duration".tr,
              controller: _durationController,
              inputType: TextInputType.number,
            )),
          ]),
          const SizedBox(height: Dimensions.paddingSizeDefault),
          
          CustomTextField(
            title: "fare".tr,
            controller: _fareController,
            inputType: TextInputType.number,
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
            isLoading: transportBusRouteController.isLoading,
            text: widget.transportBusRouteItem != null ? "update".tr : "add".tr,
            onTap: () {
              TransportBusRouteBody transportBusRouteBody = TransportBusRouteBody(
                routeName: _routeNameController.text.trim(),
                routeCode: _routeCodeController.text.trim(),
                startLocation: _startLocationController.text.trim(),
                endLocation: _endLocationController.text.trim(),
                distance: _distanceController.text.trim(),
                duration: _durationController.text.trim(),
                fare: _fareController.text.trim(),
                status: selectedStatus,
                description: _descriptionController.text.trim(),
              );

              if (widget.transportBusRouteItem != null) {
                transportBusRouteController.updateTransportBusRoute(transportBusRouteBody, widget.transportBusRouteItem!.id!);
              } else {
                transportBusRouteController.createTransportBusRoute(transportBusRouteBody);
              }
            },
          ),
        ]),
      );
    });
  }
}
