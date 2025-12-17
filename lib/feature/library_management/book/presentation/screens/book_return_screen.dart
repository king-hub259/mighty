import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/feature/library_management/book/presentation/widgets/book_return_widget.dart';

class BookReturnScreen extends StatefulWidget {
  const BookReturnScreen({super.key});

  @override
  State<BookReturnScreen> createState() => _BookReturnScreenState();
}

class _BookReturnScreenState extends State<BookReturnScreen> {
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: CustomAppBar(title: "book_return".tr),
      body: CustomWebScrollView(controller: scrollController, slivers: [
        SliverToBoxAdapter(child: BookReturnWidget(scrollController: scrollController,))
      ]));
  }
}
