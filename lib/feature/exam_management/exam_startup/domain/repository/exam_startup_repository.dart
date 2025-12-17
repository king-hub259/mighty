import 'package:get/get_connect/http/src/response/response.dart';
import 'package:mighty_school/api_handle/api_client.dart';
import 'package:mighty_school/feature/exam_management/exam_startup/domain/model/exam_assign_store_body.dart';
import 'package:mighty_school/feature/exam_management/exam_startup/domain/model/exam_code_store_body.dart';
import 'package:mighty_school/feature/exam_management/exam_startup/domain/model/exam_grade_store_body.dart';
import 'package:mighty_school/util/app_constants.dart';

class ExamStartupRepository{
  final ApiClient apiClient;
  ExamStartupRepository({required this.apiClient});

  Future<Response?> getExamShortCodeList(int page) async {
    return await apiClient.getData("${AppConstants.examShortCode}?per_page=50&page=$page");
  }


  Future<Response?> getExamGradeList(int page) async {
    return await apiClient.getData("${AppConstants.examGrades}?per_page=50&page=$page");
  }

  Future<Response?> getExamList(int page) async {
    return await apiClient.getData("${AppConstants.exam}?per_page=50&page=$page");
  }


  Future<Response?> getMeritProcessTypeList(int page) async {
    return await apiClient.getData("${AppConstants.meritProcessType}?per_page=50&page=$page");
  }

  Future<Response?> examCodeStore(ExamCodeStoreBody body) async {
    return await apiClient.postData(AppConstants.examCodeStore,body.toJson());
  }
  Future<Response?> examGradeStore(ExamGradeStoreBody body) async {
    return await apiClient.postData(AppConstants.examGradeStore,body.toJson());
  }
  Future<Response?> examAssignStore(ExamAssignStoreBody body) async {
    return await apiClient.postData(AppConstants.examAssignStore,body.toJson());
  }


}