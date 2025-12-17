
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/feature/fees_management/waiver/presentation/widgets/fine_waiver_widget.dart';

class FineWaiverScreen extends StatefulWidget {
  const FineWaiverScreen({super.key});

  @override
  State<FineWaiverScreen> createState() => _FineWaiverScreenState();
}

class _FineWaiverScreenState extends State<FineWaiverScreen> {
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "fine_waiver".tr),
      body: CustomWebScrollView(controller: scrollController, slivers: const [
        SliverToBoxAdapter(child: FineWaiverWidget())
      ],),
    );
  }
}



