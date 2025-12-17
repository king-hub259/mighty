import 'package:get/get_connect/http/src/response/response.dart';
import 'package:mighty_school/api_handle/api_client.dart';
import 'package:mighty_school/feature/fees_management/fees_date/domain/model/fees_date_body.dart';
import 'package:mighty_school/util/app_constants.dart';

class FeesDateRepository{
  final ApiClient apiClient;
  FeesDateRepository({required this.apiClient});

  Future<Response?> getFeesDateList(int page) async {
    return await apiClient.getData("${AppConstants.feesDate}?per_page=20&page=$page");
  }

  Future<Response?> addNewFeesDate(FeesDateBody feesDateBody) async {
    return await apiClient.postData(AppConstants.absentFine, feesDateBody.toJson());
  }

  Future<Response?> updateFeesDate(FeesDateBody feesDateBody, int id) async {
    return await apiClient.postData("${AppConstants.absentFine}/$id", feesDateBody.toJson());
  }

  Future<Response?> deleteFeesDate( int id) async {
    return await apiClient.deleteData("${AppConstants.absentFine}/$id");
  }


}