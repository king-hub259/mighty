import 'package:get/get_connect/http/src/response/response.dart';
import 'package:mighty_school/api_handle/api_client.dart';
import 'package:mighty_school/util/app_constants.dart';

class PeriodRepository{
  final ApiClient apiClient;
  PeriodRepository({required this.apiClient});

  Future<Response?> getPeriodList(int page) async {
    return await apiClient.getData("${AppConstants.periods}?per_page=10&page=$page");
  }

  Future<Response?> addNewPeriod(String period, String serial) async {
    return await apiClient.postData(AppConstants.periods, {
      "period": period,
      "serial_no": serial
    });
  }

  Future<Response?> periodDetails(int id) async {
    return await apiClient.getData("${AppConstants.periods}/$id");
  }

  Future<Response?> periodEdit(String period, String serial, int id) async {
    return await apiClient.postData("${AppConstants.periods}/$id",
        {
          "period": period,
          "serial_no": serial,
          "_method" : "PUT"
        });
  }

  Future<Response?> periodDelete(int id) async {
    return await apiClient.deleteData("${AppConstants.periods}/$id");
  }
}