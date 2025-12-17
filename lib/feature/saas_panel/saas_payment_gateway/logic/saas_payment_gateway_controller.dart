import 'package:get/get.dart';
import 'package:mighty_school/api_handle/api_checker.dart';
import 'package:mighty_school/common/widget/custom_snackbar.dart';
import 'package:mighty_school/feature/saas_panel/saas_payment_gateway/domain/model/saas_payment_gateway_model.dart';
import 'package:mighty_school/feature/saas_panel/saas_payment_gateway/domain/repository/saas_payment_gateway_repository.dart';

class SaasPaymentGatewayController extends GetxController implements GetxService {
  final SaasPaymentGatewayRepository saasPaymentGatewayRepository;
  SaasPaymentGatewayController({required this.saasPaymentGatewayRepository});

  SaasPaymentGatewayModel? saasPaymentGatewayModel;
  PaymentGatewayItem? payStackPaymentGatewayItem;
  PaymentGatewayItem? razorPayPaymentGatewayItem;
  PaymentGatewayItem? stripePaymentGatewayItem;
  PaymentGatewayItem? payPalPaymentGatewayItem;
  PaymentGatewayItem? sslCommerzPaymentGatewayItem;
  PaymentGatewayItem? paymobAcceptPaymentGatewayItem;
  PaymentGatewayItem? flutterWavePaymentGatewayItem;
  PaymentGatewayItem? senangPayPaymentGatewayItem;
  PaymentGatewayItem? payTmPaymentGatewayItem;
  Future<void> getSaasPaymentGateway() async {
    Response? response = await saasPaymentGatewayRepository.getSaasPaymentGateway();
    if (response?.statusCode == 200) {
      saasPaymentGatewayModel = SaasPaymentGatewayModel.fromJson(response!.body);
      payStackPaymentGatewayItem = saasPaymentGatewayModel?.data?.firstWhere((element) => element.name == "paystack");
      razorPayPaymentGatewayItem = saasPaymentGatewayModel?.data?.firstWhere((element) => element.name == "razor_pay");
      stripePaymentGatewayItem = saasPaymentGatewayModel?.data?.firstWhere((element) => element.name == "stripe");
      payPalPaymentGatewayItem = saasPaymentGatewayModel?.data?.firstWhere((element) => element.name == "paypal");
      sslCommerzPaymentGatewayItem = saasPaymentGatewayModel?.data?.firstWhere((element) => element.name == "ssl_commerz");
      paymobAcceptPaymentGatewayItem = saasPaymentGatewayModel?.data?.firstWhere((element) => element.name == "paymob_accept");
      flutterWavePaymentGatewayItem = saasPaymentGatewayModel?.data?.firstWhere((element) => element.name == "flutterwave");
      senangPayPaymentGatewayItem = saasPaymentGatewayModel?.data?.firstWhere((element) => element.name == "senang_pay");
      payTmPaymentGatewayItem = saasPaymentGatewayModel?.data?.firstWhere((element) => element.name == "paytm");

    } else {
      ApiChecker.checkApi(response!);
    }
    update();
  }


  bool isLoading = false;
  Future<void> editSaasPaymentGateway(PaymentGatewayItem item) async {
    isLoading = true;
    update();
    Response? response = await saasPaymentGatewayRepository.editSaasPaymentGateway(item);
    if (response?.statusCode == 200) {
      isLoading = false;
      update();
     showCustomSnackBar("updated_successfully".tr, isError: false);
     getSaasPaymentGateway();
    } else {
      ApiChecker.checkApi(response!);
    }
    update();
  }

  int? selectedIndex;
  String? selectedPaymentType;
  void selectPaymentType(int index, String paymentType) {
    selectedIndex = index;
    selectedPaymentType = paymentType;
    update();
  }



}
  