import 'package:get/get_connect/http/src/response/response.dart';
import 'package:mighty_school/api_handle/api_client.dart';
import 'package:mighty_school/feature/academic_configuration/subject/domain/model/subject_body.dart';
import 'package:mighty_school/util/app_constants.dart';

class SubjectRepository{
  final ApiClient apiClient;
  SubjectRepository({required this.apiClient});

  Future<Response?> getClassWiseSubjectList(int classId) async {
    return await apiClient.getData("${AppConstants.getSubjectList}/$classId");
  }
  Future<Response?> getSubjectList(int page) async {
    return await apiClient.getData("${AppConstants.subjects}?page=$page&per_page=20");
  }

  Future<Response?> addNewSubject(SubjectBody subjectBody) async {
    return await apiClient.postData(AppConstants.subjects, subjectBody.toJson());
  }

  Future<Response?> updateSubject(SubjectBody subjectBody, int id) async {
    return await apiClient.postData("${AppConstants.subjects}/$id", subjectBody.toJson());
  }

  Future<Response?> deleteSubject(int classId) async {
    return await apiClient.deleteData("${AppConstants.subjects}/$classId");
  }
}