import 'package:get/get.dart';
import 'package:mighty_school/api_handle/api_checker.dart';
import 'package:mighty_school/common/widget/custom_snackbar.dart';
import 'package:mighty_school/feature/quiz/quiz_topic/domain/models/quiz_topic_body.dart';
import 'package:mighty_school/feature/quiz/quiz_topic/domain/models/quiz_topic_model.dart';
import 'package:mighty_school/feature/quiz/quiz_topic/domain/repository/quiz_topic_repository.dart';

class QuizTopicController extends GetxController implements GetxService{
  final QuizTopicRepository quizTopicRepository;
  QuizTopicController({required this.quizTopicRepository});




  bool isLoading = false;
  QuizTopicModel? quizTopicModel;
  Future<void> getQuizList(int offset) async {
    Response? response = await quizTopicRepository.getQuizTopicList(offset);
    if (response?.statusCode == 200) {
      if(offset == 1){
        quizTopicModel = QuizTopicModel.fromJson(response?.body);
      }else{
        quizTopicModel?.data?.data?.addAll(QuizTopicModel.fromJson(response?.body).data!.data!);
        quizTopicModel?.data?.currentPage = QuizTopicModel.fromJson(response?.body).data?.currentPage;
        quizTopicModel?.data?.total = QuizTopicModel.fromJson(response?.body).data?.total;
      }
      isLoading = false;
    }else{
      isLoading = false;
      ApiChecker.checkApi(response!);
    }
    update();
  }

  Future<void> createNewQuizTopic(QuizTopicBody quizTopicBody) async {
    isLoading = true;
    update();
    Response? response = await quizTopicRepository.createQuizTopic(quizTopicBody);
    if(response!.statusCode == 200){
      isLoading = false;
      Get.back();
      showCustomSnackBar("added_successfully".tr, isError: false);
      getQuizList(1);

    }else{
      ApiChecker.checkApi(response);
    }
    isLoading = false;
    update();

  }

  Future<void> updateQuizTopic(QuizTopicBody quizTopicBody, int id) async {
    isLoading = true;
    update();
    Response? response = await quizTopicRepository.updateQuizTopic(quizTopicBody, id);
    if(response!.statusCode == 200){
      isLoading = false;
      Get.back();
      showCustomSnackBar("updated_successfully".tr, isError: false);
      getQuizList(1);
    }else{
      ApiChecker.checkApi(response);
    }
    isLoading = false;
    update();

  }


  Future<void> deleteQuizTopic(int id) async {
    isLoading = true;
    Response? response = await quizTopicRepository.deleteQuizTopic(id);
    if (response?.statusCode == 200) {
      showCustomSnackBar("deleted_successfully".tr, isError: false);
      getQuizList(1);
      isLoading = false;
    }else{
      isLoading = false;
      ApiChecker.checkApi(response!);
    }
    update();
  }

  QuizTopicItem? selectedQuizTopic;
  void selectQuizTopic(QuizTopicItem item){
    selectedQuizTopic = item;
    update();
  }

  bool quizPrice = false;
  bool enableShowAnswer = false;
  void quizPriceChanged(bool value) {
    quizPrice = value;
    update();
  }
  void changedShowAnswer(bool value) {
    enableShowAnswer = value;
    update();
  }
  
}