import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_item_text_widget.dart';
import 'package:mighty_school/common/widget/edit_delete_section.dart';
import 'package:mighty_school/common/widget/numbering_widget.dart';
import 'package:mighty_school/feature/hostel_management/hostel_meal_entries/domain/model/hostel_meal_entry_model.dart';
import 'package:mighty_school/feature/hostel_management/hostel_meal_entries/presentation/screens/add_new_hostel_meal_entry_screen.dart';
import 'package:mighty_school/feature/hostel_management/hostel_meals/domain/model/hostel_meal_model.dart';
import 'package:mighty_school/feature/hostel_management/hostel_meals/logic/hostel_meals_controller.dart';
import 'package:mighty_school/feature/hostel_management/hostel_meals/presentation/screens/add_new_hostel_meal_screen.dart';
import 'package:mighty_school/feature/hostel_management/hostel_members/presentation/screens/add_new_hostel_member_screen.dart';
import 'package:mighty_school/util/dimensions.dart';

class HostelMealEntriesItemWidget extends StatelessWidget {
  final HostelMealEntryItem mealEntryItem;
  final int index;

  const HostelMealEntriesItemWidget({super.key, required this.mealEntryItem, required this.index});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HostelMealsController>(builder: (mealController) {
      return  _buildDesktopView(context, mealController);
    },
    );
  }

  Widget _buildDesktopView(BuildContext context, HostelMealsController mealController) {
    return Row(spacing: Dimensions.paddingSizeDefault, children: [
      NumberingWidget(index: index),

      Expanded(child: CustomItemTextWidget(text: mealEntryItem.meal?.mealName ?? '')),
      Expanded(child: CustomItemTextWidget(text: mealEntryItem.mealPrice ?? '')),
      Expanded(child: CustomItemTextWidget(text: mealEntryItem.student?.firstName ?? '')),

      EditDeleteSection(horizontal: true,
        onEdit: () => Get.dialog(AddNewHostelMealEntryScreen(mealEntryItem: mealEntryItem)),
        onDelete: () => mealController.deleteHostelMeals(mealEntryItem.id!),
      ),
    ],
    );
  }

}
