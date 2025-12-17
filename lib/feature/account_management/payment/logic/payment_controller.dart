import 'package:get/get.dart';
import 'package:mighty_school/api_handle/api_checker.dart';
import 'package:mighty_school/feature/account_management/payment/domain/model/payment_body.dart';
import 'package:mighty_school/feature/account_management/payment/domain/repository/payment_repository.dart';


class PaymentController extends GetxController implements GetxService{
  final PaymentRepository paymentRepository;
  PaymentController({required this.paymentRepository});

  bool isLoading = false;
  Future<void> createPayment(PaymentBody paymentBody) async {
    isLoading = true;
    update();
    Response? response = await paymentRepository.makePayment(paymentBody);
    if(response!.statusCode == 200){
      isLoading = false;
      Get.back();
    }else{
      ApiChecker.checkApi(response);
    }
    isLoading = false;
    update();
  }

}