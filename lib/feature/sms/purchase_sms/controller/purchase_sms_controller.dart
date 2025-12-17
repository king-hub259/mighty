import 'package:get/get.dart';
import 'package:mighty_school/api_handle/api_checker.dart';
import 'package:mighty_school/common/widget/custom_snackbar.dart';
import 'package:mighty_school/feature/sms/purchase_sms/domain/models/purchase_sms_body.dart';
import 'package:mighty_school/feature/sms/purchase_sms/domain/models/purchase_sms_model.dart';
import 'package:mighty_school/feature/sms/purchase_sms/domain/repository/purchase_sms_repository.dart';

class PurchaseSmsController extends GetxController implements GetxService{
  final PurchaseSmsRepository purchaseSmsRepository;
  PurchaseSmsController({required this.purchaseSmsRepository});




  bool isLoading = false;
  PurchaseSmsModel? purchaseSmsModel;
  Future<void> getPurchaseSmsList(int page) async {
    Response? response = await purchaseSmsRepository.getPurchaseSmsList(page);
    if (response?.statusCode == 200) {
      purchaseSmsModel = PurchaseSmsModel.fromJson(response?.body);
    }else{
      ApiChecker.checkApi(response!);
    }
    update();
  }

  Future<void> createPurchaseSms(PurchaseSmsBody purchaseSmsBody) async {
    isLoading = true;
    update();
    Response? response = await purchaseSmsRepository.createPurchaseSms(purchaseSmsBody);
    if(response!.statusCode == 200){
      isLoading = false;
      Get.back();
      showCustomSnackBar("added_successfully".tr, isError: false);
      getPurchaseSmsList(1);

    }else{
      ApiChecker.checkApi(response);
    }
    isLoading = false;
    update();

  }

  Future<void> updatePurchaseSms(PurchaseSmsBody purchaseSmsBody, int id) async {
    isLoading = true;
    update();
    Response? response = await purchaseSmsRepository.updatePurchaseSms(purchaseSmsBody, id);
    if(response!.statusCode == 200){
      isLoading = false;
      Get.back();
      showCustomSnackBar("updated_successfully".tr, isError: false);
      getPurchaseSmsList(1);
    }else{
      ApiChecker.checkApi(response);
    }
    isLoading = false;
    update();

  }


  Future<void> deletePurchaseSms(int id) async {
    isLoading = true;
    Response? response = await purchaseSmsRepository.deletePurchaseSms(id);
    if (response?.statusCode == 200) {
      showCustomSnackBar("deleted_successfully".tr, isError: false);
      getPurchaseSmsList(1);
      isLoading = false;
    }else{
      isLoading = false;
      ApiChecker.checkApi(response!);
    }
    update();
  }
  List<String> maskingTypes = ["masking", "non_masking"];
  String selectedMaskingType = "masking";
  List<String> smsGateway = ["bulksmsbd"];
  String selectedSmsGateway = "bulksmsbd";

  void setSelectedSmsGateway(String val){
    selectedSmsGateway = val;
    update();
  }
  void setSelectedMaskingType(String val){
    selectedMaskingType = val;
    update();
  }

}