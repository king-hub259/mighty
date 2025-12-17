
import 'package:get/get.dart';
import 'package:mighty_school/api_handle/api_checker.dart';
import 'package:mighty_school/feature/exam_management/mark_input/domain/models/mark_input_model.dart';
import 'package:mighty_school/feature/exam_management/mark_input/domain/repository/mark_input_repository.dart';

class MarkInputController extends GetxController implements GetxService{
  final MarkInputRepository markInputRepository;
  MarkInputController({required this.markInputRepository});

  bool isLoading = false;
  MarkInputModel? markInputModel;
  Future<void> markInputGet(int classId, int examId, int groupId, int subjectId) async {
    isLoading = true;
    update();
    Response? response = await markInputRepository.getMarkInput(classId, examId, groupId, subjectId);
    if(response?.statusCode == 200){
      isLoading = false;
      markInputModel = MarkInputModel.fromJson(response?.body);
    }else{
      isLoading = false;
      ApiChecker.checkApi(response!);
    }
    update();
  }
}