import 'package:get/get_connect/http/src/response/response.dart';
import 'package:mighty_school/api_handle/api_client.dart';
import 'package:mighty_school/feature/transportation_management/transport_driver/domain/model/transport_driver_body.dart';
import 'package:mighty_school/util/app_constants.dart';

class TransportDriverRepository {
  final ApiClient apiClient;

  TransportDriverRepository({required this.apiClient});

  Future<Response?> getTransportDriverList(int page) async {
    return await apiClient.getData("${AppConstants.transportDriver}?per_page=20&page=$page");
  }

  Future<Response?> createTransportDriver(TransportDriverBody transportDriverBody) async {
    return await apiClient.postData(AppConstants.transportDriver, transportDriverBody.toJson());
  }

  Future<Response?> getTransportDriverDetails(int id) async {
    return await apiClient.getData("${AppConstants.transportDriver}/$id");
  }

  Future<Response?> updateTransportDriver(TransportDriverBody transportDriverBody, int id) async {
    return await apiClient.postData("${AppConstants.transportDriver}/$id", {
      ...transportDriverBody.toJson(),
      "_method": "PUT"
    });
  }

  Future<Response?> deleteTransportDriver(int id) async {
    return await apiClient.deleteData("${AppConstants.transportDriver}/$id");
  }
}
  