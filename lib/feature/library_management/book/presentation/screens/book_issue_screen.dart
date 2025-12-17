import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/feature/library_management/book/presentation/widgets/book_issue_widget.dart';

class BookIssueScreen extends StatefulWidget {
  const BookIssueScreen({super.key});

  @override
  State<BookIssueScreen> createState() => _BookIssueScreenState();
}

class _BookIssueScreenState extends State<BookIssueScreen> {
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: CustomAppBar(title: "book".tr),
      body: CustomWebScrollView(controller: scrollController, slivers: const [
        SliverToBoxAdapter(child: BookIssueWidget())
      ]));
  }
}
