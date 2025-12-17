import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/feature/account_management/contra/presentation/widgets/conta_widget.dart';

class ContraScreen extends StatefulWidget {
  const ContraScreen({super.key});

  @override
  State<ContraScreen> createState() => _ContraScreenState();
}

class _ContraScreenState extends State<ContraScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "contra".tr),
      body: const CustomWebScrollView(slivers: [
        SliverToBoxAdapter(child: Column(children: [
          ContraWidget()
        ]))
      ]),
    );
  }
}
