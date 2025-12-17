import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/common/widget/custom_floating_button.dart';
import 'package:mighty_school/feature/hostel_management/hostel_rooms/presentation/screens/add_new_hostel_room_screen.dart';
import 'package:mighty_school/feature/hostel_management/hostel_rooms/presentation/widgets/hostel_rooms_widget.dart';
import 'package:mighty_school/util/dimensions.dart';

class HostelRoomsScreen extends StatefulWidget {
  const HostelRoomsScreen({super.key});

  @override
  State<HostelRoomsScreen> createState() => _HostelRoomsScreenState();
}

class _HostelRoomsScreenState extends State<HostelRoomsScreen> {
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "hostel_rooms".tr),
      body: const CustomWebScrollView(slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.all(Dimensions.paddingSizeDefault),
            child: HostelRoomsListWidget(),
          ),
        )
      ]),
      floatingActionButton: CustomFloatingButton(
        onTap: () => Get.to(() => const AddNewHostelRoomScreen())
      ),
    );
  }
}