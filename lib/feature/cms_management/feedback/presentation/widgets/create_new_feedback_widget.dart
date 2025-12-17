import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_button.dart';
import 'package:mighty_school/common/widget/custom_text_field.dart';
import 'package:mighty_school/feature/cms_management/feedback/domain/model/feedback_body.dart';
import 'package:mighty_school/feature/cms_management/feedback/domain/model/feedback_model.dart';
import 'package:mighty_school/feature/cms_management/feedback/logic/feedback_controller.dart';
import 'package:mighty_school/util/app_constants.dart';
import 'package:mighty_school/util/dimensions.dart';

class CreateNewFeedbackWidget extends StatefulWidget {
  final FeedbackItem? feedbackItem;
  const CreateNewFeedbackWidget({super.key, this.feedbackItem});

  @override
  State<CreateNewFeedbackWidget> createState() => _CreateNewFeedbackWidgetState();
}

class _CreateNewFeedbackWidgetState extends State<CreateNewFeedbackWidget> {
  TextEditingController nameController = TextEditingController();
  TextEditingController universityController = TextEditingController();
  TextEditingController rankController = TextEditingController();
  TextEditingController videoUrlController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();


  @override
  void initState() {
    if(widget.feedbackItem != null) {
      nameController.text = widget.feedbackItem?.name??'';
      universityController.text = widget.feedbackItem?.university??'';
      rankController.text = widget.feedbackItem?.rank?.toString()??'';
      videoUrlController.text = widget.feedbackItem?.videoUrl??'';
      descriptionController.text = widget.feedbackItem?.description??'';

    }
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return GetBuilder<FeedbackController>(
      builder: (feedbackController) {
        return Column(mainAxisSize: MainAxisSize.min, children: [
          CustomTextField(title: "name".tr, hintText: "name".tr, controller: nameController, maxLength: 100),
          CustomTextField(title: "university".tr, hintText: "university".tr, controller: universityController, maxLength: 200),
          CustomTextField(title: "rank".tr, hintText: "rank".tr, controller: rankController, maxLength: 200,
            isAmount: true, inputFormatters: [AppConstants.numberFormat],),
          CustomTextField(title: "video_url".tr,
              hintText: "video_url".tr, controller: videoUrlController, maxLength: 500),
          CustomTextField(title: "description".tr, minLines: 3, maxLines: 5, inputType: TextInputType.multiline,
            inputAction: TextInputAction.newline,
              hintText: "description".tr, controller: descriptionController, maxLength: 500),




          const SizedBox(height: Dimensions.paddingSizeLarge),
          feedbackController.loading? const Center(child: CircularProgressIndicator()) :
          CustomButton(
            onTap: () {
              String name = nameController.text.trim();
              String university = universityController.text.trim();
              String rank = rankController.text.trim();
              String videoUrl = videoUrlController.text.trim();
              String description = descriptionController.text.trim();


              FeedbackBody body = FeedbackBody(name: name, university: university, rank: rank, videoUrl: videoUrl, description: description, method: widget.feedbackItem != null? "PUT" :"POST",);
              if(widget.feedbackItem != null){

                feedbackController.editFeedback(body, widget.feedbackItem!.id!);
              }else {
                feedbackController.createFeedback(body);
              }

            },
            text: widget.feedbackItem != null?"update".tr : "add".tr,
          ),
        ]);
      }
    );
  }
}