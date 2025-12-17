import 'package:get/get.dart';
import 'package:mighty_school/api_handle/api_checker.dart';
import 'package:mighty_school/feature/parent_module/parent_exam/domain/model/parent_exam_model.dart';
import 'package:mighty_school/feature/parent_module/parent_exam/domain/model/parent_exam_result_model.dart';
import 'package:mighty_school/feature/parent_module/parent_exam/domain/repository/parent_exam_repository.dart';


class ParentExamController extends GetxController implements GetxService{
  final ParentExamRepository examRepository;
  ParentExamController({required this.examRepository});


  ParentExamModel? examModel;
  Future<void> getExamList() async {
    Response? response = await examRepository.examList();
    if(response?.statusCode == 200){
      examModel = ParentExamModel.fromJson(response?.body);
    }else{
      ApiChecker.checkApi(response!);
    }
    update();

  }

  ParentExamResultModel? examResultModel;
  Future<void> getExamResults(int examId) async {
    Response? response = await examRepository.getExamResults(examId);
    if(response!.statusCode == 200){
      examResultModel = ParentExamResultModel.fromJson(response.body);
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }



}