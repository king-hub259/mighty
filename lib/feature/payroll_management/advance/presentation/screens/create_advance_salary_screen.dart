import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/common/widget/custom_button.dart';
import 'package:mighty_school/common/widget/custom_dropdown.dart';
import 'package:mighty_school/common/widget/custom_text_field.dart';
import 'package:mighty_school/feature/payroll_management/advance/domain/models/advance_salary_model.dart';
import 'package:mighty_school/feature/payroll_management/advance/logic/advance_controller.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';

class CreateAdvanceSalaryScreen extends StatefulWidget {
  final AdvanceSalaryItem? advanceSalaryItem;
  
  const CreateAdvanceSalaryScreen({super.key, this.advanceSalaryItem});

  @override
  State<CreateAdvanceSalaryScreen> createState() => _CreateAdvanceSalaryScreenState();
}

class _CreateAdvanceSalaryScreenState extends State<CreateAdvanceSalaryScreen> {
  ScrollController scrollController = ScrollController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isUpdate = false;

  @override
  void initState() {
    super.initState();
    isUpdate = widget.advanceSalaryItem != null;
    if (isUpdate) {
      Get.find<AdvanceController>().fillForm(widget.advanceSalaryItem!);
    } else {
      Get.find<AdvanceController>().clearForm();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: isUpdate ? "update_advance_salary".tr : "create_advance_salary".tr,
      ),
      body: CustomWebScrollView(
        controller: scrollController,
        slivers: [
          SliverToBoxAdapter(
            child: GetBuilder<AdvanceController>(
              builder: (controller) {
                return Padding(
                  padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "advance_salary_information".tr,
                          style: textMedium.copyWith(
                            fontSize: Dimensions.fontSizeLarge,
                          ),
                        ),
                        const SizedBox(height: Dimensions.paddingSizeLarge),
                        
                        CustomDropdown(
                          title: "employee".tr,
                          items: const [],
                          selectedValue: "",
                          onChanged: (value) {

                          },


                        ),
                        const SizedBox(height: Dimensions.paddingSizeDefault),
                        
                        CustomTextField(
                          controller: controller.amountController,
                          hintText: "enter_amount".tr,
                          title: "amount".tr,
                          isRequired: true,
                          inputType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "amount_is_required".tr;
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: Dimensions.paddingSizeDefault),
                        
                        CustomTextField(
                          controller: controller.reasonController,
                          hintText: "enter_reason".tr,
                          title: "reason".tr,
                          isRequired: true,
                          maxLines: 3,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "reason_is_required".tr;
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: Dimensions.paddingSizeDefault),
                        
                        InkWell(
                          onTap: () => controller.setSelectDate(context),
                          child: Container(
                            padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                            decoration: BoxDecoration(
                              border: Border.all(color: Theme.of(context).dividerColor),
                              borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  controller.formatedDate,
                                  style: textRegular.copyWith(
                                    fontSize: Dimensions.fontSizeDefault,
                                  ),
                                ),
                                const Icon(Icons.calendar_today),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: Dimensions.paddingSizeDefault),
                        

                        CustomTextField(
                          controller: controller.notesController,
                          hintText: "enter_notes".tr,
                          title: "notes".tr,
                          maxLines: 3,
                        ),
                        const SizedBox(height: Dimensions.paddingSizeLarge),
                        
                        CustomButton(
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              String amount = controller.amountController.text.trim();
                              String reason = controller.reasonController.text.trim();
                              String notes = controller.notesController.text.trim();
                              
                              if (controller.selectedEmployee == null) {
                                Get.snackbar("error".tr, "employee_is_required".tr);
                                return;
                              }

                              AdvanceSalaryBody advanceSalaryBody = AdvanceSalaryBody(
                                employeeId: controller.selectedEmployee!.id.toString(),
                                amount: amount,
                                reason: reason,
                                requestDate: controller.formatedDate,
                                status: controller.selectedStatus,
                                notes: notes,
                              );

                              if (isUpdate) {
                                controller.editAdvanceSalary(
                                  advanceSalaryBody,
                                  widget.advanceSalaryItem!.id!,
                                );
                              } else {
                                controller.createAdvanceSalary(advanceSalaryBody);
                              }
                            }
                          },
                          text: isUpdate ? "update".tr : "save".tr,
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
