
import 'package:get/get.dart';
import 'package:mighty_school/api_handle/api_checker.dart';
import 'package:mighty_school/common/widget/custom_snackbar.dart';
import 'package:mighty_school/feature/fees_management/fees_amount_config/domain/model/fees_body.dart';
import 'package:mighty_school/feature/fees_management/fees_amount_config/domain/model/fees_model.dart';
import 'package:mighty_school/feature/fees_management/fees_amount_config/domain/repository/fees_repository.dart';

class FeesController extends GetxController implements GetxService{
  final FeesRepository feesRepository;
  FeesController({required this.feesRepository});

  FeesModel? feesModel;
  Future<void> getFeesList(int page) async {
    Response? response = await feesRepository.getFeesList(page);
    if(response?.statusCode == 200){
      if(page == 1){
        feesModel = FeesModel.fromJson(response?.body);
      }else{
        feesModel?.data?.data?.addAll(FeesModel.fromJson(response?.body).data!.data!);
        feesModel?.data?.currentPage = FeesModel.fromJson(response?.body).data?.currentPage;
        feesModel?.data?.total = FeesModel.fromJson(response?.body).data?.total;

      }

    }else{
      ApiChecker.checkApi(response!);
    }
    update();

  }


  int feesTypeIndex = 0;
  void setSelectedFeesTypeIndex(int typeIndex){
    feesTypeIndex = typeIndex;
    update();
  }


  bool isLoading = false;

  Future<void> addNewFees(FeesBody feesBody) async {
    isLoading = true;
    update();
    Response? response = await feesRepository.addNewFees(feesBody);
    if(response!.statusCode == 200){
      isLoading = false;
      showCustomSnackBar("added_successfully".tr, isError: false);
      getFeesList(1);
      Get.back();
    }else{
      isLoading = false;
      ApiChecker.checkApi(response);
    }
    update();

  }

}