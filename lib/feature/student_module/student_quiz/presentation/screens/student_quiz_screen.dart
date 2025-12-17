
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/common/widget/no_data_found.dart';
import 'package:mighty_school/feature/student_module/student_quiz/controller/student_quiz_controller.dart';
import 'package:mighty_school/feature/student_module/student_quiz/presentation/widgets/student_quiz_item_widget.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';


class StudentQuizScreen extends StatefulWidget {
  const StudentQuizScreen({super.key});

  @override
  State<StudentQuizScreen> createState() => _StudentQuizScreenState();
}

class _StudentQuizScreenState extends State<StudentQuizScreen> {
  ScrollController scrollController = ScrollController();
  @override
  void initState() {
    Get.find<StudentQuizController>().getQuizList();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "quiz".tr),
      body: CustomScrollView(controller: scrollController, slivers: [
        SliverToBoxAdapter(child: GetBuilder<StudentQuizController>(builder: (quizController) {
              var quiz = quizController.quizModel?.data?.topics;
              return Column(children: [
                quizController.quizModel != null? (quizController.quizModel!.data!= null && quizController.quizModel!.data!.topics!.isNotEmpty)?
                ListView.builder(
                    itemCount: quiz?.length??0,
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index){
                      return StudentQuizItemWidget(index: index, topics: quiz?[index]);
                    }):
                Padding(padding: ThemeShadow.getPadding(), child: const Center(child: NoDataFound())):
                Padding(padding: ThemeShadow.getPadding(), child: const CircularProgressIndicator()),

                const SizedBox(height: Dimensions.paddingSizeDefault,),
              ],);
            }
        ),)
      ],),
    );
  }
}



