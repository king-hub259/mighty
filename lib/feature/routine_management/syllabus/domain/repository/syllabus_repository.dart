import 'package:get/get_connect/http/src/response/response.dart';
import 'package:mighty_school/api_handle/api_client.dart';
import 'package:mighty_school/util/app_constants.dart';

class SyllabusRepository{
  final ApiClient apiClient;
  SyllabusRepository({required this.apiClient});


  Future<Response?> getSyllabusList(int page) async {
    return await apiClient.getData("${AppConstants.syllabus}?page=$page&perPage=10");
  }

  Future<Response?> createNewSyllabus( String title, String description, String classId, List<MultipartDocument> file) async {
    Map<String, String> fields = <String, String> {
      'title': title,
      'description': description,
      'class_id' : classId
    };

    return await apiClient.postMultipartData(AppConstants.syllabus, fields,[], null, file );
  }

  Future<Response?> updateSyllabus( String title, String description, String classId,List<MultipartDocument> file, int id) async {
    Map<String, String> fields = <String, String> {
      'title': title,
      'description': description,
      'class_id' : classId
    };
    return await apiClient.postMultipartData("${AppConstants.syllabus}/$id", fields, [],null, file );
  }
  

  Future<Response?> deleteSyllabus (int id) async {
    return await apiClient.deleteData("${AppConstants.syllabus}/$id");
  }
}