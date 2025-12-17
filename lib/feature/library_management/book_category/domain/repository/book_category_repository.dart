import 'package:get/get_connect/http/src/response/response.dart';
import 'package:mighty_school/api_handle/api_client.dart';
import 'package:mighty_school/util/app_constants.dart';

class BookCategoryRepository{
  final ApiClient apiClient;
  BookCategoryRepository({required this.apiClient});

  Future<Response?> getBookCategoriesList({int perPage = 10, int page =1}) async {
    return await apiClient.getData("${AppConstants.bookCategories}?per_page=$perPage&page=$page");
  }


  Future<Response?> addNewBookCategory(String name) async {
    return await apiClient.postData(AppConstants.bookCategories, {"category_name": name});
  }

  Future<Response?> bookCategoriesDetails(int id) async {
    return await apiClient.getData("${AppConstants.bookCategories}/$id");
  }

  Future<Response?> bookCategoriesEdit(String name, int id) async {
    return await apiClient.postData("${AppConstants.bookCategories}/$id", {"_method" :"PUT", "category_name": name});
  }

  Future<Response?> bookCategoriesDelete(int id) async {
    return await apiClient.deleteData("${AppConstants.bookCategories}/$id");
  }
}