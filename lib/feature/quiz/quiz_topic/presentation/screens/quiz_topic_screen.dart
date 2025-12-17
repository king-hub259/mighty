
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/common/widget/custom_floating_button.dart';
import 'package:mighty_school/feature/quiz/quiz_topic/presentation/screens/create_new_quiz_topic_screen.dart';
import 'package:mighty_school/feature/quiz/quiz_topic/presentation/widgets/quiz_topic_list_widget.dart';

class QuizTopicScreen extends StatefulWidget {
  const QuizTopicScreen({super.key});

  @override
  State<QuizTopicScreen> createState() => _QuizTopicScreenState();
}

class _QuizTopicScreenState extends State<QuizTopicScreen> {
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "quiz_topic".tr),
      body: CustomWebScrollView(controller: scrollController, slivers: [
        SliverToBoxAdapter(child: QuizTopicListWidget(scrollController: scrollController))
      ],),


      floatingActionButton: CustomFloatingButton(title: "add", onTap: ()=> Get.to(()=> const CreateNewQuizTopicScreen())));
  }
}



