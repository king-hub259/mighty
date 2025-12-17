import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_title.dart';
import 'package:mighty_school/feature/saas_panel/saas_payment_gateway/domain/model/saas_payment_gateway_model.dart';
import 'package:mighty_school/feature/saas_panel/saas_payment_gateway/logic/saas_payment_gateway_controller.dart';
import 'package:mighty_school/feature/saas_panel/saas_payment_gateway/presentation/widgets/flutterwave.dart';
import 'package:mighty_school/feature/saas_panel/saas_payment_gateway/presentation/widgets/paymob_accept.dart';
import 'package:mighty_school/feature/saas_panel/saas_payment_gateway/presentation/widgets/paypal.dart';
import 'package:mighty_school/feature/saas_panel/saas_payment_gateway/presentation/widgets/paystack.dart';
import 'package:mighty_school/feature/saas_panel/saas_payment_gateway/presentation/widgets/paytm.dart';
import 'package:mighty_school/feature/saas_panel/saas_payment_gateway/presentation/widgets/razor_pay.dart';
import 'package:mighty_school/feature/saas_panel/saas_payment_gateway/presentation/widgets/senang_pay.dart';
import 'package:mighty_school/feature/saas_panel/saas_payment_gateway/presentation/widgets/ssl_commerz.dart';
import 'package:mighty_school/feature/saas_panel/saas_payment_gateway/presentation/widgets/stripe.dart';
import 'package:mighty_school/helper/responsive_helper.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';

class SaasPaymentGatewayWidget extends StatefulWidget {
  const SaasPaymentGatewayWidget({super.key});

  @override
  State<SaasPaymentGatewayWidget> createState() => _SaasPaymentGatewayWidgetState();
}

class _SaasPaymentGatewayWidgetState extends State<SaasPaymentGatewayWidget> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SaasPaymentGatewayController>(
      initState: (_) {
        Get.find<SaasPaymentGatewayController>().getSaasPaymentGateway();
      },
      builder: (saasPaymentGatewayController) {
        SaasPaymentGatewayModel? saasPaymentGatewayModel = saasPaymentGatewayController.saasPaymentGatewayModel;

        return Column(children: [

          Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault,),
            child: CustomTitle(title: "digital_payment_methods".tr, webTitle: ResponsiveHelper.isDesktop(context)),),

          (saasPaymentGatewayModel != null && saasPaymentGatewayModel.data != null)?
           Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
            child: ResponsiveHelper.isDesktop(context)?
            const Column(spacing: Dimensions.paddingSizeLarge, children: [

              Row(spacing: Dimensions.paddingSizeLarge, crossAxisAlignment: CrossAxisAlignment.start, children: [
                Expanded(child: StripePaymentGatewayCardItem()),
                Expanded(child: SslCommerzPaymentGatewayCardItem()),
              ]),

              Row(spacing: Dimensions.paddingSizeLarge, crossAxisAlignment: CrossAxisAlignment.start, children: [
                Expanded(child: PaypalPaymentGatewayCardItem()),
                Expanded(child: SenangPayPaymentGatewayCardItem()),
              ]),

                Row(spacing: Dimensions.paddingSizeLarge, crossAxisAlignment: CrossAxisAlignment.start, children: [

                  Expanded(child: RazorPayPaymentGatewayCardItem()),
                  Expanded(child: FlutterWavePaymentGatewayCardItem()),

                ]),



              Row(spacing: Dimensions.paddingSizeLarge, crossAxisAlignment: CrossAxisAlignment.start, children: [
                Expanded(child: PayStackPaymentGatewayCardItem()),
                Expanded(child: PaytmPaymentGatewayCardItem()),
              ]),



              Row(spacing: Dimensions.paddingSizeLarge,children: [
                Expanded(child: PaymobAcceptPaymentGatewayCardItem()),
                Expanded(child: SizedBox())
              ]),
              ],
            ):const Column(spacing: Dimensions.paddingSizeLarge, children: [

              StripePaymentGatewayCardItem(),
              SslCommerzPaymentGatewayCardItem(),

              PaypalPaymentGatewayCardItem(),
              SenangPayPaymentGatewayCardItem(),

              RazorPayPaymentGatewayCardItem(),
              FlutterWavePaymentGatewayCardItem(),



              PayStackPaymentGatewayCardItem(),
              PaytmPaymentGatewayCardItem(),


              PaymobAcceptPaymentGatewayCardItem(),
            ],
            ),
          ):  Center(child: Padding(padding: ThemeShadow.getPadding(), child: const CircularProgressIndicator())),
        ]);
      }
    );
  }
}

