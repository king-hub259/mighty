import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_button.dart';
import 'package:mighty_school/common/widget/custom_text_field.dart';
import 'package:mighty_school/feature/cms_management/banner/domain/model/banner_body.dart';
import 'package:mighty_school/feature/cms_management/banner/domain/model/banner_model.dart';
import 'package:mighty_school/feature/cms_management/banner/logic/banner_controller.dart';
import 'package:mighty_school/feature/cms_management/banner/presentation/widgets/banner_image_widget.dart';
import 'package:mighty_school/util/dimensions.dart';

class CreateNewBannerWidget extends StatefulWidget {
  final BannerItem? bannerItem;
  const CreateNewBannerWidget({super.key, this.bannerItem});

  @override
  State<CreateNewBannerWidget> createState() => _CreateNewBannerWidgetState();
}

class _CreateNewBannerWidgetState extends State<CreateNewBannerWidget> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController buttonNameController = TextEditingController();
  TextEditingController buttonLinkController = TextEditingController();

  @override
  void initState() {
    if(widget.bannerItem != null) {
      titleController.text = widget.bannerItem?.title??'';
      descriptionController.text = widget.bannerItem?.description??'';
      buttonNameController.text = widget.bannerItem?.buttonName??'';
      buttonLinkController.text = widget.bannerItem?.buttonLink??'';
    }
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return GetBuilder<BannerController>(
      builder: (bannerController) {
        return Column(mainAxisSize: MainAxisSize.min,spacing: Dimensions.paddingSizeSmall, children: [
          CustomTextField(title: "title".tr, hintText: "title".tr, controller: titleController, maxLength: 100),
          CustomTextField(title: "description".tr, minLines: 3, maxLines: 5, inputType: TextInputType.multiline,
            inputAction: TextInputAction.newline,
              hintText: "description".tr, controller: descriptionController, maxLength: 100),
          CustomTextField(title: "button_name".tr, hintText: "button_name".tr, controller: buttonNameController, maxLength: 100),
          CustomTextField(title: "button_link".tr, hintText: "button_link".tr, controller: buttonLinkController, maxLength: 100),
          const BannerImageWidget(),
          const SizedBox(height: Dimensions.paddingSizeLarge),
          bannerController.loading? const Center(child: CircularProgressIndicator()) :
          CustomButton(
            onTap: () {
              String title = titleController.text.trim();
              String description = descriptionController.text.trim();
              String buttonName = buttonNameController.text.trim();
              String buttonLink = buttonLinkController.text.trim();

              BannerBody body = BannerBody(
                title: title,
                description: description,
                buttonName: buttonName,
                buttonLink: buttonLink,
                method: widget.bannerItem != null? 'PUT' : "POST",

              );
              if(widget.bannerItem != null){
                bannerController.editBanner(body, widget.bannerItem!.id!);
              }else {
                bannerController.createBanner(body);
              }

            },
            text: widget.bannerItem != null?"update".tr : "add".tr,
          ),
        ]);
      }
    );
  }
}