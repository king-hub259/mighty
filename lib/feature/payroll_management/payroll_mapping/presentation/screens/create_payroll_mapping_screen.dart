import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/common/widget/custom_button.dart';
import 'package:mighty_school/common/widget/custom_snackbar.dart';
import 'package:mighty_school/common/widget/custom_text_field.dart';
import 'package:mighty_school/feature/payroll_management/payroll_mapping/domain/model/payroll_mapping_body.dart';
import 'package:mighty_school/feature/payroll_management/payroll_mapping/domain/models/payroll_mapping_model.dart';
import 'package:mighty_school/feature/payroll_management/payroll_mapping/logic/payroll_mapping_controller.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';

class CreatePayrollMappingScreen extends StatefulWidget {
  final PayrollMappingItem? payrollMappingItem;
  
  const CreatePayrollMappingScreen({super.key, this.payrollMappingItem});

  @override
  State<CreatePayrollMappingScreen> createState() => _CreatePayrollMappingScreenState();
}

class _CreatePayrollMappingScreenState extends State<CreatePayrollMappingScreen> {
  ScrollController scrollController = ScrollController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isUpdate = false;

  @override
  void initState() {
    super.initState();
    isUpdate = widget.payrollMappingItem != null;
    if (isUpdate) {
      Get.find<PayrollMappingController>().fillForm(widget.payrollMappingItem!);
    } else {
      Get.find<PayrollMappingController>().clearForm();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: isUpdate ? "update_payroll_mapping".tr : "create_payroll_mapping".tr,),
      body: CustomWebScrollView(
        controller: scrollController,
        slivers: [
          SliverToBoxAdapter(
            child: GetBuilder<PayrollMappingController>(
              builder: (controller) {
                return Padding(
                  padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "payroll_mapping_information".tr,
                          style: textMedium.copyWith(
                            fontSize: Dimensions.fontSizeLarge,
                          ),
                        ),
                        const SizedBox(height: Dimensions.paddingSizeLarge),
                        


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
                        

                        CustomButton(
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              //String amount = controller.amountController.text.trim();
                              
                              if (controller.selectedEmployee == null) {
                                showCustomSnackBar("employee_is_required".tr);
                                return;
                              }
                              if (controller.selectedSalaryHead == null) {
                                showCustomSnackBar("salary_head_is_required".tr);
                                return;
                              }

                              PayrollMappingBody payrollMappingBody = PayrollMappingBody(

                              );

                              if (isUpdate) {
                                controller.editPayrollMapping(
                                  payrollMappingBody,
                                  widget.payrollMappingItem!.id!,
                                );
                              } else {
                                controller.createPayrollMapping(payrollMappingBody);
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
