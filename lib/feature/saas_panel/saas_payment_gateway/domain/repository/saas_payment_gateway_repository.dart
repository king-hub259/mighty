import 'package:get/get_connect/http/src/response/response.dart';
import 'package:mighty_school/api_handle/api_client.dart';
import 'package:mighty_school/feature/saas_panel/saas_payment_gateway/domain/model/saas_payment_gateway_model.dart';
import 'package:mighty_school/util/app_constants.dart';

class SaasPaymentGatewayRepository {
  final ApiClient apiClient;

  SaasPaymentGatewayRepository({required this.apiClient});
  
  Future<Response?> getSaasPaymentGateway() async {
    return await apiClient.getData(AppConstants.saasPayment);
  }


  Future<Response?> editSaasPaymentGateway(PaymentGatewayItem item) async {
    return await apiClient.postData("${AppConstants.saasPayment}/${item.id}",item.toJson());
  }

  Future<Response?> updateStatus(int id) async {
    return await apiClient.getData("");
  }

  Future<Response?> updateMode(int id) async {
    return await apiClient.getData("");
  }
}
  