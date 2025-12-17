import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/feature/library_management/library_member/presentation/widgets/library_member_list_widget.dart';

class LibraryMemberScreen extends StatefulWidget {
  const LibraryMemberScreen({super.key});

  @override
  State<LibraryMemberScreen> createState() => _LibraryMemberScreenState();
}

class _LibraryMemberScreenState extends State<LibraryMemberScreen> {
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: CustomAppBar(title: "library_member".tr),
    body: CustomWebScrollView(controller: scrollController, slivers: [

      SliverToBoxAdapter(child: LibraryMemberListWidget(scrollController: scrollController,))
    ]));
  }
}
