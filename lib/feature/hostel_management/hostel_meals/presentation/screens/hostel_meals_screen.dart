import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/common/widget/custom_floating_button.dart';
import 'package:mighty_school/feature/hostel_management/hostel_meals/presentation/screens/add_new_hostel_meal_screen.dart';
import 'package:mighty_school/feature/hostel_management/hostel_meals/presentation/widgets/hostel_meal_list_widget.dart';
import 'package:mighty_school/util/dimensions.dart';

class HostelMealsScreen extends StatefulWidget {
  const HostelMealsScreen({super.key});

  @override
  State<HostelMealsScreen> createState() => _HostelMealsScreenState();
}

class _HostelMealsScreenState extends State<HostelMealsScreen> {
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "hostel_meals".tr),
      body: const CustomWebScrollView(slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.all(Dimensions.paddingSizeDefault),
            child: HostelMemberListWidget(),
          ),
        )
      ]),
      floatingActionButton: CustomFloatingButton(
        onTap: () => Get.dialog( const AddNewHostelMealScreen())
      ),
    );
  }
}