import 'package:get/get.dart';
import 'package:mighty_school/api_handle/api_checker.dart';
import 'package:mighty_school/api_handle/global_api_response_model.dart';
import 'package:mighty_school/common/widget/custom_snackbar.dart';
import 'package:mighty_school/feature/hostel_management/hostel/domain/model/hostel_body.dart';
import 'package:mighty_school/feature/hostel_management/hostel/domain/model/hostel_model.dart';
import 'package:mighty_school/feature/hostel_management/hostel/domain/repository/hostel_repository.dart';

class HostelController extends GetxController implements GetxService {
  final HostelRepository hostelRepository;
  HostelController({required this.hostelRepository});

  bool isLoading = false;
  ApiResponse<HostelItem>? hostelModel;

  Future<void> getHostelList(int page) async {
    Response? response = await hostelRepository.getHostelList(page);
    if (response?.statusCode == 200) {
      final apiResponse = ApiResponse<HostelItem>.fromJson(response!.body, (data) => HostelItem.fromJson(data));
      if(page == 1){
        hostelModel = apiResponse;
      }else{
        hostelModel?.data?.data?.addAll(apiResponse.data?.data ?? []);
        hostelModel?.data?.total = apiResponse.data?.total;
        hostelModel?.data?.currentPage = apiResponse.data?.currentPage;
      }
    } else {
      ApiChecker.checkApi(response!);
    }
    update();
  }


  Future<void> addNewHostel(HostelBody hostelBody) async {
    isLoading = true;
    update();
    Response? response = await hostelRepository.addNewHostel(hostelBody);
    if (response?.statusCode == 200) {

      Get.back();
      showCustomSnackBar('added_successfully'.tr, isError: false);
      getHostelList(1);
    } else {
      ApiChecker.checkApi(response!);
    }
    isLoading = false;
    update();
  }


  Future<void> updateHostel(int id, HostelBody hostelBody) async {
    isLoading = true;
    update();
    Response? response = await hostelRepository.updateHostel(id, hostelBody);
    if (response?.statusCode == 200) {
      Get.back();
      showCustomSnackBar('updated_successfully'.tr, isError: false);
      getHostelList(1);

    } else {
      ApiChecker.checkApi(response!);
    }
    isLoading = false;
    update();
  }


  Future<void> deleteHostel(int id) async {
    Response? response = await hostelRepository.deleteHostel(id);
    if (response?.statusCode == 200) {
      showCustomSnackBar('deleted_successfully'.tr, isError: false);
      getHostelList(1);
    } else {
      ApiChecker.checkApi(response!);
    }
    update();
  }



  HostelItem? selectedHostelItem;
  void setSelectedHostel(HostelItem hostel, {bool notify = true}) {
    selectedHostelItem = hostel;
    if(notify) {
      update();
    }
  }
}
  