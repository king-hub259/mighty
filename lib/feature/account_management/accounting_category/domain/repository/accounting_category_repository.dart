import 'package:get/get_connect/http/src/response/response.dart';
import 'package:mighty_school/api_handle/api_client.dart';
import 'package:mighty_school/util/app_constants.dart';

class AccountingCategoryRepository{
  final ApiClient apiClient;
  AccountingCategoryRepository({required this.apiClient});


  Future<Response?> getAccountingCategoryList(int page) async {
    return await apiClient.getData("${AppConstants.accountingCategory}?page=$page&perPage=10");
  }

  Future<Response?> createNewAccountingCategory( String name, String type) async {
    Map<String, String> fields = <String, String> {
      'name': name,
      'type': type,
    };

    return await apiClient.postData(AppConstants.accountingCategory, fields);
  }

  Future<Response?> updateAccountingCategory( String name, String type, int id) async {
    Map<String, String> fields = <String, String> {
      'name': name,
      'type': type,
    };
    return await apiClient.putData("${AppConstants.accountingCategory}/$id", fields);
  }
  

  Future<Response?> deleteAccountingCategory (int id) async {
    return await apiClient.deleteData("${AppConstants.accountingCategory}/$id");
  }
}