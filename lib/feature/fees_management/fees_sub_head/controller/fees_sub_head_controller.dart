
import 'package:get/get.dart';
import 'package:mighty_school/api_handle/api_checker.dart';
import 'package:mighty_school/common/widget/custom_snackbar.dart';
import 'package:mighty_school/feature/fees_management/fees_sub_head/domain/model/fees_sub_head_model.dart';
import 'package:mighty_school/feature/fees_management/fees_sub_head/domain/repository/fees_sub_head_repository.dart';

class FeesSubHeadController extends GetxController implements GetxService{
  final FeesSubHeadRepository feesSubHeadRepository;
  FeesSubHeadController({required this.feesSubHeadRepository});

  FeesSubHeadModel? feesSubHeadModel;
  Future<void> getFeesSubHeadList(int page) async {
    Response? response = await feesSubHeadRepository.getFeesSubHeadList(page);
    if(response?.statusCode == 200){
      if(page == 1){
        feesSubHeadModel = FeesSubHeadModel.fromJson(response?.body);
      }else{
        feesSubHeadModel?.data?.data?.addAll(FeesSubHeadModel.fromJson(response?.body).data!.data!);
        feesSubHeadModel?.data?.currentPage = FeesSubHeadModel.fromJson(response?.body).data?.currentPage;
        feesSubHeadModel?.data?.total = FeesSubHeadModel.fromJson(response?.body).data?.total;

      }

    }else{
      ApiChecker.checkApi(response!);
    }
    update();

  }

  FeesSubHeadItem? selectedFeesSubHeadItem;
  void selectFeesSubHeadItem(FeesSubHeadItem item){
    selectedFeesSubHeadItem = item;
    update();
  }



  bool isLoading = false;

  Future<void> addNewFeesSubHead(String name, String serial) async {
    isLoading = true;
    update();
    Response? response = await feesSubHeadRepository.addNewFessSubHead(name, serial);
    if(response!.statusCode == 200){
      isLoading = false;
      showCustomSnackBar("added_successfully".tr, isError: false);
      getFeesSubHeadList(1);
      Get.back();
    }else{
      isLoading = false;
      ApiChecker.checkApi(response);
    }
    update();

  }

  Future<void> updateFeesSubHead(String name, String serial, int id) async {
    isLoading = true;
    update();
    Response? response = await feesSubHeadRepository.editFessSubHead(name, serial, id);
    if(response!.statusCode == 200){
      isLoading = false;
      Get.back();
      showCustomSnackBar("updated_successfully".tr.tr, isError: false);
      getFeesSubHeadList(1);
    }else{
      isLoading = false;
      ApiChecker.checkApi(response);
    }
    update();

  }



  Future<void> deleteFeesSubHead(int id) async {
    Response? response = await feesSubHeadRepository.deleteFeesSubHead(id);
    if(response!.statusCode == 200){
      showCustomSnackBar("deleted_successfully".tr, isError: false);
      getFeesSubHeadList(1);
    }else{
      ApiChecker.checkApi(response);
    }
    update();

  }
}