import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/feature/report/presentation/screens/web_report_screen.dart';

class ReportDashboardScreen extends StatefulWidget {
  const ReportDashboardScreen({super.key});

  @override
  State<ReportDashboardScreen> createState() => _ReportDashboardScreenState();
}

class _ReportDashboardScreenState extends State<ReportDashboardScreen> {
  ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "dashboard".tr),
      body: CustomWebScrollView(slivers: [
        SliverToBoxAdapter(child: Column(children: [
         WebReportScreen(scrollController: scrollController),
        ],),)
      ],),
    );
  }
}
