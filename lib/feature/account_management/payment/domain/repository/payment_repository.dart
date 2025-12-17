import 'package:get/get_connect/http/src/response/response.dart';
import 'package:mighty_school/api_handle/api_client.dart';
import 'package:mighty_school/feature/account_management/payment/domain/model/payment_body.dart';
import 'package:mighty_school/util/app_constants.dart';

class PaymentRepository{
  final ApiClient apiClient;
  PaymentRepository({required this.apiClient});


  Future<Response?> makePayment(PaymentBody paymentBody) async {
    return await apiClient.postData(AppConstants.payment, paymentBody.toJson());
  }

}