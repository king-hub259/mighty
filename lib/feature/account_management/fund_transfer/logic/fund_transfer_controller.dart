import 'package:get/get.dart';
import 'package:mighty_school/api_handle/api_checker.dart';
import 'package:mighty_school/common/widget/custom_snackbar.dart';
import 'package:mighty_school/feature/account_management/fund_transfer/domain/repository/fund_transfer_repository.dart';
import 'package:mighty_school/feature/account_management/payment/domain/model/payment_body.dart';


class FundTransferController extends GetxController implements GetxService{
  final FundTransferRepository fundTransferRepository;
  FundTransferController({required this.fundTransferRepository});

  bool isLoading = false;
  Future<void> createPayment(PaymentBody paymentBody) async {
    isLoading = true;
    update();
    Response? response = await fundTransferRepository.makePayment(paymentBody);
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