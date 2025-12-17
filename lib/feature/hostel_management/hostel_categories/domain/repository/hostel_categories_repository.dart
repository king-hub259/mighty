import 'package:get/get_connect/http/src/response/response.dart';
import 'package:mighty_school/api_handle/api_client.dart';
import 'package:mighty_school/feature/hostel_management/hostel_categories/domain/model/hostel_category_body.dart';
import 'package:mighty_school/util/app_constants.dart';

class HostelCategoriesRepository {
  final ApiClient apiClient;

  HostelCategoriesRepository({required this.apiClient});

  Future<Response?> getHostelCategoriesList(int page) async {
    return await apiClient.getData("${AppConstants.hostelCategory}?per_page=20&page=$page");
  }

  Future<Response?> addNewHostelCategory(HostelCategoryBody categoryBody) async {
    return await apiClient.postData(AppConstants.hostelCategory, categoryBody.toJson());
  }

  Future<Response?> updateHostelCategory(int id, HostelCategoryBody categoryBody) async {
    return await apiClient.putData("${AppConstants.hostelCategory}/$id", categoryBody.toJson());
  }

  Future<Response?> deleteHostelCategory(int id) async {
    return await apiClient.deleteData("${AppConstants.hostelCategory}/$id");
  }

  Future<Response?> getHostelCategoryDetails(int id) async {
    return await apiClient.getData("${AppConstants.hostelCategory}/$id");
  }
}
  