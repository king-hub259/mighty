import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_button.dart';
import 'package:mighty_school/feature/digital_payment/domain/models/digital_payment_body.dart';
import 'package:mighty_school/feature/digital_payment/logic/digital_payment_controller.dart';
import 'package:mighty_school/feature/institute/controller/institute_controller.dart';
import 'package:mighty_school/feature/landing_page/logic/landing_page_controller.dart';
import 'package:mighty_school/feature/landing_page/presentation/widgets/package_pricing_widget.dart';
import 'package:mighty_school/feature/saas_panel/saas_payment_gateway/logic/saas_payment_gateway_controller.dart';
import 'package:mighty_school/feature/saas_panel/saas_payment_gateway/presentation/widgets/select_payment_type_widget.dart';
import 'package:mighty_school/helper/route_helper.dart';
import 'package:mighty_school/util/app_constants.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:universal_html/html.dart' as html;

class PurchaseSubscriptionPlanWidget extends StatelessWidget {
  const PurchaseSubscriptionPlanWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LandingPageController>(
      builder: (packageController) {
        return GetBuilder<InstituteController>(
          builder: (instituteController) {
            return GetBuilder<DigitalPaymentController>(
              builder: (digitalPaymentController) {
                return GetBuilder<SaasPaymentGatewayController>(
                  builder: (paymentGatewayController) {
                    return Dialog(shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(Dimensions.radiusSmall))),
                        child: Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                          child: Column(mainAxisSize: MainAxisSize.min, spacing: Dimensions.paddingSizeSmall,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const PackagePricingWidget(),
                              const SelectPaymentTypeWidget(),
                              const SizedBox(height: Dimensions.paddingSizeDefault),
                              Align(alignment: Alignment.centerRight, child: CustomButton(width: 120, onTap: (){
                                int instituteId = instituteController.onboardingModel!.data!.user!.instituteId!;
                                String? hostname = html.window.location.hostname;
                                String protocol = html.window.location.protocol;
                                String callbackUrl = '$protocol//$hostname${RouteHelper.getDashboardRoute()}';
                                DigitalPaymentBody body = DigitalPaymentBody(
                                  paymentMethod: "${paymentGatewayController.selectedPaymentType}",
                                  paymentType: "subscription_payment",
                                  paymentPlatform: "web",
                                  planId: packageController.selectedPackageItem?.id.toString(),
                                  amount: packageController.selectedPackageItem?.price,
                                  currency: AppConstants.currency,
                                  externalRedirectLink: callbackUrl,
                                  successHook: callbackUrl,
                                  failureHook: callbackUrl,
                                  name: instituteController.instituteBodyModel?.userName,
                                  phone: instituteController.instituteBodyModel?.userPhone,
                                  email: instituteController.instituteBodyModel?.userEmail,

                                );
                                if(packageController.selectedPackageItem?.price == 0){
                                  instituteController.updateSubscriptionPlan(packageController.selectedPackageItem!.id!, instituteId);
                                }else{
                                  digitalPaymentController.makeDigitalPayment(body);
                                }


                              }, text: "confirm".tr))

                            ],
                          ),
                        ));
                  }
                );
              }
            );
          }
        );
      }
    );
  }
}
