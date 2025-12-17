import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/feature/fees_management/fees_date/presentation/widgets/fee_date_config_list_widget.dart';

class FeeDateConfigScreen extends StatefulWidget {
  const FeeDateConfigScreen({super.key});

  @override
  State<FeeDateConfigScreen> createState() => _FeeDateConfigScreenState();
}

class _FeeDateConfigScreenState extends State<FeeDateConfigScreen> {
  ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "fee_date_config".tr),
      body: CustomScrollView(controller: scrollController, slivers: [
        SliverToBoxAdapter(child: FeeDateConfigListWidget(scrollController: scrollController,))
      ],),
    );
  }
}
