import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/common/widget/sub_menu_item_widget.dart';
import 'package:mighty_school/feature/academic_configuration/class/presentation/screens/class_screen.dart';
import 'package:mighty_school/feature/academic_configuration/department/presentation/screens/department_screen.dart';
import 'package:mighty_school/feature/academic_configuration/group/presentation/screens/group_screen.dart';
import 'package:mighty_school/feature/academic_configuration/period/presentation/screens/period_screen.dart';
import 'package:mighty_school/feature/academic_configuration/picklist/presentation/screens/picklist_screen.dart';
import 'package:mighty_school/feature/academic_configuration/section/presentation/screens/section_screen.dart';
import 'package:mighty_school/feature/academic_configuration/session/presentation/screens/session_screen.dart';
import 'package:mighty_school/feature/academic_configuration/shift/presentation/screens/shift_screen.dart';
import 'package:mighty_school/feature/academic_configuration/signature/presentation/screens/signature_screen.dart';
import 'package:mighty_school/feature/academic_configuration/student_categories/presentation/screens/student_categories_screen.dart';
import 'package:mighty_school/feature/academic_configuration/subject/presentation/screens/subject_screen.dart';
import 'package:mighty_school/feature/exam_management/exam/presentation/screens/exam_screen.dart';
import 'package:mighty_school/feature/menu_section/controller/menu_type_controller.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/images.dart';


class AcademicConfigurationScreen extends StatefulWidget {
  const AcademicConfigurationScreen({super.key});

  @override
  State<AcademicConfigurationScreen> createState() => _AcademicConfigurationScreenState();
}

class _AcademicConfigurationScreenState extends State<AcademicConfigurationScreen> {
  List<MainMenuModel> studentInformationItems = [
    MainMenuModel(icon: Images.academicSession, title: 'academic_session', widget:  const SessionScreen()),
    MainMenuModel(icon: Images.shift, title: 'shift', widget:  const ShiftScreen()),
    MainMenuModel(icon: Images.classIcon, title: 'class', widget:  const ClassScreen()),
    MainMenuModel(icon: Images.section, title: 'section', widget:  const SectionScreen()),
    MainMenuModel(icon: Images.staff, title: 'group', widget:  const GroupScreen()),
    MainMenuModel(icon: Images.calender, title: 'period', widget:  const PeriodScreen()),
    MainMenuModel(icon: Images.subject, title: 'subjects', widget:  const SubjectScreen()),
    MainMenuModel(icon: Images.subject, title: 'subject_config', widget:  const SubjectScreen()),
    MainMenuModel(icon: Images.exam, title: 'exam', widget:  const ExamScreen()),
    MainMenuModel(icon: Images.student, title: 'student_categories', widget:  const StudentCategoriesScreen()),
    MainMenuModel(icon: Images.department, title: 'department', widget:  const DepartmentScreen()),
    MainMenuModel(icon: Images.pickList, title: 'picklist', widget:  const PickListScreen()),
    MainMenuModel(icon: Images.signature, title: 'principal_signature', widget:  const SignatureScreen()),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(title: "academic_configuration".tr,),
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
