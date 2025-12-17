import 'package:get/get_connect/http/src/response/response.dart';
import 'package:mighty_school/api_handle/api_client.dart';
import 'package:mighty_school/util/app_constants.dart';

class StudentCategoriesRepository{
  final ApiClient apiClient;
  StudentCategoriesRepository({required this.apiClient});

  Future<Response?> getStudentCategoriesList({int perPage = 10, int page =1}) async {
    return await apiClient.getData("${AppConstants.studentCategories}?per_page=$perPage&page=$page");
  }


  Future<Response?> addNewStudentCategories(String name) async {
    return await apiClient.postData(AppConstants.studentCategories, {"name": name});
  }

  Future<Response?> studentCategoriesDetails(int id) async {
    return await apiClient.getData("${AppConstants.studentCategories}/$id");
  }

  Future<Response?> studentCategoriesEdit(String name, int id) async {
    return await apiClient.postData("${AppConstants.studentCategories}/$id", {"_method" :"PUT", "name": name});
  }

  Future<Response?> studentCategoriesDelete(int id) async {
    return await apiClient.deleteData("${AppConstants.studentCategories}/$id");
  }
}