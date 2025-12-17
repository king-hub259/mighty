import 'package:get/get.dart';
import 'package:mighty_school/api_handle/api_checker.dart';
import 'package:mighty_school/feature/exam_management/exam_startup/domain/model/exam_short_code_model.dart';
import 'package:mighty_school/feature/exam_management/mark_config/domain/repository/mark_config_repository.dart';

class MarkConfigController extends GetxController implements GetxService{
  final MarkConfigRepository markConfigRepository;
  MarkConfigController({required this.markConfigRepository});

  ExamShortCodeModel? examShortCodeModel;
  Future<void> getGeneralExamList(int classId, int groupId) async {
    Response? response = await markConfigRepository.getGeneralExamList(classId, groupId);
    if(response?.statusCode == 200){
      examShortCodeModel = ExamShortCodeModel.fromJson(response?.body);
    }else{
      ApiChecker.checkApi(response!);
    }
    update();

  }


  int markConfigTypeIndex = 0;
  void setMarkConfigTypeIndex(int typeIndex){
    markConfigTypeIndex = typeIndex;
    update();
  }



}