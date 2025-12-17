import 'package:get/get.dart';
import 'package:mighty_school/api_handle/api_checker.dart';
import 'package:mighty_school/common/widget/custom_snackbar.dart';
import 'package:mighty_school/feature/exam_management/remark_config/domain/model/re_mark_config_body.dart';
import 'package:mighty_school/feature/exam_management/remark_config/domain/model/remark_config_model.dart';
import 'package:mighty_school/feature/exam_management/remark_config/domain/repository/remark_config_repository.dart';

class ReMarkConfigController extends GetxController implements GetxService{
  final ReMarkConfigRepository reMarkConfigRepository;
  ReMarkConfigController({required this.reMarkConfigRepository});

  ReMarkConfigModel? reMarkConfigModel;
  Future<void> getRemarkConfigList(int page) async {
    Response? response = await reMarkConfigRepository.getRemarkConfigList(page);
    if(response?.statusCode == 200){
      if(page ==1){
        reMarkConfigModel = ReMarkConfigModel.fromJson(response?.body);
      }else{
        reMarkConfigModel?.data?.data?.addAll(ReMarkConfigModel.fromJson(response?.body).data!.data!);
        reMarkConfigModel?.data?.currentPage = ReMarkConfigModel.fromJson(response?.body).data?.currentPage;
        reMarkConfigModel?.data?.total = ReMarkConfigModel.fromJson(response?.body).data?.total;
      }

    }else{
      ApiChecker.checkApi(response!);
    }
    update();

  }




  int markConfigTypeIndex = 0;
  void setMarkConfigTypeIndex(int typeIndex){
    markConfigTypeIndex = typeIndex;
    update();
  }

  bool isLoading = false;
  Future<void> createNewReConfig( ReMarkConfigBody body,) async {
    isLoading = true;
    update();
    Response? response = await reMarkConfigRepository.addNewRemarkConfig(body );
    if(response!.statusCode == 200){
      isLoading = false;
      Get.back();
      showCustomSnackBar("added_successfully".tr, isError: false);
      getRemarkConfigList(1);
      Get.back();

    }else{
      ApiChecker.checkApi(response);
    }
    isLoading = false;
    update();

  }

  Future<void> updateReMarkConfig(ReMarkConfigBody body, int id) async {
    isLoading = true;
    update();
    Response? response = await reMarkConfigRepository.updateRemarkConfig(body, id);
    if(response!.statusCode == 200){
      isLoading = false;
      Get.back();
      showCustomSnackBar("updated_successfully".tr, isError: false);
      getRemarkConfigList(1);
      Get.back();
    }else{
      ApiChecker.checkApi(response);
    }
    isLoading = false;
    update();

  }

  Future<void> deleteReMarkConfig( int id) async {
    isLoading = true;
    update();
    Response? response = await reMarkConfigRepository.deleteRemarkConfig(id);
    if(response!.statusCode == 200){
      isLoading = false;
      Get.back();
      showCustomSnackBar("deleted_successfully".tr, isError: false);
      getRemarkConfigList(1);

    }else{
      ApiChecker.checkApi(response);
    }
    isLoading = false;
    update();

  }



}