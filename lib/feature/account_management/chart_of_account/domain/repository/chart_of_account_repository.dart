import 'package:get/get_connect/http/src/response/response.dart';
import 'package:mighty_school/api_handle/api_client.dart';
import 'package:mighty_school/util/app_constants.dart';

class ChartOfAccountRepository{
  final ApiClient apiClient;
  ChartOfAccountRepository({required this.apiClient});


  Future<Response?> getChartOAccount(int page) async {
    return await apiClient.getData("${AppConstants.chartOfAccount}?per_page=50&page=$page");
  }

}