
import 'package:get/get.dart';
import 'package:mighty_school/api_handle/api_checker.dart';
import 'package:mighty_school/common/widget/custom_snackbar.dart';
import 'package:mighty_school/feature/fees_management/fees_head/domain/model/fees_head_model.dart';
import 'package:mighty_school/feature/fees_management/fees_head/domain/repository/fees_head_repository.dart';

class FeesHeadController extends GetxController implements GetxService{
  final FeesHeadRepository feesHeadRepository;
  FeesHeadController({required this.feesHeadRepository});

  FeesHeadModel? feesHeadModel;
  Future<void> getFeesHeadList(int page) async {
    Response? response = await feesHeadRepository.getFeesHeadList(page);
    if(response?.statusCode == 200){
      if(page == 1){
        feesHeadModel = FeesHeadModel.fromJson(response?.body);
      }else{
        feesHeadModel?.data?.data?.addAll(FeesHeadModel.fromJson(response?.body).data!.data!);
        feesHeadModel?.data?.currentPage = FeesHeadModel.fromJson(response?.body).data?.currentPage;
        feesHeadModel?.data?.total = FeesHeadModel.fromJson(response?.body).data?.total;
      }
    }else{
      ApiChecker.checkApi(response!);
    }
    update();
  }

  FeesHeadItem? selectedFeesHeadItem;
  void selectFeesHeadItem(FeesHeadItem feesHeadItem) {
    selectedFeesHeadItem = feesHeadItem;
    update();
  }



  bool isLoading = false;

  Future<void> addNewFeesHead(String name, String serial) async {
    isLoading = true;
    update();
    Response? response = await feesHeadRepository.addNewFessHead(name, serial);
    if(response!.statusCode == 200){
      isLoading = false;
      showCustomSnackBar("added_successfully".tr, isError: false);
      getFeesHeadList(1);
      Get.back();
    }else{
      isLoading = false;
      ApiChecker.checkApi(response);
    }
    update();

  }

  Future<void> updateNewFeesHead(String name, String serial, int id) async {
    isLoading = true;
    update();
    Response? response = await feesHeadRepository.editFessHead(name, serial, id);
    if(response!.statusCode == 200){
      isLoading = false;
      Get.back();
      showCustomSnackBar("updated_successfully".tr.tr, isError: false);
      getFeesHeadList(1);
    }else{
      isLoading = false;
      ApiChecker.checkApi(response);
    }
    update();

  }



  Future<void> deleteFeesHead(int id) async {
    Response? response = await feesHeadRepository.deleteFeesHead(id);
    if(response!.statusCode == 200){
      showCustomSnackBar("deleted_successfully".tr, isError: false);
      getFeesHeadList(1);
    }else{
      ApiChecker.checkApi(response);
    }
    update();

  }
}