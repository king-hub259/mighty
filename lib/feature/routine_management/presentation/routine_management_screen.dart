import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/common/widget/sub_menu_item_widget.dart';
import 'package:mighty_school/feature/menu_section/controller/menu_type_controller.dart';
import 'package:mighty_school/feature/routine_management/admit_and_seat_plan/presentation/screens/admit_card_and_sear_plan_screen.dart';
import 'package:mighty_school/feature/routine_management/assignment/presentation/screens/assignment_screen.dart';
import 'package:mighty_school/feature/routine_management/class_routine/presentation/screens/class_routine_screen.dart';
import 'package:mighty_school/feature/routine_management/exam_routine/presentation/screens/exam_routine_screen.dart';
import 'package:mighty_school/feature/routine_management/syllabus/presentation/screens/syllabus_screen.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/images.dart';


class RoutineManagementScreen extends StatefulWidget {
  const RoutineManagementScreen({super.key});

  @override
  State<RoutineManagementScreen> createState() => _RoutineManagementScreenState();
}

class _RoutineManagementScreenState extends State<RoutineManagementScreen> {
  List<MainMenuModel> studentInformationItems = [
    MainMenuModel(icon: Images.syllabus, title: 'syllabus', widget:  const SyllabusScreen()),
    MainMenuModel(icon: Images.productReturn, title: 'assignments', widget:  const AssignmentScreen()),
    MainMenuModel(icon: Images.productReturn, title: 'class_routine', widget:  const ClassRoutineScreen()),
    MainMenuModel(icon: Images.productReturn, title: 'exam_routine', widget:  const ExamRoutineScreen()),
    MainMenuModel(icon: Images.productReturn, title: 'admit_and_seat_plan', widget:  const AdmitAndSeatPlanScreen()),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(title: "routine_management".tr,),
        body: CustomWebScrollView(slivers: [
          SliverToBoxAdapter(child:Padding(padding: const EdgeInsets.only(top: Dimensions.paddingSizeDefault),
            child: ListView.builder(
                itemCount: studentInformationItems.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                itemBuilder: (context, index){
                  return InkWell(onTap: ()=> Get.to(studentInformationItems[index].widget),
                      child: SubMenuItemWidget(icon: studentInformationItems[index].icon, title: studentInformationItems[index].title)
                  );
                }),
          ),)
        ],)
    );
  }
}
