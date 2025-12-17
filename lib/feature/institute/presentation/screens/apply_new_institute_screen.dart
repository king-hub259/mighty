import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/feature/branch/domain/models/branch_model.dart';
import 'package:mighty_school/feature/institute/presentation/widgets/apply_for_institute_widget.dart';

class ApplyNewInstituteScreen extends StatefulWidget {
  final BranchItem? branchItem;
  const ApplyNewInstituteScreen({super.key, this.branchItem});

  @override
  State<ApplyNewInstituteScreen> createState() => _ApplyNewInstituteScreenState();
}

class _ApplyNewInstituteScreenState extends State<ApplyNewInstituteScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: CustomAppBar(title: "apply".tr),
      body: const CustomScrollView( slivers: [
        SliverToBoxAdapter(child: ApplyForInstituteWidget())
      ],));
  }
}
