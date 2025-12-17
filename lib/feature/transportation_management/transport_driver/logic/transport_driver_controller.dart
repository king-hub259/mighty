import 'package:get/get.dart';
import 'package:mighty_school/api_handle/api_checker.dart';
import 'package:mighty_school/common/widget/custom_snackbar.dart';
import 'package:mighty_school/feature/transportation_management/transport_driver/domain/model/transport_driver_body.dart';
import 'package:mighty_school/feature/transportation_management/transport_driver/domain/model/transport_driver_model.dart';
import 'package:mighty_school/feature/transportation_management/transport_driver/domain/repository/transport_driver_repository.dart';

class TransportDriverController extends GetxController implements GetxService {
  final TransportDriverRepository transportDriverRepository;
  TransportDriverController({required this.transportDriverRepository});

  TransportDriverModel? transportDriverModel;
  Future<void> getTransportDriverList(int page) async {
    Response? response = await transportDriverRepository.getTransportDriverList(page);
    if (response?.statusCode == 200) {
      if (page == 1) {
        transportDriverModel = TransportDriverModel.fromJson(response?.body);
      } else {
        transportDriverModel?.data?.data?.addAll(TransportDriverModel.fromJson(response?.body).data!.data!);
        transportDriverModel?.data?.currentPage = TransportDriverModel.fromJson(response?.body).data?.currentPage;
        transportDriverModel?.data?.total = TransportDriverModel.fromJson(response?.body).data?.total;
      }
    } else {
      ApiChecker.checkApi(response!);
    }
    update();
  }

  TransportDriverItem? selectedTransportDriverItem;
  void setSelectedTransportDriverItem(TransportDriverItem item) {
    selectedTransportDriverItem = item;
    update();
  }

  bool isLoading = false;
  Future<void> createTransportDriver(TransportDriverBody transportDriverBody) async {
    isLoading = true;
    update();
    Response? response = await transportDriverRepository.createTransportDriver(transportDriverBody);
    if (response?.statusCode == 200) {
      isLoading = false;
      Get.back();
      showCustomSnackBar("added_successfully".tr, isError: false);
      getTransportDriverList(1);
    } else {
      isLoading = false;
      ApiChecker.checkApi(response!);
    }
    update();
  }

  Future<void> updateTransportDriver(TransportDriverBody transportDriverBody, int id) async {
    isLoading = true;
    update();
    Response? response = await transportDriverRepository.updateTransportDriver(transportDriverBody, id);
    if (response?.statusCode == 200) {
      isLoading = false;
      Get.back();
      showCustomSnackBar("updated_successfully".tr, isError: false);
      getTransportDriverList(1);
    } else {
      isLoading = false;
      ApiChecker.checkApi(response!);
    }
    update();
  }

  Future<void> deleteTransportDriver(int id) async {
    Response? response = await transportDriverRepository.deleteTransportDriver(id);
    if (response?.statusCode == 200) {
      getTransportDriverList(1);
      showCustomSnackBar("deleted_successfully".tr, isError: false);
    } else {
      ApiChecker.checkApi(response!);
    }
    update();
  }
}
  