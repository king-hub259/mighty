import 'package:get/get_connect/http/src/response/response.dart';
import 'package:mighty_school/api_handle/api_client.dart';
import 'package:mighty_school/feature/transportation_management/transport_bus_stop/domain/model/transport_bus_stop_body.dart';
import 'package:mighty_school/util/app_constants.dart';

class TransportBusStopRepository {
  final ApiClient apiClient;

  TransportBusStopRepository({required this.apiClient});

  Future<Response?> getTransportBusStopList(int page) async {
    return await apiClient.getData("${AppConstants.transportBusStops}?per_page=20&page=$page");
  }

  Future<Response?> createTransportBusStop(TransportBusStopBody transportBusStopBody) async {
    return await apiClient.postData(AppConstants.transportBusStops, transportBusStopBody.toJson());
  }

  Future<Response?> getTransportBusStopDetails(int id) async {
    return await apiClient.getData("${AppConstants.transportBusStops}/$id");
  }

  Future<Response?> updateTransportBusStop(TransportBusStopBody transportBusStopBody, int id) async {
    return await apiClient.postData("${AppConstants.transportBusStops}/$id", {
      ...transportBusStopBody.toJson(),
      "_method": "PUT"
    });
  }

  Future<Response?> deleteTransportBusStop(int id) async {
    return await apiClient.deleteData("${AppConstants.transportBusStops}/$id");
  }
}
  