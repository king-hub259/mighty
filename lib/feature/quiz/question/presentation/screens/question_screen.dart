
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/common/widget/custom_floating_button.dart';
import 'package:mighty_school/feature/quiz/question/presentation/widgets/question_list_widget.dart';
import 'package:mighty_school/feature/quiz/quiz_topic/presentation/screens/create_new_quiz_topic_screen.dart';

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({super.key});

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: CustomAppBar(title: "question".tr),
        body: CustomWebScrollView(controller: scrollController, slivers: [
          SliverToBoxAdapter(child: QuestionListWidget(scrollController: scrollController))
        ],),


        floatingActionButton: CustomFloatingButton(title: "add", onTap: ()=> Get.to(()=> const CreateNewQuizTopicScreen())));
  }
}



