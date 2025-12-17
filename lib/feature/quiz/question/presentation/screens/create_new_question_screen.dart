import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_button.dart';
import 'package:mighty_school/common/widget/custom_snackbar.dart';
import 'package:mighty_school/common/widget/custom_text_field.dart';
import 'package:mighty_school/feature/quiz/quiz_topic/controller/quiz_topic_controller.dart';
import 'package:mighty_school/feature/quiz/quiz_topic/domain/models/quiz_topic_body.dart';
import 'package:mighty_school/feature/quiz/quiz_topic/domain/models/quiz_topic_model.dart';
import 'package:mighty_school/util/dimensions.dart';

class CreateNewQuizTopicScreen extends StatefulWidget {
  final QuizTopicItem? quizTopicItem;
  const CreateNewQuizTopicScreen({super.key, this.quizTopicItem});

  @override
  State<CreateNewQuizTopicScreen> createState() => _CreateNewQuizTopicScreenState();
}

class _CreateNewQuizTopicScreenState extends State<CreateNewQuizTopicScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
   bool update = false;
  @override
  void initState() {
    if(widget.quizTopicItem != null){
      update = true;
      nameController.text = widget.quizTopicItem?.title??'';
      descriptionController.text = widget.quizTopicItem?.description??'';
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
      child: GetBuilder<QuizTopicController>(
        builder: (quizTopicController) {
          return Column(mainAxisSize: MainAxisSize.min, children: [


            CustomTextField(title: "name".tr,
              controller: nameController,
              hintText: "enter_name".tr,),

            CustomTextField(title: "description".tr,
              controller: descriptionController,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              hintText: "description".tr,),


            quizTopicController.isLoading? const Padding(padding: EdgeInsets.all(Dimensions.paddingSizeDefault),
              child: Center(child: CircularProgressIndicator())):

            Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
              child: CustomButton(onTap: (){
                String name = nameController.text.trim();
                String description = descriptionController.text.trim();
                if(name.isEmpty){
                  showCustomSnackBar("name_is_empty");
                }else if(description.isEmpty){
                  showCustomSnackBar("priority_is_empty");
                }else{
                  QuizTopicBody body = QuizTopicBody(title: name, description: description);
                  if(update){
                    quizTopicController.updateQuizTopic(body, widget.quizTopicItem!.id!);
                  }else{
                    quizTopicController.createNewQuizTopic(body);
                  }

                }
              }, text: update? "update".tr : "save".tr))
          ],);
        }
      ),
    );
  }
}
