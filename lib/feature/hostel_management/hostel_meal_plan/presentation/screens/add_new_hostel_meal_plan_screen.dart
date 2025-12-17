import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/feature/hostel_management/hostel_meal_plan/domain/model/hostel_meal_plan_model.dart';

class AddNewHostelMealPlanScreen extends StatelessWidget {
  final HostelMealPlanItem? mealPlanItem;
  const AddNewHostelMealPlanScreen({super.key, this.mealPlanItem});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "add_new_hostel_meal_plan".tr),
      body: Center(
        child: Text(
          'hostel_meal_plan_form_coming_soon'.tr,
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
