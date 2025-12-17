import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/common/widget/sub_menu_item_widget.dart';
import 'package:mighty_school/feature/menu_section/controller/menu_type_controller.dart';
import 'package:mighty_school/feature/student_attendance_information/student_attendance/presentation/screens/add_new_studnt_attendance_screen.dart';
import 'package:mighty_school/feature/students_information/student/presentation/screens/all_student_screen.dart';
import 'package:mighty_school/feature/students_information/student_migration/presentation/screens/migration_list_screen.dart';
import 'package:mighty_school/feature/students_information/student_migration/presentation/screens/student_migration_screen.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/images.dart';


class StudentAttendanceInformationScreen extends StatefulWidget {
  const StudentAttendanceInformationScreen({super.key});

  @override
  State<StudentAttendanceInformationScreen> createState() => _StudentAttendanceInformationScreenState();
}

class _StudentAttendanceInformationScreenState extends State<StudentAttendanceInformationScreen> {
  List<MainMenuModel> studentInformationItems = [
    MainMenuModel(icon: Images.student, title: 'student_attendance', widget:  const AddNewStudentAttendanceScreen()),
    MainMenuModel(icon: Images.student, title: 'exam_attendance', widget:  const StudentMigrationScreen()),
    MainMenuModel(icon: Images.student, title: 'exam_schedule', widget:  const StudentMigrationScreen()),
    MainMenuModel(icon: Images.student, title: 'attendance_report', widget:  const StudentMigrationListScreen()),
    MainMenuModel(icon: Images.student, title: 'absent_fine', widget:  const AllStudentScreen()),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(title: "student_information".tr,),
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
