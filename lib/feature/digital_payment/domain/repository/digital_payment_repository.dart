import 'package:get/get_connect/http/src/response/response.dart';
import 'package:mighty_school/api_handle/api_client.dart';
import 'package:mighty_school/feature/digital_payment/domain/models/digital_payment_body.dart';
import 'package:mighty_school/util/app_constants.dart';

class DigitalPaymentRepository {
 final ApiClient apiClient;
  DigitalPaymentRepository({required this.apiClient});

  Future<Response> makeDigitalPayment(DigitalPaymentBody body) async {
    return await apiClient.postData(AppConstants.makePayment, body.toJson());
  }
}