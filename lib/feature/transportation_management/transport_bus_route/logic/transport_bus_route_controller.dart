import 'package:get/get.dart';
import 'package:mighty_school/api_handle/api_checker.dart';
import 'package:mighty_school/common/widget/custom_snackbar.dart';
import 'package:mighty_school/feature/transportation_management/transport_bus_route/domain/model/transport_bus_route_body.dart';
import 'package:mighty_school/feature/transportation_management/transport_bus_route/domain/model/transport_bus_route_model.dart';
import 'package:mighty_school/feature/transportation_management/transport_bus_route/domain/repository/transport_bus_route_repository.dart';

class TransportBusRouteController extends GetxController implements GetxService {
  final TransportBusRouteRepository transportBusRouteRepository;
  TransportBusRouteController({required this.transportBusRouteRepository});

  TransportBusRouteModel? transportBusRouteModel;
  Future<void> getTransportBusRouteList(int page) async {
    Response? response = await transportBusRouteRepository.getTransportBusRouteList(page);
    if (response?.statusCode == 200) {
      if (page == 1) {
        transportBusRouteModel = TransportBusRouteModel.fromJson(response?.body);
      } else {
        transportBusRouteModel?.data?.data?.addAll(TransportBusRouteModel.fromJson(response?.body).data!.data!);
        transportBusRouteModel?.data?.currentPage = TransportBusRouteModel.fromJson(response?.body).data?.currentPage;
        transportBusRouteModel?.data?.total = TransportBusRouteModel.fromJson(response?.body).data?.total;
      }
    } else {
      ApiChecker.checkApi(response!);
    }
    update();
  }

  TransportBusRouteItem? selectedTransportBusRouteItem;
  void setSelectedTransportBusRouteItem(TransportBusRouteItem item) {
    selectedTransportBusRouteItem = item;
    update();
  }

  bool isLoading = false;
  Future<void> createTransportBusRoute(TransportBusRouteBody transportBusRouteBody) async {
    isLoading = true;
    update();
    Response? response = await transportBusRouteRepository.createTransportBusRoute(transportBusRouteBody);
    if (response?.statusCode == 200) {
      isLoading = false;
      Get.back();
      showCustomSnackBar("added_successfully".tr, isError: false);
      getTransportBusRouteList(1);
    } else {
      isLoading = false;
      ApiChecker.checkApi(response!);
    }
    update();
  }

  Future<void> updateTransportBusRoute(TransportBusRouteBody transportBusRouteBody, int id) async {
    isLoading = true;
    update();
    Response? response = await transportBusRouteRepository.updateTransportBusRoute(transportBusRouteBody, id);
    if (response?.statusCode == 200) {
      isLoading = false;
      Get.back();
      showCustomSnackBar("updated_successfully".tr, isError: false);
      getTransportBusRouteList(1);
    } else {
      isLoading = false;
      ApiChecker.checkApi(response!);
    }
    update();
  }

  Future<void> deleteTransportBusRoute(int id) async {
    Response? response = await transportBusRouteRepository.deleteTransportBusRoute(id);
    if (response?.statusCode == 200) {
      getTransportBusRouteList(1);
      showCustomSnackBar("deleted_successfully".tr, isError: false);
    } else {
      ApiChecker.checkApi(response!);
    }
    update();
  }
}
  