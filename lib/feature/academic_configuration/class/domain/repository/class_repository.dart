import 'package:get/get_connect/http/src/response/response.dart';
import 'package:mighty_school/api_handle/api_client.dart';
import 'package:mighty_school/util/app_constants.dart';

class ClassRepository{
  final ApiClient apiClient;
  ClassRepository({required this.apiClient});

  Future<Response?> getClassList({int perPage = 100, int page =1}) async {
    return await apiClient.getData("${AppConstants.classApi}?per_page=$perPage&page=$page");
  }


  Future<Response?> addNewClassList(String name) async {
    return await apiClient.postData(AppConstants.classApi, {"class_name": name});
  }

  Future<Response?> classDetails(int id) async {
    return await apiClient.getData("${AppConstants.classApi}/$id");
  }

  Future<Response?> classEdit(String name, int id) async {
    return await apiClient.postData("${AppConstants.classApi}/$id", {"_method" :"PUT", "class_name": name});
  }

  Future<Response?> classDelete(int id) async {
    return await apiClient.deleteData("${AppConstants.classApi}/$id");
  }
}