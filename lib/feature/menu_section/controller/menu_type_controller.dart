import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mighty_school/feature/academic_configuration/presentation/academic_configuration_screen.dart';
import 'package:mighty_school/feature/account_management/presentation/account_managment_screen.dart';
import 'package:mighty_school/feature/administrator/presentation/administration_screen.dart';
import 'package:mighty_school/feature/exam_management/presentation/exam_management_screen.dart';
import 'package:mighty_school/feature/fees_management/presentation/fees_managment_screen.dart';
import 'package:mighty_school/feature/library_management/presentation/library_management_screen.dart';
import 'package:mighty_school/feature/master_configuration/presentation/master_configuration_screen.dart';
import 'package:mighty_school/feature/payroll_management/presentation/payroll_management_screen.dart';
import 'package:mighty_school/feature/quiz/presentation/quiz_screen.dart';
import 'package:mighty_school/feature/reports_management/accounting_reports/presentation/screens/accounting_reports_screen.dart';
import 'package:mighty_school/feature/reports_management/fees_reports/presentation/screens/fees_reports_screen.dart';
import 'package:mighty_school/feature/routine_management/presentation/routine_management_screen.dart';
import 'package:mighty_school/feature/sms/presentation/sms_management_screen.dart';
import 'package:mighty_school/feature/staff_information/presentation/staff_information_screen.dart';
import 'package:mighty_school/feature/student_attendance_information/presentation/student_attenance_information_screen.dart';
import 'package:mighty_school/feature/students_information/presentation/student_information_screen.dart';
import 'package:mighty_school/util/images.dart';

class MenuTypeController extends GetxController implements GetxService{
  List<MainMenuModel> mainItem = [
    MainMenuModel(icon: Images.student, title: 'student_information', widget: const StudentInformationScreen()),
    MainMenuModel(icon: Images.staff, title: 'staff_information', widget: const StaffInformationScreen()),
    MainMenuModel(icon: Images.student, title: 'student_attendance_information', widget: const StudentAttendanceInformationScreen()),
    MainMenuModel(icon: Images.academicSession, title: 'academic_configuration', widget: const AcademicConfigurationScreen()),
    MainMenuModel(icon: Images.fine, title: 'fees_management', widget: const FeesManagementScreen()),
    MainMenuModel(icon: Images.accounting, title: 'account_management', widget: const AccountManagementScreen()),
    MainMenuModel(icon: Images.routine, title: 'routine_management', widget: const RoutineManagementScreen()),
    MainMenuModel(icon: Images.library, title: 'library_management', widget: const LibraryManagementScreen()),
    MainMenuModel(icon: Images.exam, title: 'exam_management', widget: const ExamManagementScreen()),
    MainMenuModel(icon: Images.sms, title: 'sms_management', widget:  const SmsManagementScreen()),
    MainMenuModel(icon: Images.administrator, title: 'administrator', widget:  const AdministrationScreen()),
    MainMenuModel(icon: Images.quiz, title: 'quiz', widget:  const QuizScreen()),
    MainMenuModel(icon: Images.masterConfig, title: 'master_configuration', widget:  const MasterConfigurationScreen()),
    MainMenuModel(icon: Images.report, title: 'accounting_report', widget:  const AccountingReportsScreen()),
    MainMenuModel(icon: Images.report, title: 'fees_report', widget:  const FeesReportsScreen()),
    MainMenuModel(icon: Images.payroll, title: 'payroll_management', widget:  const PayrollManagementScreen()),

  ];



}

class MainMenuModel{
  final String icon;
  final String title;
  final Widget widget;
  MainMenuModel({required this.icon, required this.title, required this.widget});
}