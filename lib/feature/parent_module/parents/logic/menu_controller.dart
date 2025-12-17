import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:mighty_school/helper/route_helper.dart';

class ParentMenuController extends GetxController implements GetxService {



  List<MenuItemModel> menuItems = [
    MenuItemModel(title: "profile", icon: Icons.person, route: RouteHelper.getParentProfileRoute()),
    MenuItemModel(title: "library", icon: Icons.school, route: RouteHelper.getParentLibraryRoute()),
    MenuItemModel(title: "assignment", icon: Icons.assignment, route: RouteHelper.getParentAssignmentRoute()),
    MenuItemModel(title: "behavior", icon: Icons.local_activity, route: RouteHelper.getParentBehaviourRoute()),
    MenuItemModel(title: "notice", icon: Icons.spoke, route: RouteHelper.getParentNoticeRoute()),
    MenuItemModel(title: "event", icon: Icons.event, route: RouteHelper.getParentEventRoute()),
    MenuItemModel(title: "exams", icon: Icons.accessible_rounded, route: RouteHelper.getParentExamRoute()),
    // MenuItemModel(title: "logout", icon: Icons.exit_to_app_outlined, route: RouteHelper.getSettingRoute()),
  ];


  // MainMenuModel(icon: Images.report, title: 'report', widget: const ReportDashboardScreen()),
  // MainMenuModel(icon: Images.student, title: 'student_information', widget: const StudentInformationScreen()),
  // MainMenuModel(icon: Images.staff, title: 'staff_information', widget: const StaffInformationScreen()),
  // MainMenuModel(icon: Images.student, title: 'student_attendance_information', widget: const StudentAttendanceInformationScreen()),
  // MainMenuModel(icon: Images.academicSession, title: 'academic_configuration', widget: const AcademicConfigurationScreen()),
  // MainMenuModel(icon: Images.fine, title: 'fees_management', widget: const FeesManagementScreen()),
  // MainMenuModel(icon: Images.accounting, title: 'account_management', widget: const AccountManagementScreen()),
  // MainMenuModel(icon: Images.routine, title: 'routine_management', widget: const RoutineManagementScreen()),
  // MainMenuModel(icon: Images.library, title: 'library_management', widget: const LibraryManagementScreen()),
  // MainMenuModel(icon: Images.exam, title: 'exam_management', widget: const ExamManagementScreen()),
  // MainMenuModel(icon: Images.sms, title: 'sms_management', widget:  const SmsManagementScreen()),
  // MainMenuModel(icon: Images.administrator, title: 'administrator', widget:  const AdministrationScreen()),
  // MainMenuModel(icon: Images.quiz, title: 'quiz', widget:  const QuizScreen()),
  // MainMenuModel(icon: Images.masterConfig, title: 'master_configuration', widget:  const MasterConfigurationScreen()),



  List<MenuItemModel> superAdminMenuItems = [
    MenuItemModel(title: "profile", icon: Icons.person, route: RouteHelper.getProfileRoute()),
     MenuItemModel(title: "student_information", icon: Icons.school, route: RouteHelper.getStudentInformationRoute()),
    MenuItemModel(title: "staff_information", icon: Icons.people, route: RouteHelper.getStaffInformationRoute()),
    MenuItemModel(title: "student_attendance_information", icon: Icons.check_circle, route: RouteHelper.getStudentAttendanceInformationRoute()),
    MenuItemModel(title: "academic_configuration", icon: Icons.school_outlined, route: RouteHelper.getAcademicConfigurationRoute()),
    MenuItemModel(title: "fees_management", icon: Icons.attach_money, route: RouteHelper.getFeesManagementRoute()),
    MenuItemModel(title: "account_management", icon: Icons.account_balance, route: RouteHelper.getAccountManagementRoute()),
    MenuItemModel(title: "account_reports", icon: Icons.account_balance, route: RouteHelper.getAccountingReportsRoute()),
    MenuItemModel(title: "fees_reports", icon: Icons.account_balance, route: RouteHelper.getFeesReportsRoute()),
    MenuItemModel(title: "routine_management", icon: Icons.schedule, route: RouteHelper.getRoutineManagementRoute()),
    MenuItemModel(title: "library_management", icon: Icons.library_books, route: RouteHelper.getLibraryManagementRoute()),
    MenuItemModel(title: "exam_management", icon: Icons.assignment, route: RouteHelper.getExamManagementRoute()),
    MenuItemModel(title: "sms_management", icon: Icons.sms, route: RouteHelper.getSmsManagementRoute()),
    MenuItemModel(title: "administrator", icon: Icons.admin_panel_settings, route: RouteHelper.getAdministrationRoute()),
    MenuItemModel(title: "quiz", icon: Icons.quiz, route: RouteHelper.getQuizRoute()),
    MenuItemModel(title: "payroll", icon: Icons.payments, route: RouteHelper.getPayrollManagementRoute()),
    MenuItemModel(title: "hostel_management", icon: Icons.home, route: RouteHelper.getHostelManagementRoute()),
    MenuItemModel(title: "master_configuration", icon: Icons.settings, route: RouteHelper.getMasterConfigurationRoute()),

  ];


}

class MenuItemModel {
  final String title;
  final IconData icon;
  final String? route;

  MenuItemModel( {
    required this.title,
    required this.icon,
    this.route,
  });
}