import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/feature/administrator/system_settings/controller/system_settngs_controller.dart';
import 'package:mighty_school/feature/administrator/system_settings/presentation/widgets/payment_gateway_card_widget.dart';
import 'package:mighty_school/util/dimensions.dart';


class SmsGatewayConfigWidget extends StatelessWidget {
  const SmsGatewayConfigWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SystemSettingsController>(
      builder: (systemSettingsController) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(spacing: Dimensions.paddingSizeSmall, children: [
              Expanded(
                child: PaymentGatewaySettings(
                  title: "twilio",
                  isEnabled: false,
                  onToggle: () {},
                  privateKeyController: TextEditingController(),
                  publicKeyController: TextEditingController(),
                  gatewayTitleController: TextEditingController(text: "stripe"),
                ),
              ),


            ],
          ),
        );
      }
    );
  }
}

