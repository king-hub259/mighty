import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/feature/academic_configuration/department/presentation/screens/department_screen.dart';
import 'package:mighty_school/feature/master_configuration/employee/presentation/screens/employee_screen.dart';
import 'package:mighty_school/feature/hrm/leave_request/presentation/screens/leave_request_screen.dart';
import 'package:mighty_school/feature/hrm/leave_type/presentation/screens/leave_type_screen.dart';
import 'package:mighty_school/feature/hrm/payroll/presentation/screens/payroll_screen.dart';
import 'package:mighty_school/util/images.dart';

class HrmController extends GetxController implements GetxService{



  List<HrmDepartmentModel> hrmDepartmentList = [
    HrmDepartmentModel(icon: Images.department, title: "department", widget: const DepartmentScreen()),
    HrmDepartmentModel(icon: Images.employee, title: "employee", widget: const EmployeeScreen()),
    HrmDepartmentModel(icon: Images.payroll, title: "payroll", widget: const PayrollScreen()),
    HrmDepartmentModel(icon: Images.leave, title: "leave_type", widget: const LeaveTypeScreen()),
    HrmDepartmentModel(icon: Images.leaveApply, title: "leave_request", widget: const LeaveRequestScreen()),

  ];




}

class HrmDepartmentModel{
  final String icon;
  final String title;
  final Widget widget;
  HrmDepartmentModel( {required this.icon, required this.title, required this.widget});
}