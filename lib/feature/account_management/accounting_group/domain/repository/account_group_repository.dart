import 'package:get/get_connect/http/src/response/response.dart';
import 'package:mighty_school/api_handle/api_client.dart';
import 'package:mighty_school/util/app_constants.dart';

class AccountGroupRepository{
  final ApiClient apiClient;
  AccountGroupRepository({required this.apiClient});


  Future<Response?> getAccountingGroupList(int page, {required String search}) async {
    return await apiClient.getData("${AppConstants.accountingGroups}?page=$page&perPage=10&search=$search");
  }

  Future<Response?> createNewAccountingGroup(String name, int catId) async {
    return await apiClient.postData(AppConstants.accountingGroups,
        {"name":name, "accounting_category_id" : catId});
  }

  Future<Response?> updateAccountingGroup(String name,int catId, int id) async {
    return await apiClient.putData("${AppConstants.accountingFund}/$id",
        {"name":name, "accounting_category_id" : catId});
  }



  Future<Response?> deleteAccountingGroup (int id) async {
    return await apiClient.deleteData("${AppConstants.accountingFund}/$id");
  }
}