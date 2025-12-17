import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/feature/account_management/journal/presentation/widgets/journal_widget.dart';

class JournalScreen extends StatefulWidget {
  const JournalScreen({super.key,});

  @override
  State<JournalScreen> createState() => _JournalScreenState();
}

class _JournalScreenState extends State<JournalScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "journal".tr),
      body: const CustomWebScrollView(slivers: [
        SliverToBoxAdapter(child: Column(children: [
          JournalWidget()
        ],),)
      ],),
    );
  }
}
