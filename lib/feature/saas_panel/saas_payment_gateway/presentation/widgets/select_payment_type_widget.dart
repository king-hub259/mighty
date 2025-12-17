import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_contaner.dart';
import 'package:mighty_school/feature/saas_panel/saas_payment_gateway/domain/model/saas_payment_gateway_model.dart';
import 'package:mighty_school/feature/saas_panel/saas_payment_gateway/logic/saas_payment_gateway_controller.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';

class SelectPaymentTypeWidget extends StatelessWidget {
  const SelectPaymentTypeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SaasPaymentGatewayController>(
      initState: (val) => Get.find<SaasPaymentGatewayController>().getSaasPaymentGateway(),
      builder: (paymentGatewayController) {
        SaasPaymentGatewayModel? saasPaymentGatewayModel = paymentGatewayController.saasPaymentGatewayModel;
        return saasPaymentGatewayModel != null? SizedBox(height: 50,
          child: ListView.builder(
            itemCount: saasPaymentGatewayModel.data?.length,
            shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index){
            return InkWell(onTap: ()=> paymentGatewayController.selectPaymentType(index, saasPaymentGatewayModel.data?[index].name??''),
              child: Padding(padding: const EdgeInsets.fromLTRB(2,2,10,2),
                child: CustomContainer(borderRadius: 5, verticalPadding: 0, showShadow: false,
                  border: Border.all(color: paymentGatewayController.selectedIndex == index? Theme.of(context).primaryColor : Theme.of(context).hintColor),
                  child: IntrinsicWidth(
                    child: Row(spacing: Dimensions.paddingSizeSmall, mainAxisAlignment: MainAxisAlignment.center, children: [
                       Icon(color: paymentGatewayController.selectedIndex == index? Theme.of(context).primaryColor : Theme.of(context).hintColor,
                           paymentGatewayController.selectedIndex == index? Icons.radio_button_checked : Icons.radio_button_off),

                      Text('${saasPaymentGatewayModel.data?[index].name?.toUpperCase().replaceAll("_", " ")}', style: textMedium.copyWith(fontSize: Dimensions.fontSizeDefault)),
                    ],
                    ),
                  ),
                ),
              ),
            );
          }),
        ):const SizedBox();
      }
    );
  }
}
