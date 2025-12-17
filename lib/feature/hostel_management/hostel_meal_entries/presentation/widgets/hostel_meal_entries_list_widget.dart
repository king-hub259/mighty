
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/layout/list_layout_widget.dart';
import 'package:mighty_school/feature/hostel_management/hostel_meal_entries/domain/model/hostel_meal_entry_model.dart';
import 'package:mighty_school/feature/hostel_management/hostel_meal_entries/logic/hostel_meal_entries_controller.dart';
import 'package:mighty_school/feature/hostel_management/hostel_meal_entries/presentation/widgets/hostel_meal_entries_widget.dart';
import 'package:mighty_school/feature/hostel_management/hostel_members/presentation/screens/add_new_hostel_member_screen.dart';

class HostelMealEntriesListWidget extends StatelessWidget {
  final ScrollController? scrollController;

  const HostelMealEntriesListWidget({super.key, this.scrollController});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HostelMealEntriesController>(
      initState: (val) {
        if(Get.find<HostelMealEntriesController>().mealEntryModel == null){
          Get.find<HostelMealEntriesController>().getHostelMealEntries(1);
        }
      },
      builder: (hostelMealController) {
        final mealModel = hostelMealController.mealEntryModel;
        final mealData = mealModel?.data;
        return GenericListSection<HostelMealEntryItem>(
          sectionTitle: "hostel_management".tr,
          pathItems: ["hostel_meal_entries".tr],
          addNewTitle: "add_new_hostel_meal_entries".tr,
          onAddNewTap: () => Get.dialog(const AddNewHostelMemberScreen()),
          headings: const ["name", "price","student", "action"],
          scrollController: scrollController ?? ScrollController(),
          isLoading: mealData == null,
          totalSize:  mealData?.total??0,
          offset:  mealData?.currentPage??0,
          onPaginate: (offset) async => await hostelMealController.getHostelMealEntries(offset??1),
          items: mealData?.data ?? [],
          itemBuilder: (item, index) => HostelMealEntriesItemWidget(mealEntryItem: item, index: index),
        );
      },
    );
  }
}
