
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/common/widget/custom_floating_button.dart';
import 'package:mighty_school/feature/academic_configuration/shift/presentation/screens/create_new_shift_screen.dart';
import 'package:mighty_school/feature/academic_configuration/shift/presentation/widgets/shift_list_widget.dart';

class ShiftScreen extends StatefulWidget {
  const ShiftScreen({super.key});

  @override
  State<ShiftScreen> createState() => _ShiftScreenState();
}

class _ShiftScreenState extends State<ShiftScreen> {
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "shift".tr),
      body: CustomWebScrollView(controller: scrollController, slivers: [
      SliverToBoxAdapter(child: ShiftListWidget(scrollController: scrollController))
      ],),

      floatingActionButton: CustomFloatingButton(title: "add", onTap: ()=> Get.dialog(const CreateNewShiftScreen())));
  }
}



