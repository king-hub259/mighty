import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_button.dart';
import 'package:mighty_school/common/widget/custom_snackbar.dart';
import 'package:mighty_school/common/widget/custom_text_field.dart';
import 'package:mighty_school/feature/payroll_management/payroll_start_up/domain/models/salary_head_model.dart';
import 'package:mighty_school/feature/payroll_management/payroll_start_up/logic/payroll_start_up_controller.dart';
import 'package:mighty_school/feature/payroll_management/payroll_start_up/presentation/widgets/select_salary_head_type_widget.dart';
import 'package:mighty_school/util/dimensions.dart';

class AddNewSalaryHeadWidget extends StatefulWidget {
  final SalaryHeadItem? salaryHeadItem;
  const AddNewSalaryHeadWidget({super.key, this.salaryHeadItem});

  @override
  State<AddNewSalaryHeadWidget> createState() => _AddNewSalaryHeadWidgetState();
}

class _AddNewSalaryHeadWidgetState extends State<AddNewSalaryHeadWidget> {
  final TextEditingController salaryHeadController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.salaryHeadItem != null) {
      salaryHeadController.text = widget.salaryHeadItem?.name ?? '';
    }
  }

  void _handleSaveOrUpdate(PayrollStartUpController controller) {
    String salaryHead = salaryHeadController.text.trim();
    String? salaryHeadType = controller.selectedHeadType;

    if (salaryHead.isEmpty) {
      showCustomSnackBar("enter_salary_head".tr);
      return;
    } else if (salaryHeadType == null) {
      showCustomSnackBar("select_salary_head_type".tr);
      return;
    }

    SalaryHeadBody salaryHeadBody = SalaryHeadBody(name: salaryHead, type: salaryHeadType);

    if (widget.salaryHeadItem != null) {
      controller.editSalaryHead(salaryHeadBody, widget.salaryHeadItem!.id!);
    } else {
      controller.createSalaryHead(salaryHeadBody);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PayrollStartUpController>(builder: (controller) {
        return Dialog(child: Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeExtraLarge),
            child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
                    Expanded(child: CustomTextField(controller: salaryHeadController, hintText: "enter_salary_head".tr,
                       title: "salary_head".tr)),
                    const SizedBox(width: Dimensions.paddingSizeDefault),
                    const Expanded(child: SelectSalaryHeadTypeWidget()),
                    const SizedBox(width: Dimensions.paddingSizeDefault),
                    SizedBox(width: controller.loading? 40 :120, child: CustomButton(
                      isLoading: controller.loading,
                        onTap: () => _handleSaveOrUpdate(controller),
                      text: widget.salaryHeadItem != null ? "update".tr : "save".tr),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}