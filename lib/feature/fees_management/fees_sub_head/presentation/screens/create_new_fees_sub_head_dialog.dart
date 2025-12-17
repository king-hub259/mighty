import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_button.dart';
import 'package:mighty_school/common/widget/custom_text_field.dart';
import 'package:mighty_school/common/widget/dialog_pattern.dart';
import 'package:mighty_school/feature/fees_management/fees_sub_head/controller/fees_sub_head_controller.dart';
import 'package:mighty_school/feature/fees_management/fees_sub_head/domain/model/fees_sub_head_model.dart';
import 'package:mighty_school/util/dimensions.dart';

class CreateNewFeesSubHeadDialog extends StatefulWidget {
  final FeesSubHeadItem? feesSubHeadItem;
  const CreateNewFeesSubHeadDialog({super.key, this.feesSubHeadItem});

  @override
  State<CreateNewFeesSubHeadDialog> createState() => _CreateNewFeesSubHeadDialogState();
}

class _CreateNewFeesSubHeadDialogState extends State<CreateNewFeesSubHeadDialog> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _serialController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.feesSubHeadItem != null) {
      _nameController.text = widget.feesSubHeadItem!.name ?? '';
      _serialController.text = widget.feesSubHeadItem!.serial ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FeesSubHeadController>(builder: (feesSubHeadController) {
      return DialogPattern(
        title: widget.feesSubHeadItem != null ? "edit_fees_sub_head".tr : "add_new_fees_sub_head".tr,
        subTitle: "",
        child: Column(children: [
          CustomTextField(
            title: "name".tr,
            controller: _nameController,
            inputType: TextInputType.text,
            hintText: "enter_name".tr,
          ),
          const SizedBox(height: Dimensions.paddingSizeDefault),
          
          CustomTextField(
            title: "serial".tr,
            controller: _serialController,
            inputType: TextInputType.number,
            hintText: "enter_serial".tr,
          ),
          const SizedBox(height: Dimensions.paddingSizeDefault),

          CustomButton(
            isLoading: feesSubHeadController.isLoading,
            text: widget.feesSubHeadItem != null ? "update".tr : "add".tr,
            onTap: () {
              String name = _nameController.text.trim();
              String serial = _serialController.text.trim();
              
              if (name.isEmpty) {
                Get.snackbar("Error", "Name is required");
                return;
              }
              if (serial.isEmpty) {
                Get.snackbar("Error", "Serial is required");
                return;
              }

              if (widget.feesSubHeadItem != null) {
                feesSubHeadController.updateFeesSubHead(name, serial, widget.feesSubHeadItem!.id!);
              } else {
                feesSubHeadController.addNewFeesSubHead(name, serial);
              }
            },
          ),
        ]),
      );
    });
  }
}
