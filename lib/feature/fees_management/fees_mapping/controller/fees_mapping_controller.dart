
import 'package:get/get.dart';
import 'package:mighty_school/api_handle/api_checker.dart';
import 'package:mighty_school/common/widget/custom_snackbar.dart';
import 'package:mighty_school/feature/fees_management/fees_mapping/domain/model/fees_mapping_body.dart';
import 'package:mighty_school/feature/fees_management/fees_mapping/domain/model/fees_mapping_model.dart';
import 'package:mighty_school/feature/fees_management/fees_mapping/domain/repository/fees_mapping_repository.dart';

class FeesMappingController extends GetxController implements GetxService{
  final FeesMappingRepository feesMappingRepository;
  FeesMappingController({required this.feesMappingRepository});

  FeesMappingModel? feesMappingModel;
  Future<void> getFeesMappingList(int page) async {
    Response? response = await feesMappingRepository.getFeesMappingList(page, feesStartupTypeIndex == 0? "fee" : "fee_fine");
    if(response?.statusCode == 200){
      if(page == 1){
        feesMappingModel = FeesMappingModel.fromJson(response?.body);
      }else{
        feesMappingModel?.data?.data?.addAll(FeesMappingModel.fromJson(response?.body).data!.data!);
        feesMappingModel?.data?.currentPage = FeesMappingModel.fromJson(response?.body).data?.currentPage;
        feesMappingModel?.data?.total = FeesMappingModel.fromJson(response?.body).data?.total;

      }

    }else{
      ApiChecker.checkApi(response!);
    }
    update();

  }

  int feesStartupTypeIndex = 0;
  void setSelectedTypeIndex(int typeIndex){
    feesStartupTypeIndex = typeIndex;
    feesMappingModel = null;
    getFeesMappingList(1);
    update();
  }



  bool isLoading = false;
  Future<void> addNewFeesMapping(FeesMappingBody feesMappingBody) async {
    isLoading = true;
    update();
    Response? response = await feesMappingRepository.addNewFeesMapping(feesMappingBody);
    if(response!.statusCode == 200){
      isLoading = false;
      showCustomSnackBar("added_successfully".tr, isError: false);
      getFeesMappingList(1);
      Get.back();
    }else{
      isLoading = false;
      ApiChecker.checkApi(response);
    }
    update();

  }

  Future<void> deleteFeesMapping(int id) async {
    Response? response = await feesMappingRepository.deleteFeesMapping(id);
    if(response!.statusCode == 200){
      Get.back();
      showCustomSnackBar("deleted_successfully".tr, isError: false);
      getFeesMappingList(1);
    }else{
      ApiChecker.checkApi(response);
    }
    update();

  }
}