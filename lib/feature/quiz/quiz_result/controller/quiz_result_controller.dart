import 'package:get/get.dart';
import 'package:mighty_school/api_handle/api_checker.dart';
import 'package:mighty_school/feature/quiz/quiz_result/domain/models/quiz_result_model.dart';
import 'package:mighty_school/feature/quiz/quiz_result/domain/repository/quiz_result_repository.dart';


class QuizResultController extends GetxController implements GetxService{
  final QuizResultRepository quizResultRepository;
  QuizResultController({required this.quizResultRepository});



  int selectedTopicId = 0;
  void setSelectedTopic(int id){
    selectedTopicId = id;
    update();
  }

  bool isLoading = false;
  QuizResultModel? quizResultModel;
  Future<void> getQuizResultList() async {
    Response? response = await quizResultRepository.getQuizResultList();
    if (response?.statusCode == 200) {
      quizResultModel = QuizResultModel.fromJson(response?.body);
      isLoading = false;
    }else{
      isLoading = false;
      ApiChecker.checkApi(response!);
    }
    update();
  }


  Future<void> getQuizReport(int id) async {
    Response? response = await quizResultRepository.getQuizReport(id);
    if (response?.statusCode == 200) {

    }else{
      ApiChecker.checkApi(response!);
    }
    update();
  }


}