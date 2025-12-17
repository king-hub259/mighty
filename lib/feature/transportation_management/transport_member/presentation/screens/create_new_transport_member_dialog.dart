import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_button.dart';
import 'package:mighty_school/common/widget/custom_text_field.dart';
import 'package:mighty_school/common/widget/custom_title.dart';
import 'package:mighty_school/feature/transportation_management/transport_member/domain/model/transport_member_body.dart';
import 'package:mighty_school/feature/transportation_management/transport_member/domain/model/transport_member_model.dart';
import 'package:mighty_school/feature/transportation_management/transport_member/logic/transport_member_controller.dart';
import 'package:mighty_school/util/dimensions.dart';

class CreateNewTransportMemberDialog extends StatefulWidget {
  final TransportMemberItem? transportMemberItem;
  const CreateNewTransportMemberDialog({super.key, this.transportMemberItem});

  @override
  State<CreateNewTransportMemberDialog> createState() => _CreateNewTransportMemberDialogState();
}

class _CreateNewTransportMemberDialogState extends State<CreateNewTransportMemberDialog> {
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  final TextEditingController _monthlyFeeController = TextEditingController();
  final TextEditingController _pickupTimeController = TextEditingController();
  final TextEditingController _dropTimeController = TextEditingController();
  
  String selectedStatus = 'active';
  String selectedMembershipType = 'monthly';
  int? selectedStudentId;
  int? selectedRouteId;
  int? selectedStopId;

  @override
  void initState() {
    super.initState();
    if (widget.transportMemberItem != null) {
      _startDateController.text = widget.transportMemberItem!.startDate ?? '';
      _endDateController.text = widget.transportMemberItem!.endDate ?? '';
      _monthlyFeeController.text = widget.transportMemberItem!.monthlyFee ?? '';
      _pickupTimeController.text = widget.transportMemberItem!.pickupTime ?? '';
      _dropTimeController.text = widget.transportMemberItem!.dropTime ?? '';
      selectedStatus = widget.transportMemberItem!.status ?? 'active';
      selectedMembershipType = widget.transportMemberItem!.membershipType ?? 'monthly';
      selectedStudentId = int.tryParse(widget.transportMemberItem!.studentId ?? '');
      selectedRouteId = int.tryParse(widget.transportMemberItem!.routeId ?? '');
      selectedStopId = int.tryParse(widget.transportMemberItem!.stopId ?? '');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TransportMemberController>(builder: (transportMemberController) {
      return Dialog(

        child: Column(children: [
          CustomTitle(title:  widget.transportMemberItem != null ? "edit_transport_member".tr : "add_new_transport_member".tr),
          Row(children: [
            Expanded(child: DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: "membership_type".tr,
                border: const OutlineInputBorder(),
              ),
              value: selectedMembershipType,
              items: ['monthly', 'yearly', 'one_time'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value.tr),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedMembershipType = newValue!;
                });
              },
            )),
            const SizedBox(width: Dimensions.paddingSizeDefault),
            Expanded(child: DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: "status".tr,
                border: const OutlineInputBorder(),
              ),
              value: selectedStatus,
              items: ['active', 'inactive', 'suspended'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value.tr),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedStatus = newValue!;
                });
              },
            )),
          ]),
          const SizedBox(height: Dimensions.paddingSizeDefault),
          
          Row(children: [
            Expanded(child: CustomTextField(
              title: "start_date".tr,
              controller: _startDateController,
              inputType: TextInputType.datetime,
            )),
            const SizedBox(width: Dimensions.paddingSizeDefault),
            Expanded(child: CustomTextField(
              title: "end_date".tr,
              controller: _endDateController,
              inputType: TextInputType.datetime,
            )),
          ]),
          const SizedBox(height: Dimensions.paddingSizeDefault),
          
          Row(children: [
            Expanded(child: CustomTextField(
              title: "monthly_fee".tr,
              controller: _monthlyFeeController,
              inputType: TextInputType.number,
            )),
            const SizedBox(width: Dimensions.paddingSizeDefault),
            Expanded(child: CustomTextField(
              title: "pickup_time".tr,
              controller: _pickupTimeController,
              inputType: TextInputType.datetime,
            )),
          ]),
          const SizedBox(height: Dimensions.paddingSizeDefault),
          
          CustomTextField(
            title: "drop_time".tr,
            controller: _dropTimeController,
            inputType: TextInputType.datetime,
          ),
          const SizedBox(height: Dimensions.paddingSizeDefault),

          CustomButton(
            isLoading: transportMemberController.isLoading,
            text: widget.transportMemberItem != null ? "update".tr : "add".tr,
            onTap: () {
              TransportMemberBody transportMemberBody = TransportMemberBody(
                studentId: selectedStudentId,
                routeId: selectedRouteId,
                stopId: selectedStopId,
                membershipType: selectedMembershipType,
                startDate: _startDateController.text.trim(),
                endDate: _endDateController.text.trim(),
                monthlyFee: _monthlyFeeController.text.trim(),
                status: selectedStatus,
                pickupTime: _pickupTimeController.text.trim(),
                dropTime: _dropTimeController.text.trim(),
              );

              if (widget.transportMemberItem != null) {
                transportMemberController.updateTransportMember(transportMemberBody, widget.transportMemberItem!.id!);
              } else {
                transportMemberController.createTransportMember(transportMemberBody);
              }
            },
          ),
        ]),
      );
    });
  }
}
