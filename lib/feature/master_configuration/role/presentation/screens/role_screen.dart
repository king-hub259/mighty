
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/common/widget/custom_floating_button.dart';
import 'package:mighty_school/feature/master_configuration/role/presentation/screens/create_new_role_screen.dart';
import 'package:mighty_school/feature/master_configuration/role/presentation/widgets/role_list_widget.dart';

class RoleManagementScreen extends StatefulWidget {
  const RoleManagementScreen({super.key});

  @override
  State<RoleManagementScreen> createState() => _RoleManagementScreenState();
}

class _RoleManagementScreenState extends State<RoleManagementScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "role".tr),
      body: const CustomWebScrollView(slivers: [
        SliverToBoxAdapter(child: RoleListWidget())
      ],),



      floatingActionButton: CustomFloatingButton(onTap:()=> Get.to(()=> const CreateNewRoleScreen()))
    );
  }
}



