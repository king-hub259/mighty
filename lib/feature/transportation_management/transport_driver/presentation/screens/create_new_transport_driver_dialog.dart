import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_button.dart';
import 'package:mighty_school/common/widget/custom_text_field.dart';
import 'package:mighty_school/common/widget/dialog_pattern.dart';
import 'package:mighty_school/feature/transportation_management/transport_driver/domain/model/transport_driver_body.dart';
import 'package:mighty_school/feature/transportation_management/transport_driver/domain/model/transport_driver_model.dart';
import 'package:mighty_school/feature/transportation_management/transport_driver/logic/transport_driver_controller.dart';
import 'package:mighty_school/util/dimensions.dart';

class CreateNewTransportDriverDialog extends StatefulWidget {
  final TransportDriverItem? transportDriverItem;
  const CreateNewTransportDriverDialog({super.key, this.transportDriverItem});

  @override
  State<CreateNewTransportDriverDialog> createState() => _CreateNewTransportDriverDialogState();
}

class _CreateNewTransportDriverDialogState extends State<CreateNewTransportDriverDialog> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _licenseNumberController = TextEditingController();
  final TextEditingController _licenseExpiryController = TextEditingController();
  final TextEditingController _experienceController = TextEditingController();
  final TextEditingController _joiningDateController = TextEditingController();
  final TextEditingController _salaryController = TextEditingController();
  
  String selectedStatus = 'active';

  @override
  void initState() {
    super.initState();
    if (widget.transportDriverItem != null) {
      _nameController.text = widget.transportDriverItem!.name ?? '';
      _phoneController.text = widget.transportDriverItem!.phone ?? '';
      _emailController.text = widget.transportDriverItem!.email ?? '';
      _addressController.text = widget.transportDriverItem!.address ?? '';
      _licenseNumberController.text = widget.transportDriverItem!.licenseNumber ?? '';
      _licenseExpiryController.text = widget.transportDriverItem!.licenseExpiry ?? '';
      _experienceController.text = widget.transportDriverItem!.experience ?? '';
      _joiningDateController.text = widget.transportDriverItem!.joiningDate ?? '';
      _salaryController.text = widget.transportDriverItem!.salary ?? '';
      selectedStatus = widget.transportDriverItem!.status ?? 'active';
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TransportDriverController>(builder: (transportDriverController) {
      return DialogPattern(
        title: widget.transportDriverItem != null ? "edit_transport_driver".tr : "add_new_transport_driver".tr,
        subTitle: "",
        child: Column(children: [
          Row(children: [
            Expanded(child: CustomTextField(
              title: "name".tr,
              controller: _nameController,
              inputType: TextInputType.text,
            )),
            const SizedBox(width: Dimensions.paddingSizeDefault),
            Expanded(child: CustomTextField(
              title: "phone".tr,
              controller: _phoneController,
              inputType: TextInputType.phone,
            )),
          ]),
          const SizedBox(height: Dimensions.paddingSizeDefault),
          
          Row(children: [
            Expanded(child: CustomTextField(
              title: "email".tr,
              controller: _emailController,
              inputType: TextInputType.emailAddress,
            )),
            const SizedBox(width: Dimensions.paddingSizeDefault),
            Expanded(child: CustomTextField(
              title: "license_number".tr,
              controller: _licenseNumberController,
              inputType: TextInputType.text,
            )),
          ]),
          const SizedBox(height: Dimensions.paddingSizeDefault),
          
          Row(children: [
            Expanded(child: CustomTextField(
              title: "license_expiry".tr,
              controller: _licenseExpiryController,
              inputType: TextInputType.datetime,
            )),
            const SizedBox(width: Dimensions.paddingSizeDefault),
            Expanded(child: CustomTextField(
              title: "experience".tr,
              controller: _experienceController,
              inputType: TextInputType.number,
            )),
          ]),
          const SizedBox(height: Dimensions.paddingSizeDefault),
          
          Row(children: [
            Expanded(child: CustomTextField(
              title: "joining_date".tr,
              controller: _joiningDateController,
              inputType: TextInputType.datetime,
            )),
            const SizedBox(width: Dimensions.paddingSizeDefault),
            Expanded(child: CustomTextField(
              title: "salary".tr,
              controller: _salaryController,
              inputType: TextInputType.number,
            )),
          ]),
          const SizedBox(height: Dimensions.paddingSizeDefault),
          
          CustomTextField(
            title: "address".tr,
            controller: _addressController,
            inputType: TextInputType.multiline,
            maxLines: 3,
          ),
          const SizedBox(height: Dimensions.paddingSizeDefault),

          CustomButton(
            isLoading: transportDriverController.isLoading,
            text: widget.transportDriverItem != null ? "update".tr : "add".tr,
            onTap : () {
              TransportDriverBody transportDriverBody = TransportDriverBody(
                name: _nameController.text.trim(),
                phone: _phoneController.text.trim(),
                email: _emailController.text.trim(),
                address: _addressController.text.trim(),
                licenseNumber: _licenseNumberController.text.trim(),
                licenseExpiry: _licenseExpiryController.text.trim(),
                experience: _experienceController.text.trim(),
                status: selectedStatus,
                joiningDate: _joiningDateController.text.trim(),
                salary: _salaryController.text.trim(),
              );

              if (widget.transportDriverItem != null) {
                transportDriverController.updateTransportDriver(transportDriverBody, widget.transportDriverItem!.id!);
              } else {
                transportDriverController.createTransportDriver(transportDriverBody);
              }
            },
          ),
        ]),
      );
    });
  }
}
