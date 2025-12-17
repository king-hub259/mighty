import 'package:get/get.dart';
import 'package:mighty_school/api_handle/api_checker.dart';
import 'package:mighty_school/common/widget/custom_snackbar.dart';
import 'package:mighty_school/feature/transportation_management/transport_bus/domain/model/transport_bus_body.dart';
import 'package:mighty_school/feature/transportation_management/transport_bus/domain/model/transport_bus_model.dart';
import 'package:mighty_school/feature/transportation_management/transport_bus/domain/repository/transport_bus_repository.dart';

class TransportBusController extends GetxController implements GetxService {
  final TransportBusRepository transportBusRepository;
  TransportBusController({required this.transportBusRepository});

  TransportBusModel? transportBusModel;
  Future<void> getTransportBusList(int page) async {
    Response? response = await transportBusRepository.getTransportBusList(page);
    if (response?.statusCode == 200) {
      if (page == 1) {
        transportBusModel = TransportBusModel.fromJson(response?.body);
      } else {
        transportBusModel?.data?.data?.addAll(TransportBusModel.fromJson(response?.body).data!.data!);
        transportBusModel?.data?.currentPage = TransportBusModel.fromJson(response?.body).data?.currentPage;
        transportBusModel?.data?.total = TransportBusModel.fromJson(response?.body).data?.total;
      }
    } else {
      ApiChecker.checkApi(response!);
    }
    update();
  }

  TransportBusItem? selectedTransportBusItem;
  void setSelectedTransportBusItem(TransportBusItem item) {
    selectedTransportBusItem = item;
    update();
  }

  bool isLoading = false;
  Future<void> createTransportBus(TransportBusBody transportBusBody) async {
    isLoading = true;
    update();
    Response? response = await transportBusRepository.createTransportBus(transportBusBody);
    if (response?.statusCode == 200) {
      isLoading = false;
      Get.back();
      showCustomSnackBar("added_successfully".tr, isError: false);
      getTransportBusList(1);
    } else {
      isLoading = false;
      ApiChecker.checkApi(response!);
    }
    update();
  }

  Future<void> updateTransportBus(TransportBusBody transportBusBody, int id) async {
    isLoading = true;
    update();
    Response? response = await transportBusRepository.updateTransportBus(transportBusBody, id);
    if (response?.statusCode == 200) {
      isLoading = false;
      Get.back();
      showCustomSnackBar("updated_successfully".tr, isError: false);
      getTransportBusList(1);
    } else {
      isLoading = false;
      ApiChecker.checkApi(response!);
    }
    update();
  }

  Future<void> deleteTransportBus(int id) async {
    Response? response = await transportBusRepository.deleteTransportBus(id);
    if (response?.statusCode == 200) {
      getTransportBusList(1);
      showCustomSnackBar("deleted_successfully".tr, isError: false);
    } else {
      ApiChecker.checkApi(response!);
    }
    update();
  }
}
  