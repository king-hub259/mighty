import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/common/widget/custom_snackbar.dart';
import 'package:mighty_school/feature/hrm/payroll/controller/payroll_controller.dart';
import 'package:mighty_school/feature/payroll_management/salary/logic/salary_controller.dart';
import 'package:mighty_school/feature/payroll_management/salary/presentation/widgets/salary_list_widget.dart';
import 'package:mighty_school/feature/reports_management/fees_reports/presentation/widgets/select_year_and_month_widget.dart';

class SalaryScreen extends StatefulWidget {
  const SalaryScreen({super.key});

  @override
  State<SalaryScreen> createState() => _SalaryScreenState();
}

class _SalaryScreenState extends State<SalaryScreen> {
  ScrollController scrollController = ScrollController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "salary_processing".tr),
      body: CustomWebScrollView(controller: scrollController, slivers: [
        SliverToBoxAdapter(
          child: Column(mainAxisSize: MainAxisSize.min,
            children: [
              GetBuilder<PayrollController>(
                builder: (payrollController) {
                  String? year = payrollController.selectedYear;
                  String? month = payrollController.selectedMonth;
                  return SelectYearAndMonthWidget(onTap: (){
                    if(year == null || month == null) {
                      showCustomSnackBar( "select_year_and_month".tr);
                      return;
                    }
                    Get.find<SalaryController>().getSalaryList(month, year);
                  });
                }
              ),
              SalaryListWidget(scrollController: scrollController),
            ],
          ),
        ),
      ]),
    );
  }
}