
import 'dart:developer';

import 'package:get/get.dart';
import 'package:mighty_school/api_handle/api_checker.dart';
import 'package:mighty_school/feature/digital_payment/domain/models/digital_payment_body.dart';
import 'package:mighty_school/feature/digital_payment/domain/repository/digital_payment_repository.dart';
import 'package:universal_html/html.dart' as html;

class DigitalPaymentController extends GetxController implements GetxService{
  final DigitalPaymentRepository digitalPaymentRepository;
  DigitalPaymentController({required this.digitalPaymentRepository});

  Future<void> makeDigitalPayment(DigitalPaymentBody body) async {
    Response? response = await digitalPaymentRepository.makeDigitalPayment(body);
    if (response.statusCode == 200) {
      Get.back();
      String paymentUrl = response.body['payment_url'];
      log("paymentUrl: $paymentUrl");
      html.window.open(paymentUrl,"_self");
     } else {
      ApiChecker.checkApi(response);
    }
  }
}