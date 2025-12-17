import 'package:get/get_connect/http/src/response/response.dart';
import 'package:mighty_school/api_handle/api_client.dart';
import 'package:mighty_school/util/app_constants.dart';

class PhoneBookCategoryRepository{
  final ApiClient apiClient;
  PhoneBookCategoryRepository({required this.apiClient});


  Future<Response?> getPhoneBookCategoryList() async {
    return await apiClient.getData(AppConstants.phoneBookCategory);
  }

  Future<Response?> createPhoneBookCategory( String name, String description) async {
    Map<String, String> fields = <String, String> {
      'name': name,
      'description': description,
    };
    return await apiClient.postData(AppConstants.phoneBookCategory, fields);
  }

  Future<Response?> updatePhoneBookCategory( String name, String description, int id) async {
    Map<String, String> fields = <String, String> {
      'name': name,
      'description': description,
    };
    return await apiClient.putData("${AppConstants.phoneBookCategory}/$id", fields);
  }
  

  Future<Response?> deletePhoneBookCategory (int id) async {
    return await apiClient.deleteData("${AppConstants.phoneBookCategory}/$id");
  }
}