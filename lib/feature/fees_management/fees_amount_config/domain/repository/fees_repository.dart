import 'package:get/get_connect/http/src/response/response.dart';
import 'package:mighty_school/api_handle/api_client.dart';
import 'package:mighty_school/feature/fees_management/fees_amount_config/domain/model/fees_body.dart';
import 'package:mighty_school/util/app_constants.dart';

class FeesRepository{
  final ApiClient apiClient;
  FeesRepository({required this.apiClient});

  Future<Response?> getFeesList(int page) async {
    return await apiClient.getData("${AppConstants.fees}?per_page=20&page=$page");
  }

  Future<Response?> addNewFees(FeesBody feesBody) async {
    return await apiClient.postData(AppConstants.fees, feesBody.toJson());
  }

  Future<Response?> updateFees(FeesBody feesBody, int id) async {
    return await apiClient.postData("${AppConstants.fees}/$id", {
      ...feesBody.toJson(),
      "_method": "PUT"
    });
  }

  Future<Response?> deleteFees(int id) async {
    return await apiClient.deleteData("${AppConstants.fees}/$id");
  }

}