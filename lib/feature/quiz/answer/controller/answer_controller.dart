import 'package:get/get.dart';
import 'package:mighty_school/api_handle/api_checker.dart';
import 'package:mighty_school/common/widget/custom_snackbar.dart';
import 'package:mighty_school/feature/quiz/answer/domain/models/answer_model.dart';
import 'package:mighty_school/feature/quiz/answer/domain/repository/answer_repository.dart';


class AnswerController extends GetxController implements GetxService{
  final AnswerRepository answerRepository;
  AnswerController({required this.answerRepository});



  int selectedTopicId = 0;
  void setSelectedTopic(int id){
    selectedTopicId = id;
    update();
  }

  bool isLoading = false;
  AnswerModel? answerModel;
  Future<void> getAnswerList() async {
    Response? response = await answerRepository.getAnswerList();
    if (response?.statusCode == 200) {
      answerModel = AnswerModel.fromJson(response?.body);
      isLoading = false;
    }else{
      isLoading = false;
      ApiChecker.checkApi(response!);
    }
    update();
  }


  Future<void> deleteAnswer(int id) async {
    isLoading = true;
    Response? response = await answerRepository.deleteAnswer(id);
    if (response?.statusCode == 200) {
      showCustomSnackBar("deleted_successfully".tr, isError: false);
      getAnswerList();
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