
import 'package:get/get.dart';
import 'package:mighty_school/api_handle/api_checker.dart';
import 'package:mighty_school/feature/student_module/student_quiz/domain/models/student_quiz_model.dart';
import 'package:mighty_school/feature/student_module/student_quiz/domain/repository/student_quiz_repository.dart';


class StudentQuizController extends GetxController implements GetxService{
  final StudentQuizRepository quizRepository;
  StudentQuizController({required this.quizRepository});

  bool isLoading = false;
  StudentQuizModel? quizModel;
  Future<void> getQuizList() async {
    Response? response = await quizRepository.getQuizList();
    if (response?.statusCode == 200) {
      quizModel = StudentQuizModel.fromJson(response?.body);
      isLoading = false;
    }else{
      isLoading = false;
      ApiChecker.checkApi(response!);
    }
    update();
  }

}