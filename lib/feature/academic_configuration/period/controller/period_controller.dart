import 'package:get/get.dart';
import 'package:mighty_school/api_handle/api_checker.dart';
import 'package:mighty_school/common/widget/custom_snackbar.dart';
import 'package:mighty_school/feature/academic_configuration/period/domain/model/period_model.dart';
import 'package:mighty_school/feature/academic_configuration/period/domain/repository/period_repository.dart';

class PeriodController extends GetxController implements GetxService{
  final PeriodRepository periodRepository;
  PeriodController({required this.periodRepository});

  bool isLoading = false;
  PeriodModel? periodModel;
  Future<void> getPeriodList(int page) async {
    Response? response = await periodRepository.getPeriodList(page);
    if(response?.statusCode == 200){
      if(page == 1){
        periodModel = PeriodModel.fromJson(response?.body);
      }else{
        periodModel?.data?.data?.addAll(PeriodModel.fromJson(response?.body).data!.data!);
        periodModel?.data?.currentPage = PeriodModel.fromJson(response?.body).data?.currentPage;
        periodModel?.data?.total = PeriodModel.fromJson(response?.body).data?.total;
      }
    }else{
      ApiChecker.checkApi(response!);
    }
    update();
  }

  PeriodItem? selectedPeriodItem;
  void setSelectPeriodItem(PeriodItem? sectionItem){
    selectedPeriodItem = sectionItem;
    update();
  }


  Future<void> addNewPeriod(String period, String serial) async {
    isLoading = true;
    update();
    Response? response = await periodRepository.addNewPeriod(period, serial);
    if(response?.statusCode == 200){
      isLoading = false;
      Get.back();
      showCustomSnackBar("added_successfully".tr, isError: false);
      getPeriodList(1);
    }else{
      isLoading = false;
      ApiChecker.checkApi(response!);
    }
    update();
  }

  Future<void> updateNewPeriod(String period, String serial, int id) async {
    isLoading = true;
    update();
    Response? response = await periodRepository.periodEdit(period, serial, id);
    if(response?.statusCode == 200){
      isLoading = false;
      Get.back();
      showCustomSnackBar("updated_successfully".tr, isError: false);
      getPeriodList(1);
    }else{
      isLoading = false;
      ApiChecker.checkApi(response!);
    }
    update();
  }

  Future<void> deletePeriod(int id) async {
    Response? response = await periodRepository.periodDelete(id);
    if(response?.statusCode == 200){
      getPeriodList(1);
      showCustomSnackBar("deleted_successfully".tr, isError: false);
    }else{
      ApiChecker.checkApi(response!);
    }
    update();
  }



}