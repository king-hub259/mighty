
import 'package:get/get.dart';
import 'package:mighty_school/api_handle/api_checker.dart';
import 'package:mighty_school/common/widget/custom_snackbar.dart';
import 'package:mighty_school/feature/fees_management/fees_date/domain/model/fees_date_body.dart';
import 'package:mighty_school/feature/fees_management/fees_date/domain/model/fees_date_model.dart';
import 'package:mighty_school/feature/fees_management/fees_date/domain/repository/fees_date_repository.dart';

class FeesDateController extends GetxController implements GetxService{
  final FeesDateRepository feesDateRepository;
  FeesDateController({required this.feesDateRepository});

  FeesDateModel? feesDateModel;
  Future<void> getFeesDateList(int page) async {
    Response? response = await feesDateRepository.getFeesDateList(page);
    if(response?.statusCode == 200){
      if(page == 1){
        feesDateModel = FeesDateModel.fromJson(response?.body);
      }else{
        feesDateModel?.data?.data?.addAll(FeesDateModel.fromJson(response?.body).data!.data!);
        feesDateModel?.data?.currentPage = FeesDateModel.fromJson(response?.body).data?.currentPage;
        feesDateModel?.data?.total = FeesDateModel.fromJson(response?.body).data?.total;
      }
    }else{
      ApiChecker.checkApi(response!);
    }
    update();

  }



  bool isLoading = false;

  Future<void> addNewFeesDate(FeesDateBody feesDateBody) async {
    isLoading = true;
    update();
    Response? response = await feesDateRepository.addNewFeesDate(feesDateBody);
    if(response!.statusCode == 200){
      isLoading = false;
      showCustomSnackBar("added_successfully".tr, isError: false);
      getFeesDateList(1);
      Get.back();
    }else{
      isLoading = false;
      ApiChecker.checkApi(response);
    }
    update();

  }

  Future<void> updateFeesDate(FeesDateBody feesDateBody, int id) async {
    isLoading = true;
    update();
    Response? response = await feesDateRepository.updateFeesDate(feesDateBody, id);
    if(response!.statusCode == 200){
      isLoading = false;
      showCustomSnackBar("updated_successfully".tr, isError: false);
      getFeesDateList(1);
      Get.back();
    }else{
      isLoading = false;
      ApiChecker.checkApi(response);
    }
    update();

  }

  Future<void> deleteFeesDate(int id) async {
    isLoading = true;
    update();
    Response? response = await feesDateRepository.deleteFeesDate(id);
    if(response!.statusCode == 200){
      isLoading = false;
      showCustomSnackBar("deleted_successfully".tr, isError: false);
      getFeesDateList(1);
      Get.back();
    }else{
      isLoading = false;
      ApiChecker.checkApi(response);
    }
    update();

  }

}