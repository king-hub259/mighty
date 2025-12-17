import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/controller/datepicker_controller.dart';
import 'package:mighty_school/common/widget/custom_button.dart';
import 'package:mighty_school/common/widget/custom_divider.dart';
import 'package:mighty_school/common/widget/custom_dropdown.dart';
import 'package:mighty_school/common/widget/custom_snackbar.dart';
import 'package:mighty_school/common/widget/custom_text_field.dart';
import 'package:mighty_school/common/widget/custom_title.dart';
import 'package:mighty_school/feature/hrm/payroll/controller/payroll_controller.dart';
import 'package:mighty_school/feature/payroll_management/due/domain/model/due_model.dart';
import 'package:mighty_school/feature/payroll_management/due/domain/model/due_payment_body.dart';
import 'package:mighty_school/feature/payroll_management/due/logic/due_controller.dart';
import 'package:mighty_school/util/app_constants.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';

class DuePaymentWidget extends StatefulWidget {
  final String userId;
  const DuePaymentWidget({super.key, required this.userId});

  @override
  State<DuePaymentWidget> createState() => _DuePaymentWidgetState();
}

class _DuePaymentWidgetState extends State<DuePaymentWidget> {
  TextEditingController amountController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  @override
  void initState() {
    super.initState();
    Get.find<DueController>().getDue(widget.userId);
  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PayrollController>(
      builder: (payrollController) {
        return GetBuilder<DueController>(
          builder: (dueController) {
            DueModel? dueModel = dueController.dueModel;
            User? user = dueModel?.data?.user;
            return Column(crossAxisAlignment: CrossAxisAlignment.start,mainAxisSize: MainAxisSize.min,
                spacing: Dimensions.paddingSizeExtraSmall, children: [
              Text(user?.name??'N/a', style:  textSemiBold.copyWith(fontSize: Dimensions.fontSizeLarge)),
              const SizedBox(height: 10),
               Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Text("${"payable".tr}: 545", style: textMedium.copyWith()),
                  Text("${"due".tr}: 54545", style: textMedium.copyWith()),
                ]),

              const CustomDivider(),
              CustomTextField(controller: amountController,
                  inputType: TextInputType.number,
                  inputFormatters: [AppConstants.numberFormat],
                  hintText: "enter_amount".tr, title: "amount".tr),
              const CustomTitle(title: "payment_method"),
              Padding(padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: CustomDropdown(width: Get.width, title: "select".tr,
                  items: payrollController.paymentMethodList,
                  selectedValue: payrollController.selectedPaymentMethod,
                  onChanged: (val){
                    payrollController.setSelectedPaymentMethod(val!);
                  },
                ),),

              CustomTextField(controller: noteController,
                  hintText: "enter_note".tr, title: "note".tr,
                  minLines: 3,
                  inputType: TextInputType.multiline,
                  maxLines: 4),
              const SizedBox(height: Dimensions.paddingSizeExtraLarge),
              dueController.loading? const Center(child: CircularProgressIndicator()):
              CustomButton(onTap: (){
                String userId = widget.userId;
                String amount = amountController.text.trim();
                String paymentMethod = payrollController.selectedPaymentMethod??'';
                String note = noteController.text.trim();
                if(amount.isEmpty){
                  showCustomSnackBar("enter_amount".tr);
                }else if(payrollController.selectedPaymentMethod == null){
                  showCustomSnackBar("select_payment_method".tr);
                }
                else{
                  DuePaymentBody body = DuePaymentBody(
                    date: Get.find<DatePickerController>().formatedDate,
                      userId: userId, amount: amount, paymentMethodId: paymentMethod, note: note
                  );
                  dueController.duePayment(body);
                }

              }, text: "payment".tr)
            ]);
          }
        );
      }
    );
  }
}
