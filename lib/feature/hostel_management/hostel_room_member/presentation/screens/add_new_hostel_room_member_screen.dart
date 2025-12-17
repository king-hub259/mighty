import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';

class AddNewHostelRoomMemberScreen extends StatelessWidget {
  const AddNewHostelRoomMemberScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "add_new_hostel_room_member".tr),
      body: Center(
        child: Text(
          'hostel_room_member_form_coming_soon'.tr,
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
