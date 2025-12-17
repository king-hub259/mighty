import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/common/widget/custom_floating_button.dart';
import 'package:mighty_school/feature/academic_configuration/class/presentation/screens/create_new_class_dialog.dart';
import 'package:mighty_school/feature/academic_configuration/class/presentation/widgets/class_list_widget.dart';
import 'package:mighty_school/helper/responsive_helper.dart';

class ClassScreen extends StatefulWidget {
  const ClassScreen({super.key});

  @override
  State<ClassScreen> createState() => _ClassScreenState();
}

class _ClassScreenState extends State<ClassScreen> {
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: ResponsiveHelper.isDesktop(context)? null : CustomAppBar(title: "class".tr),
    body: CustomWebScrollView(controller: scrollController, slivers:  [

      SliverToBoxAdapter(child: ClassListWidget(scrollController: scrollController,))
    ],),
      floatingActionButton: ResponsiveHelper.isDesktop(context)? const SizedBox() : CustomFloatingButton(title: "add", onTap: () => Get.dialog(const CreateNewClassScreen())));
  }
}
