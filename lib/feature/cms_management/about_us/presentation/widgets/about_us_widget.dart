import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_button.dart';
import 'package:mighty_school/common/widget/custom_text_field.dart';
import 'package:mighty_school/feature/cms_management/about_us/domain/model/about_us_body.dart';
import 'package:mighty_school/feature/cms_management/about_us/logic/about_us_controller.dart';
import 'package:mighty_school/feature/cms_management/about_us/presentation/widgets/about_us_image_widget.dart';
import 'package:mighty_school/util/dimensions.dart';


class AboutUsWidget extends StatefulWidget {
  const AboutUsWidget({super.key});

  @override
  State<AboutUsWidget> createState() => _AboutUsWidgetState();
}

class _AboutUsWidgetState extends State<AboutUsWidget> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    await Get.find<AboutUsController>().getAboutUs(1);
    var aboutUs = Get.find<AboutUsController>().aboutUsModel?.data?.data?[0];
    if (aboutUs != null) {
      setState(() {
        titleController.text = aboutUs.title ?? '';
        descriptionController.text = aboutUs.description ?? '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AboutUsController>(
      builder: (aboutUsController) {
        return Column(spacing: Dimensions.paddingSizeSmall, children: [
            CustomTextField(
              title: "title".tr,
              hintText: "title".tr,
              controller: titleController,
              maxLength: 100,
            ),

            CustomTextField(
              maxLines: 7,
              minLines: 5,
              inputType: TextInputType.multiline,
              title: "description".tr,
              hintText: "description".tr,
              controller: descriptionController,
              inputAction: TextInputAction.newline,
              maxLength: 500,
            ),

            const AboutUsImageWidget(),
            const SizedBox(height: Dimensions.paddingSizeLarge),
            CustomButton(
              onTap: () {
                String title = titleController.text.trim();
                String description = descriptionController.text.trim();
                AboutUsBody body = AboutUsBody(
                  title: title,
                  description: description,
                  method: 'PUT',

                );
                aboutUsController.editAboutUs(body, 1);

              },
              text: "update".tr,
            ),
          ],
        );
      },
    );
  }
}