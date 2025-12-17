import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';

class AddNewHostelBillScreen extends StatelessWidget {
  const AddNewHostelBillScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "add_new_hostel_bill".tr),
      body: Center(
        child: Text(
          'hostel_bill_form_coming_soon'.tr,
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
