import 'package:get/get.dart';
import 'package:mighty_school/api_handle/api_checker.dart';
import 'package:mighty_school/common/widget/custom_snackbar.dart';
import 'package:mighty_school/feature/account_management/contra/domain/repository/contra_repository.dart';
import 'package:mighty_school/feature/account_management/payment/domain/model/payment_body.dart';


class ContraController extends GetxController implements GetxService{
  final ContraRepository contraRepository;
  ContraController({required this.contraRepository});

  bool isLoading = false;
  Future<void> createPayment(PaymentBody paymentBody) async {
    isLoading = true;
    update();
    Response? response = await contraRepository.makePayment(paymentBody);
    if(response!.statusCode == 200){
      isLoading = false;
      Get.back();
      showCustomSnackBar("added_successfully".tr, isError: false);
    }else{
      ApiChecker.checkApi(response);
    }
    isLoading = false;
    update();
  }

}