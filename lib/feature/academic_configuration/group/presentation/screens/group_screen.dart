import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/common/widget/custom_floating_button.dart';
import 'package:mighty_school/feature/academic_configuration/group/presentation/widgets/create_new_group_dialog.dart';
import 'package:mighty_school/feature/academic_configuration/group/presentation/widgets/group_list_widget.dart';

class GroupScreen extends StatefulWidget {
  const GroupScreen({super.key});

  @override
  State<GroupScreen> createState() => _GroupScreenState();
}

class _GroupScreenState extends State<GroupScreen> {
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: CustomAppBar(title: "group".tr),
        body: CustomWebScrollView(controller: scrollController, slivers: [
          SliverToBoxAdapter(child: GroupListWidget(scrollController: scrollController,))
        ],),
        floatingActionButton: CustomFloatingButton(title: "add", onTap: ()=>Get.dialog(const CreateNewGroupDialog())));
  }
}
