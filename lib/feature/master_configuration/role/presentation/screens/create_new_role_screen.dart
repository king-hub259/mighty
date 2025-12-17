import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/feature/master_configuration/role/domain/models/role_model.dart';
import 'package:mighty_school/feature/master_configuration/role/presentation/widgets/create_new_role_widget.dart';

class CreateNewRoleScreen extends StatefulWidget {
  final RoleItem? roleItem;
  const CreateNewRoleScreen({super.key, this.roleItem,  });

  @override
  State<CreateNewRoleScreen> createState() => _CreateNewRoleScreenState();
}

class _CreateNewRoleScreenState extends State<CreateNewRoleScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "create_new_role".tr,),
      body: CustomWebScrollView(slivers: [
        SliverToBoxAdapter(child: CreateNewRoleWidget(roleItem: widget.roleItem))
      ],),
    );
  }

}
