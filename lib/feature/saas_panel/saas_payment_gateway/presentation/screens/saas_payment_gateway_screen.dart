import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/feature/saas_panel/saas_payment_gateway/presentation/screens/saas_payment_gateway_widget.dart';
import 'package:mighty_school/util/dimensions.dart';

class SaasPaymentGatewayScreen extends StatefulWidget {
  const SaasPaymentGatewayScreen({super.key});

  @override
  State<SaasPaymentGatewayScreen> createState() => _SaasPaymentGatewayScreenState();
}

class _SaasPaymentGatewayScreenState extends State<SaasPaymentGatewayScreen> {
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: CustomAppBar(title: "payment_gateway".tr),
        body: const CustomWebScrollView(slivers: [

          SliverToBoxAdapter(child: Padding(padding: EdgeInsets.all(Dimensions.paddingSizeDefault),
            child: SaasPaymentGatewayWidget(),
          ),)
        ],),

    );
  }
}
