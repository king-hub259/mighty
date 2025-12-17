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

class SslCommerzPaymentGatewayCardItem extends StatefulWidget {
  const SslCommerzPaymentGatewayCardItem({super.key});

  @override
  State<SslCommerzPaymentGatewayCardItem> createState() => _SslCommerzPaymentGatewayCardItemState();
}

class _SslCommerzPaymentGatewayCardItemState extends State<SslCommerzPaymentGatewayCardItem> {
  TextEditingController storeIdController = TextEditingController();
  TextEditingController storePasswordController = TextEditingController();

  @override
  void initState() {
    storeIdController.text = Get.find<SaasPaymentGatewayController>().sslCommerzPaymentGatewayItem?.paymentInfo?.storeId ?? "";
    storePasswordController.text = Get.find<SaasPaymentGatewayController>().sslCommerzPaymentGatewayItem?.paymentInfo?.storePassword ?? "";
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return GetBuilder<SaasPaymentGatewayController>(
      builder: (saasPaymentGatewayController) {
        PaymentGatewayItem? paymentGatewayItem = saasPaymentGatewayController.sslCommerzPaymentGatewayItem;
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

              const CustomImage( height: 50, image: Images.sslCommerz, localAsset: true,),


              CustomTextField(title: "store_id".tr,
                controller: storeIdController,
                hintText: paymentGatewayItem?.paymentInfo?.storeId,),

              CustomTextField(title: "store_password".tr,
                controller: storePasswordController,
                hintText: paymentGatewayItem?.paymentInfo?.storePassword,),



              const SizedBox(height: Dimensions.paddingSizeDefault),

              Align(alignment: Alignment.centerRight, child: CustomButton(width: 100, onTap: (){
                String storeId = storeIdController.text.trim();
                String storePassword = storePasswordController.text.trim();

                if(storeId.isEmpty) {
                  showCustomSnackBar("store_id_is_empty".tr);
                } else if(storePassword.isEmpty) {
                  showCustomSnackBar("store_password_is_empty".tr);
                } else if(AppConstants.demo) {
                  showCustomSnackBar(AppConstants.demoModeMessage.tr);
                }else {
                  saasPaymentGatewayController.editSaasPaymentGateway(PaymentGatewayItem(id: paymentGatewayItem?.id,
                      name: paymentGatewayItem?.name,
                      status: paymentGatewayItem?.status,
                      paymentInfo: PaymentInfo(storeId: storeId, storePassword: storePassword)));
                }
              }, text: "Save"))
            ]));
      }
    );
  }
}
