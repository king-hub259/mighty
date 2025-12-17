import 'package:get/get.dart';
import 'package:mighty_school/api_handle/api_checker.dart';
import 'package:mighty_school/common/widget/custom_snackbar.dart';
import 'package:mighty_school/feature/quiz/question/domain/models/question_body.dart';
import 'package:mighty_school/feature/quiz/question/domain/models/question_model.dart';
import 'package:mighty_school/feature/quiz/question/domain/repository/question_repository.dart';

class QuestionController extends GetxController implements GetxService{
  final QuestionRepository questionRepository;
  QuestionController({required this.questionRepository});



  int selectedTopicId = 0;
  void setSelectedTopic(int id){
    selectedTopicId = id;
    update();
  }

  bool isLoading = false;
  QuestionModel? questionModel;
  Future<void> getQuestionList() async {
    Response? response = await questionRepository.getQuestionList(selectedTopicId);
    if (response?.statusCode == 200) {
      questionModel = QuestionModel.fromJson(response?.body);
      isLoading = false;
    }else{
      isLoading = false;
      ApiChecker.checkApi(response!);
    }
    update();
  }

  Future<void> createNewQuestion(QuestionBody questionBody) async {
    isLoading = true;
    update();
    Response? response = await questionRepository.createQuestion(questionBody);
    if(response!.statusCode == 200){
      isLoading = false;
      Get.back();
      showCustomSnackBar("added_successfully".tr, isError: false);
      getQuestionList();

    }else{
      ApiChecker.checkApi(response);
    }
    isLoading = false;
    update();

  }

  Future<void> updateQuestion(QuestionBody questionBody, int id) async {
    isLoading = true;
    update();
    Response? response = await questionRepository.updateQuestion(questionBody, id);
    if(response!.statusCode == 200){
      isLoading = false;
      Get.back();
      showCustomSnackBar("updated_successfully".tr, isError: false);
      getQuestionList();
    }else{
      ApiChecker.checkApi(response);
    }
    isLoading = false;
    update();

  }


  Future<void> deleteQuestion(int id) async {
    isLoading = true;
    Response? response = await questionRepository.deleteQuestion(id);
    if (response?.statusCode == 200) {
      showCustomSnackBar("deleted_successfully".tr, isError: false);
      getQuestionList();
      isLoading = false;
    }else{
      isLoading = false;
      ApiChecker.checkApi(response!);
    }
    update();
  }

  List<String> answerList = ["A", "B", "C", "D"];
  String selectedAnswer = "A";
  void setSelectedAnswer(String val){
    selectedAnswer = val;
    update();
  }

}