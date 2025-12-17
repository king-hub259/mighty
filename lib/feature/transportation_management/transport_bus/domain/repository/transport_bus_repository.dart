import 'package:get/get_connect/http/src/response/response.dart';
import 'package:mighty_school/api_handle/api_client.dart';
import 'package:mighty_school/feature/transportation_management/transport_bus/domain/model/transport_bus_body.dart';
import 'package:mighty_school/util/app_constants.dart';

class TransportBusRepository {
  final ApiClient apiClient;

  TransportBusRepository({required this.apiClient});

  Future<Response?> getTransportBusList(int page) async {
    return await apiClient.getData("${AppConstants.transportBuses}?per_page=20&page=$page");
  }

  Future<Response?> createTransportBus(TransportBusBody transportBusBody) async {
    return await apiClient.postData(AppConstants.transportBuses, transportBusBody.toJson());
  }

  Future<Response?> getTransportBusDetails(int id) async {
    return await apiClient.getData("${AppConstants.transportBuses}/$id");
  }

  Future<Response?> updateTransportBus(TransportBusBody transportBusBody, int id) async {
    return await apiClient.postData("${AppConstants.transportBuses}/$id", {
      ...transportBusBody.toJson(),
      "_method": "PUT"
    });
  }

  Future<Response?> deleteTransportBus(int id) async {
    return await apiClient.deleteData("${AppConstants.transportBuses}/$id");
  }
}
  