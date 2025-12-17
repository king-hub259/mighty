
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/feature/layout_and_certificate/enum/certificate_type_enum.dart';
import 'package:mighty_school/feature/layout_and_certificate/presentation/widgets/certificate_and_letter_widget.dart';
import 'package:mighty_school/feature/id_card/presentation/widgets/id_card_widget.dart';

class LayoutAndCertificateScreen extends StatefulWidget {
  final CertificateTypeEnum type;
  const LayoutAndCertificateScreen({super.key, required this.type});

  @override
  State<LayoutAndCertificateScreen> createState() => _LayoutAndCertificateScreenState();
}

class _LayoutAndCertificateScreenState extends State<LayoutAndCertificateScreen> {
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: CustomAppBar(title: "certificate".tr),
      body: CustomWebScrollView(controller: scrollController, slivers: [

        SliverToBoxAdapter(child: GeneralRecommendationLetter(type: widget.type,))
      ],),
    );
  }
}



