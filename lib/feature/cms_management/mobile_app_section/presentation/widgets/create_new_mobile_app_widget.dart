import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_button.dart';
import 'package:mighty_school/common/widget/custom_snackbar.dart';
import 'package:mighty_school/common/widget/custom_text_field.dart';
import 'package:mighty_school/common/widget/image_picker_widget.dart';
import 'package:mighty_school/feature/cms_management/mobile_app_section/domain/model/mobile_app_body.dart';
import 'package:mighty_school/feature/cms_management/mobile_app_section/domain/model/mobile_app_model.dart';
import 'package:mighty_school/feature/cms_management/mobile_app_section/logic/mobile_app_controller.dart';
import 'package:mighty_school/util/app_constants.dart';
import 'package:mighty_school/util/dimensions.dart';

class CreateNewMobileAppSectionWidget extends StatefulWidget {
  final MobileAppItem? mobileAppItem;
  const CreateNewMobileAppSectionWidget({super.key, this.mobileAppItem});

  @override
  State<CreateNewMobileAppSectionWidget> createState() => _CreateNewMobileAppSectionWidgetState();
}

class _CreateNewMobileAppSectionWidgetState extends State<CreateNewMobileAppSectionWidget> {
  TextEditingController titleController = TextEditingController();
  TextEditingController headingController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController featureOneController = TextEditingController();
  TextEditingController featureTwoController = TextEditingController();
  TextEditingController featureThreeController = TextEditingController();
  TextEditingController playStoreController = TextEditingController();
  TextEditingController appStoreController = TextEditingController();


  @override
  void initState() {
    if(widget.mobileAppItem != null) {
      titleController.text = widget.mobileAppItem?.title??'';
      descriptionController.text = widget.mobileAppItem?.description??'';
      headingController.text = widget.mobileAppItem?.heading??'';
      featureOneController.text = widget.mobileAppItem?.featureOne??'';
      featureTwoController.text = widget.mobileAppItem?.featureTwo??'';
      featureThreeController.text = widget.mobileAppItem?.featureThree??'';
      playStoreController.text = widget.mobileAppItem?.playStoreLink??'';
      appStoreController.text = widget.mobileAppItem?.appStoreLink??'';


    }
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return GetBuilder<MobileAppController>(
      builder: (mobileAppController) {
        return SingleChildScrollView(
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            ImagePickerWidget(pickedFile: mobileAppController.thumbnail, imageUrl: "${AppConstants.imageBaseUrl}/mobile_app_sections/${widget.mobileAppItem?.image}",
                onImagePicked: ()=>
              mobileAppController.pickImage()),
            CustomTextField(title: "title".tr, hintText: "title".tr, controller: titleController, maxLength: 100),
            CustomTextField(title: "heading".tr, hintText: "heading".tr, controller: headingController, maxLength: 100),

            CustomTextField(title: "description".tr, minLines: 3, maxLines: 5, inputType: TextInputType.multiline,
              inputAction: TextInputAction.newline,
                hintText: "description".tr, controller: descriptionController, maxLength: 100),

            CustomTextField(title: "feature_one".tr, hintText: "feature_one".tr, controller: featureOneController, maxLength: 100),
            CustomTextField(title: "feature_two".tr, hintText: "feature_two".tr, controller: featureTwoController, maxLength: 100),
            CustomTextField(title: "feature_three".tr, hintText: "feature_three".tr, controller: featureThreeController, maxLength: 100),
            CustomTextField(title: "play_store_link".tr, hintText: "play_store_link".tr, controller: playStoreController, maxLength: 200),
            CustomTextField(title: "app_store_link".tr, hintText: "app_store_link".tr, controller: appStoreController, maxLength: 200),





            const SizedBox(height: Dimensions.paddingSizeLarge),
            mobileAppController.loading? const Center(child: CircularProgressIndicator()) :
            CustomButton(
              onTap: () {
                String title = titleController.text.trim();
                String heading = headingController.text.trim();
                String description = descriptionController.text.trim();
                String featureOne = featureOneController.text.trim();
                String featureTwo = featureTwoController.text.trim();
                String featureThree = featureThreeController.text.trim();
                String playStore = playStoreController.text.trim();
                String appStore = appStoreController.text.trim();

                if(title.isEmpty) {
                  showCustomSnackBar("title".tr);
                }
                else{
                  MobileAppBody body = MobileAppBody(
                    title: title,
                    heading: heading,
                    description: description,
                    featureOne: featureOne,
                    featureTwo: featureTwo,
                    featureThree: featureThree,
                    playStoreLink: playStore,
                    appStoreLink: appStore,
                    sMethod: widget.mobileAppItem != null? "PUT" :"POST",
                  );
                  if(widget.mobileAppItem != null){
                    mobileAppController.editMobileApp(body, widget.mobileAppItem!.id!);
                  }else {
                    mobileAppController.createMobileApp(body);
                  }
                }

              },
              text: widget.mobileAppItem != null?"update".tr : "add".tr,
            ),
          ]),
        );
      }
    );
  }
}