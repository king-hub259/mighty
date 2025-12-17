import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_button.dart';
import 'package:mighty_school/common/widget/custom_text_field.dart';
import 'package:mighty_school/feature/cms_management/faq/domain/model/faq_model.dart';
import 'package:mighty_school/feature/cms_management/faq/logic/faq_controller.dart';
import 'package:mighty_school/util/dimensions.dart';

class CreateNewFaqWidget extends StatefulWidget {
  final FaqItem? faqItem;
  const CreateNewFaqWidget({super.key, this.faqItem});

  @override
  State<CreateNewFaqWidget> createState() => _CreateNewFaqWidgetState();
}

class _CreateNewFaqWidgetState extends State<CreateNewFaqWidget> {
  TextEditingController questionController = TextEditingController();
  TextEditingController answerController = TextEditingController();


  @override
  void initState() {
    if(widget.faqItem != null) {
      questionController.text = widget.faqItem?.question??'';
      answerController.text = widget.faqItem?.answer??'';

    }
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return GetBuilder<FaqController>(
      builder: (faqController) {
        return Column(mainAxisSize: MainAxisSize.min, children: [
          CustomTextField(title: "question".tr, hintText: "question".tr, controller: questionController, maxLength: 100),
          CustomTextField(title: "answer".tr, minLines: 3, maxLines: 5, inputType: TextInputType.multiline,
            inputAction: TextInputAction.newline,
              hintText: "answer".tr, controller: answerController, maxLength: 300),



          const SizedBox(height: Dimensions.paddingSizeLarge),
          faqController.loading? const Center(child: CircularProgressIndicator()) :
          CustomButton(
            onTap: () {
              String question = questionController.text.trim();
              String answer = answerController.text.trim();
              if(widget.faqItem != null){

                faqController.editFaq(question, answer, widget.faqItem!.id!);
              }else {
                faqController.createFaq(question, answer);
              }

            },
            text: widget.faqItem != null?"update".tr : "add".tr,
          ),
        ]);
      }
    );
  }
}