
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/common/widget/custom_floating_button.dart';
import 'package:mighty_school/feature/academic_configuration/picklist/presentation/screens/create_new_picklist_screen.dart';
import 'package:mighty_school/feature/academic_configuration/picklist/presentation/widgets/pick_list_widget.dart';

class PickListScreen extends StatefulWidget {
  const PickListScreen({super.key});
  @override
  State<PickListScreen> createState() => _PickListScreenState();
}

class _PickListScreenState extends State<PickListScreen> {
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: CustomAppBar(title: "picklist".tr),
      body: CustomWebScrollView(controller: scrollController, slivers: [
        SliverToBoxAdapter(child: PickListWidget(scrollController: scrollController))
      ],),


      floatingActionButton: CustomFloatingButton(onTap: ()=> Get.dialog(const CreateNewPickListScreen()))
    );
  }
}



