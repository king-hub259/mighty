import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_button.dart';
import 'package:mighty_school/common/widget/custom_text_field.dart';
import 'package:mighty_school/common/widget/dialog_pattern.dart';
import 'package:mighty_school/feature/fees_management/waiver/controller/waiver_controller.dart';
import 'package:mighty_school/feature/fees_management/waiver/domain/model/waiver_model.dart';
import 'package:mighty_school/util/dimensions.dart';

class CreateNewWaiverDialog extends StatefulWidget {
  final WaiverItem? waiverItem;
  const CreateNewWaiverDialog({super.key, this.waiverItem});

  @override
  State<CreateNewWaiverDialog> createState() => _CreateNewWaiverDialogState();
}

class _CreateNewWaiverDialogState extends State<CreateNewWaiverDialog> {
  final TextEditingController _waiverNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.waiverItem != null) {
      _waiverNameController.text = widget.waiverItem!.waiver ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WaiverController>(builder: (waiverController) {
      return DialogPattern(
        title: widget.waiverItem != null ? "edit_waiver".tr : "add_new_waiver".tr,
        subTitle: "",
        child: Column(children: [
          CustomTextField(
            title: "waiver_name".tr,
            controller: _waiverNameController,
            inputType: TextInputType.text,
            hintText: "enter_waiver_name".tr,
          ),
          const SizedBox(height: Dimensions.paddingSizeDefault),

          CustomButton(
            isLoading: waiverController.isLoading,
            text: widget.waiverItem != null ? "update".tr : "add".tr,
            onTap: () {
              String name = _waiverNameController.text.trim();
              
              if (name.isEmpty) {
                Get.snackbar("Error", "Waiver name is required");
                return;
              }

              if (widget.waiverItem != null) {
                waiverController.updateWaiver(name, "", widget.waiverItem!.id!);
              } else {
                waiverController.addNewWaiver(name);
              }
            },
          ),
        ]),
      );
    });
  }
}
