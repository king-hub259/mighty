import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/feature/hostel_management/hostel_meals/domain/model/hostel_meal_model.dart';

class AddNewHostelMealScreen extends StatelessWidget {
  final HostelMealItem? item;
  const AddNewHostelMealScreen({super.key, this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "add_new_hostel_meal".tr),
      body: Center(
        child: Text(
          'hostel_meal_form_coming_soon'.tr,
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
