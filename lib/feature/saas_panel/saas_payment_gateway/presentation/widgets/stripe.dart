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

class StripePaymentGatewayCardItem extends StatefulWidget {
  const StripePaymentGatewayCardItem({super.key});

  @override
  State<StripePaymentGatewayCardItem> createState() => _StripePaymentGatewayCardItemState();
}

class _StripePaymentGatewayCardItemState extends State<StripePaymentGatewayCardItem> {

  TextEditingController apiKeyController = TextEditingController();
  TextEditingController publishedKeyController = TextEditingController();

  @override
  void initState() {
    apiKeyController.text = Get.find<SaasPaymentGatewayController>().stripePaymentGatewayItem?.paymentInfo?.apiKey ?? "";
    publishedKeyController.text = Get.find<SaasPaymentGatewayController>().stripePaymentGatewayItem?.paymentInfo?.publishedKey ?? "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SaasPaymentGatewayController>(
      builder: (saasPaymentGatewayController) {
        PaymentGatewayItem? paymentGatewayItem = saasPaymentGatewayController.stripePaymentGatewayItem;
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

              const CustomImage( height: 50, image: Images.stripe, localAsset: true,),



              CustomTextField(title: "api_key".tr,
                controller: apiKeyController,
                hintText: paymentGatewayItem?.paymentInfo?.apiKey,),

              CustomTextField(title: "published_key".tr,
                controller: publishedKeyController,
                hintText: paymentGatewayItem?.paymentInfo?.publishedKey,),


              const SizedBox(height: Dimensions.paddingSizeDefault),

              Align(alignment: Alignment.centerRight, child: CustomButton(width: 100, onTap: (){
                String apiKey = apiKeyController.text.trim();
                String publishedKey = publishedKeyController.text.trim();
                if(apiKey.isEmpty) {
                  showCustomSnackBar("api_key_is_empty".tr);
                } else if(publishedKey.isEmpty) {
                  showCustomSnackBar("published_key_is_empty".tr);
                }else if(AppConstants.demo) {
                  showCustomSnackBar(AppConstants.demoModeMessage.tr);
                }
                else {

                  saasPaymentGatewayController.editSaasPaymentGateway(PaymentGatewayItem(id: paymentGatewayItem?.id,
                      status: paymentGatewayItem?.status,
                      paymentInfo: PaymentInfo(apiKey: apiKey, publishedKey: publishedKey),
                     ));
                }
              }, text: "Save"))
            ]));
      }
    );
  }
}
