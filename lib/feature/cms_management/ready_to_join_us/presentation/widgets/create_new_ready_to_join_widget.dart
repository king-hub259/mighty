import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_button.dart';
import 'package:mighty_school/common/widget/custom_pick_image_widget.dart';
import 'package:mighty_school/common/widget/custom_text_field.dart';
import 'package:mighty_school/feature/cms_management/ready_to_join_us/domain/model/ready_to_join_body.dart';
import 'package:mighty_school/feature/cms_management/ready_to_join_us/domain/model/ready_to_join_model.dart';
import 'package:mighty_school/feature/cms_management/ready_to_join_us/logic/ready_to_join_controller.dart';
import 'package:mighty_school/util/app_constants.dart';
import 'package:mighty_school/util/dimensions.dart';

class CreateNewReadyToJoinWidget extends StatefulWidget {
  final ReadyToJoinItem? readyToJoinItem;
  const CreateNewReadyToJoinWidget({super.key, this.readyToJoinItem});

  @override
  State<CreateNewReadyToJoinWidget> createState() => _CreateNewReadyToJoinWidgetState();
}

class _CreateNewReadyToJoinWidgetState extends State<CreateNewReadyToJoinWidget> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController buttonNameController = TextEditingController();
  TextEditingController buttonLinkController = TextEditingController();

  @override
  void initState() {
    if(widget.readyToJoinItem != null) {
      titleController.text = widget.readyToJoinItem?.title??'';
      descriptionController.text = widget.readyToJoinItem?.description??'';
      buttonNameController.text = widget.readyToJoinItem?.buttonName??'';
      buttonLinkController.text = widget.readyToJoinItem?.buttonLink??'';
    }
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return GetBuilder<ReadyToJoinController>(
      builder: (bannerController) {
        return SingleChildScrollView(
          child: Column(mainAxisSize: MainAxisSize.min,spacing: Dimensions.paddingSizeSmall, children: [
            CustomTextField(title: "title".tr, hintText: "title".tr, controller: titleController, maxLength: 100),
            CustomTextField(title: "description".tr, minLines: 3, maxLines: 5, inputType: TextInputType.multiline,
              inputAction: TextInputAction.newline,
                hintText: "description".tr, controller: descriptionController, maxLength: 100),
            CustomTextField(title: "button_name".tr, hintText: "button_name".tr, controller: buttonNameController, maxLength: 100),
            CustomTextField(title: "button_link".tr, hintText: "button_link".tr, controller: buttonLinkController, maxLength: 100),

             CustomPickImageWidget(imageUrl: "${AppConstants.imageBaseUrl}/ready_to_join/${widget.readyToJoinItem?.icon}",),

            const SizedBox(height: Dimensions.paddingSizeLarge),
            bannerController.loading? const Center(child: CircularProgressIndicator()) :
            CustomButton(
              onTap: () {
                String title = titleController.text.trim();
                String description = descriptionController.text.trim();
                String buttonName = buttonNameController.text.trim();
                String buttonLink = buttonLinkController.text.trim();

                ReadyToJoinBody body = ReadyToJoinBody(
                  title: title,
                  description: description,
                  buttonName: buttonName,
                  buttonLink: buttonLink,
                  method: widget.readyToJoinItem != null? 'PUT' : "POST",

                );
                if(widget.readyToJoinItem != null){
                  bannerController.editReadyToJoin(body, widget.readyToJoinItem!.id!);
                }else {
                  bannerController.createReadyToJoin(body);
                }

              },
              text: widget.readyToJoinItem != null?"update".tr : "add".tr,
            ),
          ]),
        );
      }
    );
  }
}