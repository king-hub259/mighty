import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_button.dart';
import 'package:mighty_school/common/widget/custom_dropdown.dart';
import 'package:mighty_school/common/widget/custom_pick_image_widget.dart';
import 'package:mighty_school/common/widget/custom_snackbar.dart';
import 'package:mighty_school/common/widget/custom_text_field.dart';
import 'package:mighty_school/common/widget/custom_title.dart';
import 'package:mighty_school/feature/quiz/question/controller/question_controller.dart';
import 'package:mighty_school/feature/quiz/question/domain/models/question_body.dart';
import 'package:mighty_school/feature/quiz/question/domain/models/question_model.dart';
import 'package:mighty_school/helper/responsive_helper.dart';
import 'package:mighty_school/util/dimensions.dart';

class CreateNewQuestionWidget extends StatefulWidget {
  final Questions? questionItem;
  const CreateNewQuestionWidget({super.key, this.questionItem});

  @override
  State<CreateNewQuestionWidget> createState() => _CreateNewQuestionWidgetState();
}

class _CreateNewQuestionWidgetState extends State<CreateNewQuestionWidget> {
  TextEditingController questionTextController = TextEditingController();
  TextEditingController correctAnsController = TextEditingController();
  TextEditingController optionAController = TextEditingController();
  TextEditingController optionBController = TextEditingController();
  TextEditingController optionCController = TextEditingController();
  TextEditingController optionDController = TextEditingController();
  TextEditingController codeSnippetController = TextEditingController();
  TextEditingController answerExplainController = TextEditingController();
  TextEditingController videoLinkController = TextEditingController();

  bool update = false;
  @override
  void initState() {
    if(widget.questionItem != null){
      update = true;
      questionTextController.text = widget.questionItem?.question??'';
      correctAnsController.text = widget.questionItem?.answer??'';
      optionAController.text = widget.questionItem?.a??'';
      optionBController.text = widget.questionItem?.b??'';
      optionCController.text = widget.questionItem?.c??'';
      optionDController.text = widget.questionItem?.d??'';
      codeSnippetController.text = widget.questionItem?.codeSnippet??'';
      answerExplainController.text = widget.questionItem?.answerExp??'';

    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
      child: Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall)),
        child: SizedBox(width: ResponsiveHelper.isDesktop(context)? 900 : Get.width,
          child: Padding(
            padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
            child: GetBuilder<QuestionController>(
                builder: (questionController) {
                  return Column(mainAxisSize: MainAxisSize.min, children: [


                    Row(crossAxisAlignment: CrossAxisAlignment.start,children: [
                        Expanded(
                          child: Column(children: [
                              CustomTextField(title: "question".tr,
                                controller: questionTextController,
                                minLines: 7,
                                maxLines: 7,
                                inputAction: TextInputAction.newline,
                                inputType: TextInputType.multiline,
                                hintText: "question".tr,),

                              const CustomTitle(title: "correct_answer", isRequired: true,),
                              Padding(padding: const EdgeInsets.symmetric(vertical: 8.0),
                                child: CustomDropdown(width: Get.width, title: "select".tr,
                                  items: questionController.answerList,
                                  selectedValue: questionController.selectedAnswer,
                                  onChanged: (val){
                                    questionController.setSelectedAnswer(val!);
                                  },
                                ),),
                            ],
                          ),
                        ),
                      const SizedBox(width: Dimensions.paddingSizeSmall),

                      Expanded(
                        child: Column(children: [
                            CustomTextField(title: "option_a".tr,
                              controller: optionAController,
                              hintText: "option_a".tr,),
                            CustomTextField(title: "option_b".tr,
                              controller: optionBController,
                              hintText: "option_b".tr,),
                            CustomTextField(title: "option_c".tr,
                              controller: optionCController,
                              hintText: "option_c".tr,),
                            CustomTextField(title: "option_d".tr,
                              controller: optionDController,
                              hintText: "option_d".tr,),
                          ],
                        ),
                      ),
                      const SizedBox(width: Dimensions.paddingSizeSmall),

                      Expanded(
                        child: Column(children: [
                            CustomTextField(title: "code_snippet".tr,
                              controller: codeSnippetController,
                              minLines: 4,
                              maxLines: 5,
                              hintText: "code_snippet".tr,),
                            CustomTextField(title: "answer_explain".tr,
                              controller: answerExplainController,
                              minLines: 4,
                              maxLines: 5,
                              hintText: "answer_explain".tr,),

                        ],),
                      )
                      ]),
                    Row(children: [
                        Expanded(
                          child: Column(children: [
                              CustomTextField(title: "video_link".tr,
                                controller: videoLinkController,
                                hintText: "video_link".tr,),
                            ],
                          ),
                        ),
                      const SizedBox(width: Dimensions.paddingSizeSmall),

                      const Expanded(child: CustomPickImageWidget())

                    ]),





                    questionController.isLoading? const Padding(padding: EdgeInsets.all(Dimensions.paddingSizeDefault),
                        child: Center(child: CircularProgressIndicator())):

                    Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
                        child: CustomButton(onTap: (){
                          String question = questionTextController.text.trim();
                          String a = optionAController.text.trim();
                          String b = optionBController.text.trim();
                          String c = optionCController.text.trim();
                          String d = optionDController.text.trim();
                          String answer = questionController.selectedAnswer;
                          String codeSnippet = codeSnippetController.text.trim();
                          String answerExp = answerExplainController.text.trim();
                          String videoLink = videoLinkController.text.trim();
                          if(question.isEmpty){
                            showCustomSnackBar("question_is_empty".tr);
                          }else if(a.isEmpty){
                            showCustomSnackBar("option_a_is_empty".tr);
                          }
                          else if(b.isEmpty){
                            showCustomSnackBar("option_b_is_empty".tr);
                          }
                          else if(c.isEmpty){
                            showCustomSnackBar("option_c_is_empty".tr);
                          }
                          else if(d.isEmpty){
                            showCustomSnackBar("option_d_is_empty".tr);
                          }
                          else if(answer.isEmpty){
                            showCustomSnackBar("answer_is_empty".tr);
                          }

                          else{
                            QuestionBody body = QuestionBody(
                              question: question,
                              a: a,
                              b: b,
                              c: c,
                              d: d,
                              answer: answer,
                              codeSnippet: codeSnippet,
                              answerExp: answerExp,
                                questionVideoLink: videoLink

                            );
                            if(update){
                              questionController.updateQuestion(body, widget.questionItem!.id!);
                            }else{
                              questionController.createNewQuestion(body);
                            }

                          }
                        }, text:  "confirm".tr))
                  ],);
                }
            ),
          ),
        ),
      ),
    );
  }
}
