import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/common/widget/sub_menu_item_widget.dart';
import 'package:mighty_school/feature/menu_section/controller/menu_type_controller.dart';
import 'package:mighty_school/feature/payroll_management/advance/presentation/screens/advance_salary_screen.dart';
import 'package:mighty_school/feature/payroll_management/due/presentation/screens/due_salary_screen.dart';
import 'package:mighty_school/feature/payroll_management/payroll_assign/presentation/screens/payroll_assign_screen.dart';
import 'package:mighty_school/feature/payroll_management/payroll_mapping/presentation/screens/payroll_mapping_screen.dart';
import 'package:mighty_school/feature/payroll_management/payroll_start_up/presentation/screens/payroll_start_up_screen.dart';
import 'package:mighty_school/feature/payroll_management/return_advance/presentation/screens/return_advance_screen.dart';
import 'package:mighty_school/feature/payroll_management/salary/presentation/screens/salary_screen.dart';
import 'package:mighty_school/feature/payroll_management/salary_slip/presentation/screens/salary_slip_screen.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/images.dart';

class PayrollManagementScreen extends StatefulWidget {
  const PayrollManagementScreen({super.key});

  @override
  State<PayrollManagementScreen> createState() => _PayrollManagementScreenState();
}

class _PayrollManagementScreenState extends State<PayrollManagementScreen> {
  List<MainMenuModel> payrollManagementItems = [
    MainMenuModel(icon: Images.settings, title: 'salary_head_setup', widget: const PayrollStartUpScreen()),
    MainMenuModel(icon: Images.payroll, title: 'payroll_mapping', widget: const PayrollMappingScreen()),
    MainMenuModel(icon: Images.payroll, title: 'payroll_assign', widget: const PayrollAssignScreen()),
    MainMenuModel(icon: Images.payroll, title: 'salary_processing', widget: const SalaryScreen()),
    MainMenuModel(icon: Images.payroll, title: 'advance_salary', widget: const AdvanceSalaryScreen()),
    MainMenuModel(icon: Images.payroll, title: 'due_salary', widget: const DueSalaryScreen()),
    MainMenuModel(icon: Images.payroll, title: 'return_advance', widget: const ReturnAdvanceScreen()),
    MainMenuModel(icon: Images.payroll, title: 'salary_slip', widget: const SalarySlipScreen()),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(title: "payroll_management".tr,),
        body: CustomWebScrollView(slivers: [
          SliverToBoxAdapter(child:Padding(padding: const EdgeInsets.only(top: Dimensions.paddingSizeDefault),
            child: ListView.builder(
                itemCount: payrollManagementItems.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                itemBuilder: (context, index){
                  return InkWell(onTap: ()=> Get.to(payrollManagementItems[index].widget),
                      child: SubMenuItemWidget(icon: payrollManagementItems[index].icon, title: payrollManagementItems[index].title)
                  );
                }),
          ),)
        ],)
    );
  }
}


