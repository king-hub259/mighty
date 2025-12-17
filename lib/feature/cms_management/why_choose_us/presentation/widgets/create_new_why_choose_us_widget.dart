import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_button.dart';
import 'package:mighty_school/common/widget/custom_text_field.dart';
import 'package:mighty_school/feature/cms_management/why_choose_us/domain/model/why_choose_us_model.dart';
import 'package:mighty_school/feature/cms_management/why_choose_us/logic/why_choose_us_controller.dart';
import 'package:mighty_school/feature/cms_management/why_choose_us/presentation/widgets/why_choose_us_image_widget.dart';
import 'package:mighty_school/util/dimensions.dart';

class CreateNewWhyChooseUsWidget extends StatefulWidget {
  final WhyChooseUsItem? whyChooseUsItem;
  const CreateNewWhyChooseUsWidget({super.key, this.whyChooseUsItem});

  @override
  State<CreateNewWhyChooseUsWidget> createState() => _CreateNewWhyChooseUsWidgetState();
}

class _CreateNewWhyChooseUsWidgetState extends State<CreateNewWhyChooseUsWidget> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();


  @override
  void initState() {
    if(widget.whyChooseUsItem != null) {
      titleController.text = widget.whyChooseUsItem?.title??'';
      descriptionController.text = widget.whyChooseUsItem?.description??'';

    }
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return GetBuilder<WhyChooseUsController>(
      builder: (whyChooseUsController) {
        return Column(mainAxisSize: MainAxisSize.min, children: [
          CustomTextField(title: "title".tr, hintText: "title".tr, controller: titleController, maxLength: 100),
          CustomTextField(title: "description".tr, minLines: 3, maxLines: 5, inputType: TextInputType.multiline,
            inputAction: TextInputAction.newline,
              hintText: "description".tr, controller: descriptionController, maxLength: 100),

          const SizedBox(height: Dimensions.paddingSizeOverLarge),
          const WhyChooseUsImageWidget(),
          const SizedBox(height: Dimensions.paddingSizeLarge),
          whyChooseUsController.loading? const Center(child: CircularProgressIndicator()) :
          CustomButton(
            onTap: () {
              String title = titleController.text.trim();
              String description = descriptionController.text.trim();

              if(widget.whyChooseUsItem != null){
                whyChooseUsController.editWhyChooseUs(title, description, widget.whyChooseUsItem!.id!);
              }else {
                whyChooseUsController.createWhyChooseUs(title, description);
              }

            },
            text: widget.whyChooseUsItem != null?"update".tr : "add".tr,
          ),
        ]);
      }
    );
  }
}