import 'package:get/get_connect/http/src/response/response.dart';
import 'package:mighty_school/api_handle/api_client.dart';
import 'package:mighty_school/feature/exam_management/remark_config/domain/model/re_mark_config_body.dart';
import 'package:mighty_school/util/app_constants.dart';

class ReMarkConfigRepository{
  final ApiClient apiClient;
  ReMarkConfigRepository({required this.apiClient});

  Future<Response?> getRemarkConfigList(int page) async {
    return await apiClient.getData("${AppConstants.remarkConfig}?page=$page&per_page=30");
  }

  Future<Response?> addNewRemarkConfig(ReMarkConfigBody body) async {
    return await apiClient.postData(AppConstants.remarkConfig, body.toJson());
  }
  Future<Response?> updateRemarkConfig(ReMarkConfigBody body, int id) async {
    return await apiClient.postData("${AppConstants.remarkConfig}/$id", body.toJson());
  }
  Future<Response?> deleteRemarkConfig( int id) async {
    return await apiClient.deleteData("${AppConstants.remarkConfig}/$id");
  }



}