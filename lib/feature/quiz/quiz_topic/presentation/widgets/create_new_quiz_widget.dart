import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_button.dart';
import 'package:mighty_school/common/widget/custom_snackbar.dart';
import 'package:mighty_school/common/widget/custom_text_field.dart';
import 'package:mighty_school/feature/quiz/quiz_topic/controller/quiz_topic_controller.dart';
import 'package:mighty_school/feature/quiz/quiz_topic/domain/models/quiz_topic_body.dart';
import 'package:mighty_school/feature/quiz/quiz_topic/domain/models/quiz_topic_model.dart';
import 'package:mighty_school/helper/responsive_helper.dart';
import 'package:mighty_school/util/dimensions.dart';

class CreateNewQuizTopicWidget extends StatefulWidget {
  final QuizTopicItem? quizTopicItem;
  const CreateNewQuizTopicWidget({super.key, this.quizTopicItem});

  @override
  State<CreateNewQuizTopicWidget> createState() => _CreateNewQuizTopicWidgetState();
}

class _CreateNewQuizTopicWidgetState extends State<CreateNewQuizTopicWidget> {
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController perQuestionMarkController = TextEditingController();
  TextEditingController timerController = TextEditingController();
  bool update = false;
  @override
  void initState() {
    if(widget.quizTopicItem != null){
      update = true;
      nameController.text = widget.quizTopicItem?.title??'';
      descriptionController.text = widget.quizTopicItem?.description??'';
      perQuestionMarkController.text = widget.quizTopicItem?.perQMark??'';
      timerController.text = widget.quizTopicItem?.timer??'';
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
      child: Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall)),
        child: SizedBox(width: ResponsiveHelper.isDesktop(context)? 500 : Get.width,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GetBuilder<QuizTopicController>(
                builder: (quizTopicController) {
                  return Column(mainAxisSize: MainAxisSize.min, children: [


                    CustomTextField(title: "name".tr,
                      controller: nameController,
                      hintText: "enter_name".tr,),

                    CustomTextField(title: "description".tr,
                      controller: descriptionController,
                      hintText: "description".tr,),

                    Row(children: [
                      Expanded(child: CustomTextField(title: "per_question_mark".tr,
                        controller: perQuestionMarkController,
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        hintText: "per_question_mark".tr,)),

                      const SizedBox(width: Dimensions.paddingSizeDefault),
                      Expanded(child: CustomTextField(title: "timer".tr,
                        controller: timerController,
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        hintText: "timer".tr,)),
                    ]),

                    const SizedBox(height: Dimensions.paddingSizeSmall),
                    Row(children: [
                        Expanded(
                          child: Row(children: [
                              Switch(value: quizTopicController.quizPrice, onChanged: (val){
                                quizTopicController.quizPriceChanged(val);
                              }),
                              Text("quiz_price".tr),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(children: [
                              Switch(value: quizTopicController.enableShowAnswer, onChanged: (val){
                                quizTopicController.changedShowAnswer(val);
                              }),
                              Text("enable_show_answer".tr),
                            ],
                          ),
                        ),
                      ],
                    ),


                    quizTopicController.isLoading? const Padding(padding: EdgeInsets.all(Dimensions.paddingSizeDefault),
                        child: Center(child: CircularProgressIndicator())):

                    Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
                        child: CustomButton(onTap: (){
                          String name = nameController.text.trim();
                          String description = descriptionController.text.trim();
                          String perQMark = perQuestionMarkController.text.trim();
                          String timer = timerController.text.trim();
                          String quizPrice = quizTopicController.quizPrice? "on" : "off";
                          String showAnswer = quizTopicController.enableShowAnswer? "on" : "off";

                          if(name.isEmpty){
                            showCustomSnackBar("name_is_empty".tr);
                          }else if(description.isEmpty){
                            showCustomSnackBar("description_is_empty".tr);
                          }
                          else if(perQMark.isEmpty){
                            showCustomSnackBar("per_question_mark_is_empty".tr);
                          }
                          else if(timer.isEmpty){
                            showCustomSnackBar("timer_is_empty".tr);
                          }
                          else{
                            QuizTopicBody body = QuizTopicBody(title: name,
                                description: description,
                                perQMark: perQMark,
                                timer: timer,
                                amount: quizPrice,
                                showAns: showAnswer,
                                method: update? "PUT" : "POST"
                            );
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
          ),
        ),
      ),
    );
  }
}
