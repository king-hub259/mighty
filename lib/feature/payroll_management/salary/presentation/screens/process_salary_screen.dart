import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/common/widget/custom_button.dart';
import 'package:mighty_school/feature/payroll_management/salary/logic/salary_controller.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';

class ProcessSalaryScreen extends StatefulWidget {
  const ProcessSalaryScreen({super.key});

  @override
  State<ProcessSalaryScreen> createState() => _ProcessSalaryScreenState();
}

class _ProcessSalaryScreenState extends State<ProcessSalaryScreen> {
  ScrollController scrollController = ScrollController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    Get.find<SalaryController>().clearForm();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "process_salary".tr),
      body: CustomWebScrollView(
        controller: scrollController,
        slivers: [
          SliverToBoxAdapter(
            child: GetBuilder<SalaryController>(
              builder: (controller) {
                return Padding(
                  padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "salary_processing_information".tr,
                          style: textMedium.copyWith(
                            fontSize: Dimensions.fontSizeLarge,
                          ),
                        ),
                        const SizedBox(height: Dimensions.paddingSizeLarge),
                        

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "select_employees".tr,
                              style: textMedium.copyWith(
                                fontSize: Dimensions.fontSizeLarge,
                              ),
                            ),
                            Row(
                              children: [
                                TextButton(
                                  onPressed: () => controller.selectAllEmployees(),
                                  child: Text("select_all".tr),
                                ),
                                TextButton(
                                  onPressed: () => controller.clearEmployeeSelection(),
                                  child: Text("clear_all".tr),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: Dimensions.paddingSizeDefault),
                        
                        if (controller.employeeModel?.data?.data != null)
                          Container(
                            height: 300,
                            decoration: BoxDecoration(
                              border: Border.all(color: Theme.of(context).dividerColor),
                              borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                            ),
                            child: ListView.builder(
                              itemCount: controller.employeeModel!.data!.data!.length,
                              itemBuilder: (context, index) {
                                final employee = controller.employeeModel!.data!.data![index];
                                final isSelected = controller.selectedEmployees.contains(employee);
                                
                                return CheckboxListTile(
                                  title: const Text("${''} ${ ''}"),
                                  subtitle: Text(employee.email ?? ''),
                                  value: isSelected,
                                  onChanged: (bool? value) {
                                    controller.toggleEmployeeSelection(employee);
                                  },
                                );
                              },
                            ),
                          ),
                        
                        const SizedBox(height: Dimensions.paddingSizeLarge),
                        
                        if (controller.selectedEmployees.isNotEmpty)
                          Container(
                            padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                            decoration: BoxDecoration(
                              color: Theme.of(context).cardColor,
                              borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                              border: Border.all(color: Theme.of(context).dividerColor),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${"selected_employees".tr} (${controller.selectedEmployees.length})",
                                  style: textMedium.copyWith(
                                    fontSize: Dimensions.fontSizeDefault,
                                  ),
                                ),
                                const SizedBox(height: Dimensions.paddingSizeSmall),
                                Wrap(
                                  spacing: 8,
                                  runSpacing: 8,
                                  children: controller.selectedEmployees.map((employee) {
                                    return Chip(
                                      label: const Text(""),
                                      onDeleted: () => controller.toggleEmployeeSelection(employee),
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
                          ),
                        
                        const SizedBox(height: Dimensions.paddingSizeLarge),
                        
                        CustomButton(
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              if (controller.selectedEmployees.isEmpty) {
                                Get.snackbar("error".tr, "please_select_at_least_one_employee".tr);
                                return;
                              }

                              List<int> employeeIds = controller.selectedEmployees
                                  .map((e) => e.id!)
                                  .toList();

                              controller.processSalary(
                                controller.selectedMonth!,
                                controller.selectedYear!,
                                employeeIds,
                              );
                            }
                          },
                          text: "process_salary".tr,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
