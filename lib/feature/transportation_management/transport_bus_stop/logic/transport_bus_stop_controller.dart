import 'package:get/get.dart';
import 'package:mighty_school/api_handle/api_checker.dart';
import 'package:mighty_school/common/widget/custom_snackbar.dart';
import 'package:mighty_school/feature/transportation_management/transport_bus_stop/domain/model/transport_bus_stop_body.dart';
import 'package:mighty_school/feature/transportation_management/transport_bus_stop/domain/model/transport_bus_stop_model.dart';
import 'package:mighty_school/feature/transportation_management/transport_bus_stop/domain/repository/transport_bus_stop_repository.dart';

class TransportBusStopController extends GetxController implements GetxService {
  final TransportBusStopRepository transportBusStopRepository;
  TransportBusStopController({required this.transportBusStopRepository});

  TransportBusStopModel? transportBusStopModel;
  Future<void> getTransportBusStopList(int page) async {
    Response? response = await transportBusStopRepository.getTransportBusStopList(page);
    if (response?.statusCode == 200) {
      if (page == 1) {
        transportBusStopModel = TransportBusStopModel.fromJson(response?.body);
      } else {
        transportBusStopModel?.data?.data?.addAll(TransportBusStopModel.fromJson(response?.body).data!.data!);
        transportBusStopModel?.data?.currentPage = TransportBusStopModel.fromJson(response?.body).data?.currentPage;
        transportBusStopModel?.data?.total = TransportBusStopModel.fromJson(response?.body).data?.total;
      }
    } else {
      ApiChecker.checkApi(response!);
    }
    update();
  }

  TransportBusStopItem? selectedTransportBusStopItem;
  void setSelectedTransportBusStopItem(TransportBusStopItem item) {
    selectedTransportBusStopItem = item;
    update();
  }

  bool isLoading = false;
  Future<void> createTransportBusStop(TransportBusStopBody transportBusStopBody) async {
    isLoading = true;
    update();
    Response? response = await transportBusStopRepository.createTransportBusStop(transportBusStopBody);
    if (response?.statusCode == 200) {
      isLoading = false;
      Get.back();
      showCustomSnackBar("added_successfully".tr, isError: false);
      getTransportBusStopList(1);
    } else {
      isLoading = false;
      ApiChecker.checkApi(response!);
    }
    update();
  }

  Future<void> updateTransportBusStop(TransportBusStopBody transportBusStopBody, int id) async {
    isLoading = true;
    update();
    Response? response = await transportBusStopRepository.updateTransportBusStop(transportBusStopBody, id);
    if (response?.statusCode == 200) {
      isLoading = false;
      Get.back();
      showCustomSnackBar("updated_successfully".tr, isError: false);
      getTransportBusStopList(1);
    } else {
      isLoading = false;
      ApiChecker.checkApi(response!);
    }
    update();
  }

  Future<void> deleteTransportBusStop(int id) async {
    Response? response = await transportBusStopRepository.deleteTransportBusStop(id);
    if (response?.statusCode == 200) {
      getTransportBusStopList(1);
      showCustomSnackBar("deleted_successfully".tr, isError: false);
    } else {
      ApiChecker.checkApi(response!);
    }
    update();
  }
}
  