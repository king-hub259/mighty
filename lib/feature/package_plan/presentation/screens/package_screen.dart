
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/common/widget/custom_floating_button.dart';
import 'package:mighty_school/feature/package_plan/presentation/screens/create_new_package_screen.dart';
import 'package:mighty_school/feature/package_plan/presentation/widgets/package_list_widget.dart';

class PackageScreen extends StatefulWidget {
  const PackageScreen({super.key});

  @override
  State<PackageScreen> createState() => _PackageScreenState();
}

class _PackageScreenState extends State<PackageScreen> {
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "packages".tr),
      body: CustomWebScrollView(controller: scrollController, slivers: [

        SliverToBoxAdapter(child: PackageListWidget(scrollController: scrollController))
      ]),

      floatingActionButton:  CustomFloatingButton(title: "add",
          onTap: ()=> Get.dialog(const CreateNewPackageScreen())));
  }
}



