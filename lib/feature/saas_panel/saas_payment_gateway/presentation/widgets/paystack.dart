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

class PayStackPaymentGatewayCardItem extends StatefulWidget {
  const PayStackPaymentGatewayCardItem({super.key});

  @override
  State<PayStackPaymentGatewayCardItem> createState() => _PayStackPaymentGatewayCardItemState();
}

class _PayStackPaymentGatewayCardItemState extends State<PayStackPaymentGatewayCardItem> {


  TextEditingController publicKeyController = TextEditingController();
  TextEditingController secretKeyController = TextEditingController();
  TextEditingController merchantEmailController = TextEditingController();
  TextEditingController callBackUrlController = TextEditingController();


  @override
  void initState() {
    publicKeyController.text = Get.find<SaasPaymentGatewayController>().payStackPaymentGatewayItem?.paymentInfo?.publicKey ?? "";
    secretKeyController.text = Get.find<SaasPaymentGatewayController>().payStackPaymentGatewayItem?.paymentInfo?.secretKey ?? "";
    merchantEmailController.text = Get.find<SaasPaymentGatewayController>().payStackPaymentGatewayItem?.paymentInfo?.merchantEmail ?? "";
    callBackUrlController.text = Get.find<SaasPaymentGatewayController>().payStackPaymentGatewayItem?.paymentInfo?.callbackUrl ?? "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SaasPaymentGatewayController>(
      builder: (saasPaymentGatewayController) {
        PaymentGatewayItem? paymentGatewayItem = saasPaymentGatewayController.payStackPaymentGatewayItem;
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

              const CustomImage( height: 30, image: Images.payStack, localAsset: true,),


              CustomTextField(title: "public_key".tr,
                controller: publicKeyController,
                hintText: paymentGatewayItem?.paymentInfo?.publicKey,),

              CustomTextField(title: "secret_key".tr,
                controller: secretKeyController,
                hintText: paymentGatewayItem?.paymentInfo?.secretKey,),



              CustomTextField(title: "merchant_email".tr,
                controller: merchantEmailController,
                hintText: paymentGatewayItem?.paymentInfo?.merchantEmail,),

              CustomTextField(title: "call_back_url".tr,
                controller: callBackUrlController,
                hintText: paymentGatewayItem?.paymentInfo?.callbackUrl),



              const SizedBox(height: Dimensions.paddingSizeDefault),

              Align(alignment: Alignment.centerRight, child: CustomButton(width: 100, onTap: (){
                String publicKey = publicKeyController.text.trim();
                String secretKey = secretKeyController.text.trim();
                String merchantEmail = merchantEmailController.text.trim();
                if(publicKey.isEmpty){
                  showCustomSnackBar("public_key".tr);
                }
                else if(secretKey.isEmpty){
                  showCustomSnackBar("secret_key".tr);
                }
                else if(merchantEmail.isEmpty){
                  showCustomSnackBar("merchant_email".tr);
                }else if(AppConstants.demo) {
                  showCustomSnackBar(AppConstants.demoModeMessage.tr);
                }
                else{
                  saasPaymentGatewayController.editSaasPaymentGateway(PaymentGatewayItem(id: paymentGatewayItem?.id,
                      status: paymentGatewayItem?.status,
                      name: paymentGatewayItem?.name,
                      paymentInfo: PaymentInfo(publicKey: publicKey, secretKey: secretKey, merchantEmail: merchantEmail, callbackUrl: callBackUrlController.text.trim())));
                }
              }, text: "Save"))
            ]));
      }
    );
  }
}
