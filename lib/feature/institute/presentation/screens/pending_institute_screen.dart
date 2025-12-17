
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/feature/institute/presentation/widgets/pending_institute_list_widget.dart';

class PendingInstituteScreen extends StatefulWidget {
  const PendingInstituteScreen({super.key});

  @override
  State<PendingInstituteScreen> createState() => _PendingInstituteScreenState();
}

class _PendingInstituteScreenState extends State<PendingInstituteScreen> {
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: CustomAppBar(title: "pending_institute_list".tr),
      body: CustomWebScrollView(controller: scrollController, slivers: [

        SliverToBoxAdapter(child: PendingInstituteListWidget(scrollController: scrollController,))
      ]),
    );
  }
}



