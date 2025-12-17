
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/layout/list_layout_widget.dart';
import 'package:mighty_school/feature/hostel_management/hostel_meal_plan/domain/model/hostel_meal_plan_model.dart';
import 'package:mighty_school/feature/hostel_management/hostel_meal_plan/logic/hostel_meal_plan_controller.dart';
import 'package:mighty_school/feature/hostel_management/hostel_meal_plan/presentation/widgets/hostel_meal_plan_widget.dart';
import 'package:mighty_school/feature/hostel_management/hostel_meals/domain/model/hostel_meal_model.dart';
import 'package:mighty_school/feature/hostel_management/hostel_meals/logic/hostel_meals_controller.dart';
import 'package:mighty_school/feature/hostel_management/hostel_meals/presentation/widgets/hostel_meal_item_widget.dart';
import 'package:mighty_school/feature/hostel_management/hostel_members/presentation/screens/add_new_hostel_member_screen.dart';

class HostelMealPlanListWidget extends StatelessWidget {
  final ScrollController? scrollController;

  const HostelMealPlanListWidget({super.key, this.scrollController});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HostelMealPlanController>(
      initState: (val) {
        if(Get.find<HostelMealPlanController>().hostelMealPlanModel == null){
          Get.find<HostelMealPlanController>().getHostelMealPlan(1);
        }
      },
      builder: (hostelMealController) {
        final mealModel = hostelMealController.hostelMealPlanModel;
        final mealData = mealModel?.data;

        return GenericListSection<HostelMealPlanItem>(
          sectionTitle: "hostel_management".tr,
          pathItems: ["hostel_meal_plan".tr],
          addNewTitle: "add_new_meal_plan".tr,
          onAddNewTap: () => Get.dialog(const AddNewHostelMemberScreen()),
          headings: const ["meal", "student", "action"],
          scrollController: scrollController ?? ScrollController(),
          isLoading: mealData == null,
          totalSize:  mealData?.total??0,
          offset:  mealData?.currentPage??0,
          onPaginate: (offset) async => await hostelMealController.getHostelMealPlan(offset??1),

          items: mealData?.data ?? [],
          itemBuilder: (item, index) => HostelMealPlanItemWidget(mealPlanItem: item, index: index),
        );
      },
    );
  }
}
