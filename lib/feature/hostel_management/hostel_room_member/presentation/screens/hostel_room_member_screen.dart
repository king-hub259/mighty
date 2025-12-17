import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/common/widget/custom_floating_button.dart';
import 'package:mighty_school/feature/hostel_management/hostel_room_member/presentation/screens/add_new_hostel_room_member_screen.dart';
import 'package:mighty_school/feature/hostel_management/hostel_room_member/presentation/widgets/hostel_room_member_list_widget.dart';
import 'package:mighty_school/util/dimensions.dart';

class HostelRoomMemberScreen extends StatefulWidget {
  const HostelRoomMemberScreen({super.key});

  @override
  State<HostelRoomMemberScreen> createState() => _HostelRoomMemberScreenState();
}

class _HostelRoomMemberScreenState extends State<HostelRoomMemberScreen> {
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "hostel_room_members".tr),
      body: const CustomWebScrollView(slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.all(Dimensions.paddingSizeDefault),
            child: HostelRoomMemberListWidget(),
          ),
        )
      ]),
      floatingActionButton: CustomFloatingButton(
        onTap: () => Get.to(() => const AddNewHostelRoomMemberScreen())
      ),
    );
  }
}