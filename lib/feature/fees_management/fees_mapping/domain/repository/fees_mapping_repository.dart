import 'package:get/get_connect/http/src/response/response.dart';
import 'package:mighty_school/api_handle/api_client.dart';
import 'package:mighty_school/feature/fees_management/fees_mapping/domain/model/fees_mapping_body.dart';
import 'package:mighty_school/util/app_constants.dart';

class FeesMappingRepository{
  final ApiClient apiClient;
  FeesMappingRepository({required this.apiClient});

  Future<Response?> getFeesMappingList(int page, String type) async {
    return await apiClient.getData("${AppConstants.feesMapping}?per_page=20&page=$page&type=$type");
  }

  Future<Response?> addNewFeesMapping(FeesMappingBody feesMappingBody) async {
    return await apiClient.postData(AppConstants.feesMapping, feesMappingBody.toJson());
  }

  Future<Response?> updateFeesMapping(FeesMappingBody feesMappingBody, int id) async {
    return await apiClient.postData("${AppConstants.feesMapping}/$id", {
      ...feesMappingBody.toJson(),
      "_method": "PUT"
    });
  }

  Future<Response?> deleteFeesMapping(int id) async {
    return await apiClient.deleteData("${AppConstants.feesMapping}/$id");
  }
}