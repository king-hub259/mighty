import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/common/widget/sub_menu_item_widget.dart';
import 'package:mighty_school/feature/menu_section/controller/menu_type_controller.dart';
import 'package:mighty_school/feature/staff_information/staff/presentation/screens/staff_screen.dart';
import 'package:mighty_school/feature/staff_information/staff_attendance/presentation/screens/add_new_staff_attendance_screen.dart';
import 'package:mighty_school/feature/staff_information/teacher/presentation/screens/teacher_screen.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/images.dart';


class StaffInformationScreen extends StatefulWidget {
  const StaffInformationScreen({super.key});

  @override
  State<StaffInformationScreen> createState() => _StaffInformationScreenState();
}

class _StaffInformationScreenState extends State<StaffInformationScreen> {
  List<MainMenuModel> staffInformationItems = [
    MainMenuModel(icon: Images.staff, title: 'staff_attendance', widget:  const AddNewStaffAttendanceScreen()),
    MainMenuModel(icon: Images.staff, title: 'teacher_list', widget:  const TeacherScreen()),
    MainMenuModel(icon: Images.staff, title: 'staff_list', widget:  const StaffScreen()),

  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(title: "staff_information".tr,),
        body: CustomWebScrollView(slivers: [
          SliverToBoxAdapter(child:Padding(padding: const EdgeInsets.only(top: Dimensions.paddingSizeDefault),
            child: ListView.builder(
                itemCount: staffInformationItems.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                itemBuilder: (context, index){
                  return InkWell(onTap: ()=> Get.to(staffInformationItems[index].widget),
                      child: SubMenuItemWidget(icon: staffInformationItems[index].icon, title: staffInformationItems[index].title)
                  );
                }),
          ),)
        ],)
    );
  }
}
