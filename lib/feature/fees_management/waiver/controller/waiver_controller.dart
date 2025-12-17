
import 'package:get/get.dart';
import 'package:mighty_school/api_handle/api_checker.dart';
import 'package:mighty_school/common/widget/custom_snackbar.dart';
import 'package:mighty_school/feature/fees_management/waiver/domain/model/waiver_model.dart';
import 'package:mighty_school/feature/fees_management/waiver/domain/repository/waiver_repository.dart';

class WaiverController extends GetxController implements GetxService{
  final WaiverRepository waiverRepository;
  WaiverController({required this.waiverRepository});

  WaiverModel? waiverModel;
  Future<void> getWaiverList(int page) async {
    Response? response = await waiverRepository.getWaiverList(page);
    if(response?.statusCode == 200){
      if(page == 1){
        waiverModel = WaiverModel.fromJson(response?.body);
      }else{
        waiverModel?.data?.data?.addAll(WaiverModel.fromJson(response?.body).data!.data!);
        waiverModel?.data?.currentPage = WaiverModel.fromJson(response?.body).data?.currentPage;
        waiverModel?.data?.total = WaiverModel.fromJson(response?.body).data?.total;

      }

    }else{
      ApiChecker.checkApi(response!);
    }
    update();

  }



  bool isLoading = false;

  Future<void> addNewWaiver(String name) async {
    isLoading = true;
    update();
    Response? response = await waiverRepository.addNewWaiver(name);
    if(response!.statusCode == 200){
      isLoading = false;
      showCustomSnackBar("added_successfully".tr, isError: false);
      getWaiverList(1);
      Get.back();
    }else{
      isLoading = false;
      ApiChecker.checkApi(response);
    }
    update();

  }

  Future<void> updateWaiver(String name, String serial, int id) async {
    isLoading = true;
    update();
    Response? response = await waiverRepository.editWaiver(name, id);
    if(response!.statusCode == 200){
      isLoading = false;
      Get.back();
      showCustomSnackBar("updated_successfully".tr.tr, isError: false);
      getWaiverList(1);
    }else{
      isLoading = false;
      ApiChecker.checkApi(response);
    }
    update();

  }



  Future<void> deleteWaiver(int id) async {
    Response? response = await waiverRepository.deleteWaiver(id);
    if(response!.statusCode == 200){
      showCustomSnackBar("deleted_successfully".tr, isError: false);
      getWaiverList(1);
    }else{
      ApiChecker.checkApi(response);
    }
    update();

  }
}