import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/feature/administrator/system_settings/controller/system_settngs_controller.dart';
import 'package:mighty_school/feature/administrator/system_settings/presentation/widgets/payment_gateway_card_widget.dart';
import 'package:mighty_school/util/dimensions.dart';


class PaymentSettingsScreen extends StatelessWidget {
  const PaymentSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SystemSettingsController>(
      builder: (systemSettingsController) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(spacing: Dimensions.paddingSizeSmall, children: [
              Expanded(
                child: PaymentGatewaySettings(
                  title: "stripe",
                  isEnabled: false,
                  onToggle: () {},
                  privateKeyController: TextEditingController(),
                  publicKeyController: TextEditingController(),
                  gatewayTitleController: TextEditingController(text: "stripe"),
                ),
              ),

              Expanded(
                child: PaymentGatewaySettings(
                  title: "razorpay",
                  isEnabled: false,
                  onToggle: () {},
                  privateKeyController: TextEditingController(),
                  publicKeyController: TextEditingController(),
                  gatewayTitleController: TextEditingController(text: "razorpay"),
                ),
              ),
            ],
          ),
        );
      }
    );
  }
}

