import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/feature/library_management/book/presentation/widgets/book_issue_report_list_widget.dart';

class BookIssueReportScreen extends StatefulWidget {
  const BookIssueReportScreen({super.key});

  @override
  State<BookIssueReportScreen> createState() => _BookIssueReportScreenState();
}

class _BookIssueReportScreenState extends State<BookIssueReportScreen> {
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: CustomAppBar(title: "book_issue_report".tr),
      body: CustomWebScrollView(controller: scrollController, slivers: [
        SliverToBoxAdapter(child: BookIssueReportListWidget(scrollController: scrollController,))
      ]));
  }
}
