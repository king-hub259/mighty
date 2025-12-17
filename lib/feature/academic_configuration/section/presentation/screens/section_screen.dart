
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/common/widget/custom_floating_button.dart';
import 'package:mighty_school/feature/academic_configuration/class/presentation/widgets/select_class_widget.dart';
import 'package:mighty_school/feature/academic_configuration/section/presentation/screens/create_new_section_screen.dart';
import 'package:mighty_school/feature/academic_configuration/section/presentation/widgets/section_list_widget.dart';

class SectionScreen extends StatefulWidget {
  const SectionScreen({super.key});

  @override
  State<SectionScreen> createState() => _SectionScreenState();
}

class _SectionScreenState extends State<SectionScreen> {
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "section".tr),
      body: CustomWebScrollView(controller: scrollController, slivers: [

        SliverToBoxAdapter(child: Column(
          children: [
            const SelectClassWidget(),
            SectionListWidget(scrollController: scrollController),
          ],
        ),)
      ],),

      floatingActionButton: CustomFloatingButton(title: "add", onTap: ()=> Get.to(()=> const CreateNewSectionScreen()))
    );
  }
}



