import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/common/widget/custom_button.dart';
import 'package:mighty_school/feature/payroll_management/advance/logic/advance_controller.dart';
import 'package:mighty_school/feature/payroll_management/advance/presentation/screens/create_advance_salary_screen.dart';
import 'package:mighty_school/feature/payroll_management/advance/presentation/widgets/advance_salary_list_widget.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';

class AdvanceSalaryScreen extends StatefulWidget {
  const AdvanceSalaryScreen({super.key});

  @override
  State<AdvanceSalaryScreen> createState() => _AdvanceSalaryScreenState();
}

class _AdvanceSalaryScreenState extends State<AdvanceSalaryScreen> {
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    Get.find<AdvanceController>().getAdvanceSalaryList(1);
    Get.find<AdvanceController>().getEmployeeList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "advance_salary".tr),
      body: CustomWebScrollView(controller: scrollController, slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "advance_salary_list".tr,
                  style: textMedium.copyWith(fontSize: Dimensions.fontSizeLarge),
                ),
                CustomButton(
                  onTap: () => Get.to(() => const CreateAdvanceSalaryScreen()),
                  text: "add_advance_salary".tr,
                  width: 180,
                  height: 40,
                ),
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: AdvanceSalaryListWidget(scrollController: scrollController),
        ),
      ]),
    );
  }
}
