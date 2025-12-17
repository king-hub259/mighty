import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/common/widget/sub_menu_item_widget.dart';
import 'package:mighty_school/feature/menu_section/controller/menu_type_controller.dart';
import 'package:mighty_school/feature/hostel_management/hostel/presentation/screens/hostel_screen.dart';
import 'package:mighty_school/feature/hostel_management/hostel_categories/presentation/screens/hostel_category_screen.dart';
import 'package:mighty_school/feature/hostel_management/hostel_members/presentation/screens/hostel_member_screen.dart';
import 'package:mighty_school/feature/hostel_management/hostel_rooms/presentation/screens/hostel_rooms_screen.dart';
import 'package:mighty_school/feature/hostel_management/hostel_meals/presentation/screens/hostel_meals_screen.dart';
import 'package:mighty_school/feature/hostel_management/hostel_bill/presentation/screens/hostel_bill_screen.dart';
import 'package:mighty_school/feature/hostel_management/hostel_meal_plan/presentation/screens/hostel_meal_plan_screen.dart';
import 'package:mighty_school/feature/hostel_management/hostel_meal_entries/presentation/screens/hostel_meal_entries_screen.dart';
import 'package:mighty_school/feature/hostel_management/hostel_room_member/presentation/screens/hostel_room_member_screen.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/images.dart';

class HostelManagementScreen extends StatefulWidget {
  const HostelManagementScreen({super.key});

  @override
  State<HostelManagementScreen> createState() => _HostelManagementScreenState();
}

class _HostelManagementScreenState extends State<HostelManagementScreen> {
  List<MainMenuModel> hostelManagementItems = [
    MainMenuModel(icon: Images.student, title: 'hostels', widget: const HostelScreen()),
    MainMenuModel(icon: Images.category, title: 'hostel_categories', widget: const HostelCategoryScreen()),
    MainMenuModel(icon: Images.student, title: 'hostel_rooms', widget: const HostelRoomsScreen()),
    MainMenuModel(icon: Images.student, title: 'hostel_members', widget: const HostelMemberScreen()),
    MainMenuModel(icon: Images.student, title: 'hostel_room_members', widget:  HostelRoomMemberScreen()),
    MainMenuModel(icon: Images.student, title: 'hostel_meals', widget: const HostelMealsScreen()),
    MainMenuModel(icon: Images.calender, title: 'hostel_meal_plan', widget: const HostelMealPlanScreen()),
    MainMenuModel(icon: Images.student, title: 'hostel_meal_entries', widget: const HostelMealEntriesScreen()),
    MainMenuModel(icon: Images.pay, title: 'hostel_bills', widget: const HostelBillScreen()),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(title: "hostel_management".tr,),
        body: CustomWebScrollView(slivers: [
          SliverToBoxAdapter(child:Padding(padding: const EdgeInsets.only(top: Dimensions.paddingSizeDefault),
            child: ListView.builder(
                itemCount: hostelManagementItems.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                itemBuilder: (context, index){
                  return InkWell(onTap: ()=> Get.to(hostelManagementItems[index].widget),
                      child: SubMenuItemWidget(icon: hostelManagementItems[index].icon, title: hostelManagementItems[index].title)
                  );
                }),
          ),)
        ],)
    );
  }
}
