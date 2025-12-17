import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/feature/third_party/logic/third_party_controller.dart';
import 'package:mighty_school/feature/third_party/widgets/live_class_setup_widget.dart';
import 'package:mighty_school/feature/third_party/widgets/payment_gateway_setup_widget.dart';
import 'package:mighty_school/feature/third_party/widgets/sms_gateway_setup_widget.dart';
import 'package:mighty_school/feature/third_party/widgets/third_party_selection_widget.dart';
import 'package:mighty_school/util/dimensions.dart';

class ThirdPartyScreen extends StatelessWidget {
  const ThirdPartyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  CustomAppBar(title: "third_party".tr),
      body: CustomWebScrollView(slivers: [

        SliverToBoxAdapter(child: GetBuilder<ThirdPartyController>(
          builder: (thirdPartyController) {
            return Padding(
              padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
              child: Column(children: [
                const ThirdPartySelectionWidget(),
                if(thirdPartyController.thirdPartyType == 0)
                  const LiveClassSetupWidget(),

                if(thirdPartyController.thirdPartyType == 1)
                  const PaymentGatewaySetupWidget(),

                if(thirdPartyController.thirdPartyType == 2)
                  const SmsGatewaySetupWidget()
              ]),
            );
          }
        ))
      ]),
    );
  }
}
