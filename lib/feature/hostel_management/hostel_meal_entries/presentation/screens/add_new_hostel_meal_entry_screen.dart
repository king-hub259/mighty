import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/feature/hostel_management/hostel_meal_entries/domain/model/hostel_meal_entry_model.dart';

class AddNewHostelMealEntryScreen extends StatelessWidget {
  final HostelMealEntryItem? mealEntryItem;
  const AddNewHostelMealEntryScreen({super.key, this.mealEntryItem});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "add_new_hostel_meal_entry".tr),
      body: Center(
        child: Text(
          'hostel_meal_entry_form_coming_soon'.tr,
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
