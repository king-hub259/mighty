import 'package:get/get_connect/http/src/response/response.dart';
import 'package:mighty_school/api_handle/api_client.dart';
import 'package:mighty_school/util/app_constants.dart';

class AccountLedgerRepository{
  final ApiClient apiClient;
  AccountLedgerRepository({required this.apiClient});


  Future<Response?> getAccountingLedgerList(int page, String type) async {
    return await apiClient.getData("${AppConstants.accountingLedger}?page=$page&per_page=30&type=$type");
  }

  Future<Response?> createNewAccountingLedger(String name, int catId, int groupId) async {
    return await apiClient.postData(AppConstants.accountingLedger,
        {"ledger_name":name, "accounting_category_id" : catId, "accounting_group_id" : groupId});
  }

  Future<Response?> updateAccountingLedger(String name,int catId, int groupId, int id) async {
    return await apiClient.putData("${AppConstants.accountingLedger}/$id",
        {"name":name, "accounting_category_id" : catId, "accounting_group_id" : groupId});
  }



  Future<Response?> deleteAccountingLedger (int id) async {
    return await apiClient.deleteData("${AppConstants.accountingLedger}/$id");
  }

  Future<Response?> getLedgerBalance (int id) async {
    return await apiClient.getData("${AppConstants.ledgerBalance}$id");
  }
}