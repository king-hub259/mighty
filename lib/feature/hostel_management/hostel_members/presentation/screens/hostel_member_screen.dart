import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/common/widget/custom_floating_button.dart';
import 'package:mighty_school/feature/hostel_management/hostel_members/presentation/screens/add_new_hostel_member_screen.dart';
import 'package:mighty_school/feature/hostel_management/hostel_members/presentation/widgets/hostel_member_list_widget.dart';
import 'package:mighty_school/util/dimensions.dart';

class HostelMemberScreen extends StatefulWidget {
  const HostelMemberScreen({super.key});

  @override
  State<HostelMemberScreen> createState() => _HostelMemberScreenState();
}

class _HostelMemberScreenState extends State<HostelMemberScreen> {
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: CustomAppBar(title: "hostel_members".tr),

      body: const CustomWebScrollView(slivers: [
        SliverToBoxAdapter(child: Padding(padding: EdgeInsets.all(Dimensions.paddingSizeDefault),
            child: HostelMemberListWidget()))
      ]),

      floatingActionButton: CustomFloatingButton(
        onTap: () => Get.to(() => const AddNewHostelMemberScreen())
      ),
    );
  }
}
