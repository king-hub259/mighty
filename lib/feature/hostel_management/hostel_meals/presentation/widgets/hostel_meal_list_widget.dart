import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/layout/list_layout_widget.dart';
import 'package:mighty_school/feature/hostel_management/hostel_meals/domain/model/hostel_meal_model.dart';
import 'package:mighty_school/feature/hostel_management/hostel_meals/logic/hostel_meals_controller.dart';
import 'package:mighty_school/feature/hostel_management/hostel_meals/presentation/widgets/hostel_meal_item_widget.dart';
import 'package:mighty_school/feature/hostel_management/hostel_members/presentation/screens/add_new_hostel_member_screen.dart';

class HostelMemberListWidget extends StatelessWidget {
  final ScrollController? scrollController;
  
  const HostelMemberListWidget({super.key, this.scrollController});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HostelMealsController>(
      initState: (val) {
        if(Get.find<HostelMealsController>().hostelMealModel == null){
          Get.find<HostelMealsController>().getHostelMeals(1);
        }
      },
      builder: (hostelMealController) {
        final mealModel = hostelMealController.hostelMealModel;
        final mealData = mealModel?.data;
        
        return GenericListSection<HostelMealItem>(
          sectionTitle: "hostel_management".tr,
          pathItems: ["hostel_meal".tr],
          addNewTitle: "add_new_hostel_meal".tr,
          onAddNewTap: () => Get.dialog(const AddNewHostelMemberScreen()),
          headings: const ["name", "type", "action"],
          scrollController: scrollController ?? ScrollController(),
          isLoading: mealData == null,
          totalSize:  mealData?.total??0,
          offset:  mealData?.currentPage??0,
          onPaginate: (offset) async => await hostelMealController.getHostelMeals(offset??1),
          
          items: mealData?.data ?? [],
          itemBuilder: (item, index) => HostelMealItemWidget(mealItem: item, index: index),
        );
      },
    );
  }
}
