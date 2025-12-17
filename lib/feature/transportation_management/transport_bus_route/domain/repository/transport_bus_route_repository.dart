import 'package:get/get_connect/http/src/response/response.dart';
import 'package:mighty_school/api_handle/api_client.dart';
import 'package:mighty_school/feature/transportation_management/transport_bus_route/domain/model/transport_bus_route_body.dart';
import 'package:mighty_school/util/app_constants.dart';

class TransportBusRouteRepository {
  final ApiClient apiClient;

  TransportBusRouteRepository({required this.apiClient});

  Future<Response?> getTransportBusRouteList(int page) async {
    return await apiClient.getData("${AppConstants.transportBusRoutes}?per_page=20&page=$page");
  }

  Future<Response?> createTransportBusRoute(TransportBusRouteBody transportBusRouteBody) async {
    return await apiClient.postData(AppConstants.transportBusRoutes, transportBusRouteBody.toJson());
  }

  Future<Response?> getTransportBusRouteDetails(int id) async {
    return await apiClient.getData("${AppConstants.transportBusRoutes}/$id");
  }

  Future<Response?> updateTransportBusRoute(TransportBusRouteBody transportBusRouteBody, int id) async {
    return await apiClient.postData("${AppConstants.transportBusRoutes}/$id", {
      ...transportBusRouteBody.toJson(),
      "_method": "PUT"
    });
  }

  Future<Response?> deleteTransportBusRoute(int id) async {
    return await apiClient.deleteData("${AppConstants.transportBusRoutes}/$id");
  }
}
  