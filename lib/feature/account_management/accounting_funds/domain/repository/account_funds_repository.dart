import 'package:get/get_connect/http/src/response/response.dart';
import 'package:mighty_school/api_handle/api_client.dart';
import 'package:mighty_school/util/app_constants.dart';

class AccountFundRepository{
  final ApiClient apiClient;
  AccountFundRepository({required this.apiClient});


  Future<Response?> getAccountingFundList(int page) async {
    return await apiClient.getData("${AppConstants.accountingFund}?page=$page&perPage=30");
  }

  Future<Response?> createNewAccountingFund(String name) async {
    return await apiClient.postData(AppConstants.accountingFund,{"name":name});
  }

  Future<Response?> updateAccountingFund(String name, int id) async {
    return await apiClient.putData("${AppConstants.accountingFund}/$id",{"name":name});
  }



  Future<Response?> deleteAccountingFund (int id) async {
    return await apiClient.deleteData("${AppConstants.accountingFund}/$id");
  }
}