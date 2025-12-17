import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_button.dart';
import 'package:mighty_school/common/widget/custom_contaner.dart';
import 'package:mighty_school/common/widget/custom_divider.dart';
import 'package:mighty_school/common/widget/custom_image.dart';
import 'package:mighty_school/common/widget/custom_snackbar.dart';
import 'package:mighty_school/common/widget/custom_text_field.dart';
import 'package:mighty_school/feature/saas_panel/saas_payment_gateway/domain/model/saas_payment_gateway_model.dart';
import 'package:mighty_school/feature/saas_panel/saas_payment_gateway/logic/saas_payment_gateway_controller.dart';
import 'package:mighty_school/util/app_constants.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/images.dart';
import 'package:mighty_school/util/styles.dart';

class PaymobAcceptPaymentGatewayCardItem extends StatefulWidget {
  const PaymobAcceptPaymentGatewayCardItem({super.key});

  @override
  State<PaymobAcceptPaymentGatewayCardItem> createState() => _PaymobAcceptPaymentGatewayCardItemState();
}

class _PaymobAcceptPaymentGatewayCardItemState extends State<PaymobAcceptPaymentGatewayCardItem> {

  TextEditingController apiKeyController = TextEditingController();
  TextEditingController integrationIdController = TextEditingController();
  TextEditingController iframeIdController = TextEditingController();
  TextEditingController hmacSecretController = TextEditingController();
  TextEditingController paymentGatewayTitleController = TextEditingController();
  TextEditingController supportedCountryController = TextEditingController();


  @override
  void initState() {
    apiKeyController.text = Get.find<SaasPaymentGatewayController>().paymobAcceptPaymentGatewayItem?.paymentInfo?.apiKey ?? "";
    integrationIdController.text = Get.find<SaasPaymentGatewayController>().paymobAcceptPaymentGatewayItem?.paymentInfo?.integrationId ?? "";
    iframeIdController.text = Get.find<SaasPaymentGatewayController>().paymobAcceptPaymentGatewayItem?.paymentInfo?.iframeId ?? "";
    hmacSecretController.text = Get.find<SaasPaymentGatewayController>().paymobAcceptPaymentGatewayItem?.paymentInfo?.hmacSecret ?? "";
    paymentGatewayTitleController.text = Get.find<SaasPaymentGatewayController>().paymobAcceptPaymentGatewayItem?.name ?? "";
    supportedCountryController.text = Get.find<SaasPaymentGatewayController>().paymobAcceptPaymentGatewayItem?.paymentInfo?.supportedCountry ?? "";
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SaasPaymentGatewayController>(
      builder: (saasPaymentGatewayController) {
        PaymentGatewayItem? paymentGatewayItem = saasPaymentGatewayController.paymobAcceptPaymentGatewayItem;
        return CustomContainer(borderRadius: Dimensions.radiusSmall,
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, spacing: Dimensions.paddingSizeExtraSmall, children: [
              Row(children: [
                Expanded(child: Text('${paymentGatewayItem?.name?.toUpperCase().replaceAll("_", " ")}', style: textMedium.copyWith(fontSize: Dimensions.fontSizeLarge),)),
                Switch(inactiveThumbColor: Theme.of(context).hintColor,
                    hoverColor: Theme.of(context).primaryColor,
                    inactiveTrackColor: Theme.of(context).hintColor.withValues(alpha: 0.3),
                    value: paymentGatewayItem?.status == "1", onChanged: (onChanged){})
              ]),
              const Padding(padding: EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
                  child: CustomDivider()),

               const CustomImage( height: 50, image: Images.payMob, localAsset: true),

              CustomTextField(title: "api_key".tr,
                controller: apiKeyController,
                hintText: paymentGatewayItem?.paymentInfo?.accessToken,),

              CustomTextField(title: "integration_id".tr,
                controller: integrationIdController,
                hintText: paymentGatewayItem?.paymentInfo?.clientId,),

              CustomTextField(title: "iframe_id".tr,
                controller: iframeIdController,
                hintText: paymentGatewayItem?.paymentInfo?.clientSecret,),

              CustomTextField(title: "hmac_secret".tr,
                controller: hmacSecretController,
                hintText: paymentGatewayItem?.paymentInfo?.apiKey,),

              CustomTextField(title: "supported_country".tr,
                controller: supportedCountryController,
                hintText: paymentGatewayItem?.paymentInfo?.publishedKey,),


              CustomTextField(title: "payment_gateway_title".tr,
                controller: paymentGatewayTitleController,
                hintText: paymentGatewayItem?.name,),

              const SizedBox(height: Dimensions.paddingSizeDefault),

              Align(alignment: Alignment.centerRight, child: CustomButton(width: 100, onTap: (){
                String apiKey = apiKeyController.text.trim();
                String integrationId = integrationIdController.text.trim();
                String iframeId = iframeIdController.text.trim();
                String hmacSecret = hmacSecretController.text.trim();
                String paymentGatewayTitle = paymentGatewayTitleController.text.trim();
                String supportedCountry = supportedCountryController.text.trim();

                if(apiKey.isEmpty){
                  showCustomSnackBar("api_key_is_empty".tr);
                }
                else if(integrationId.isEmpty){
                  showCustomSnackBar("integration_id_is_empty".tr);
                }
                else if(iframeId.isEmpty){
                  showCustomSnackBar("iframe_id_is_empty".tr);
                }
                else if(hmacSecret.isEmpty){
                  showCustomSnackBar("hmac_secret_is_empty".tr);
                }
                else if(paymentGatewayTitle.isEmpty){
                  showCustomSnackBar("payment_gateway_title_is_empty".tr);
                }
                else if(supportedCountry.isEmpty){
                  showCustomSnackBar("supported_country_is_empty".tr);
                }else if(AppConstants.demo) {
                  showCustomSnackBar(AppConstants.demoModeMessage.tr);
                }
                else {
                  // saasPaymentGatewayController.updatePaymobAcceptPaymentGateway(apiKey, integrationId, iframeId, hmacSecret, paymentGatewayTitle, supportedCountry);
                }
              }, text: "Save"))
            ]));
      }
    );
  }
}
