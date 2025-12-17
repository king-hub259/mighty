
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/common/widget/custom_button.dart';
import 'package:mighty_school/common/widget/custom_dropdown.dart';
import 'package:mighty_school/common/widget/custom_snackbar.dart';
import 'package:mighty_school/common/widget/custom_text_field.dart';
import 'package:mighty_school/common/widget/custom_title.dart';
import 'package:mighty_school/feature/master_configuration/employee/controller/employee_controller.dart';
import 'package:mighty_school/feature/master_configuration/employee/presentation/widgets/employee_dropdown.dart';
import 'package:mighty_school/feature/hrm/payroll/controller/payroll_controller.dart';
import 'package:mighty_school/feature/hrm/payroll/domain/models/payroll_body.dart';
import 'package:mighty_school/feature/hrm/payroll/domain/models/payroll_model.dart';
import 'package:mighty_school/helper/date_converter.dart';
import 'package:mighty_school/util/dimensions.dart';

class CreateNewPayrollScreen extends StatefulWidget {
  final PayrollItem? payrollItem;
  const CreateNewPayrollScreen({super.key, this.payrollItem});

  @override
  State<CreateNewPayrollScreen> createState() => _CreateNewPayrollScreenState();
}

class _CreateNewPayrollScreenState extends State<CreateNewPayrollScreen> {
  TextEditingController amountController = TextEditingController();
  TextEditingController refController = TextEditingController();
  TextEditingController noteController = TextEditingController();


   bool update = false;
  @override
  void initState() {
    Get.find<EmployeeController>().getEmployeeList(1);
    if(widget.payrollItem != null){
      update = true;

    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: CustomAppBar(title: "add_new_payroll".tr,),
      body: CustomWebScrollView(slivers: [
        SliverToBoxAdapter(child: Column(children: [
          Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
            child: GetBuilder<PayrollController>(
                builder: (payrollController) {
                  return Column(mainAxisSize: MainAxisSize.min, children: [



                    InkWell(onTap: ()=> payrollController.setSelectDate(context),
                        child: CustomTextField(title: "date".tr,isRequired: true,
                            isEnabled : false,
                            hintText: DateConverter.quotationDate(payrollController.selectedDate))),




                    const CustomTitle(title: "month"),
                    Padding(padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: CustomDropdown(width: Get.width, title: "choose_month".tr,
                        items: payrollController.monthList,
                        selectedValue: payrollController.selectedMonth,
                        onChanged: (val){
                          payrollController.setSelectedMonth(val!);
                        },
                      ),),

                    const CustomTitle(title: "year"),
                    Padding(padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: CustomDropdown(width: Get.width, title: "choose_year".tr,
                        items: payrollController.yearList,
                        selectedValue: payrollController.selectedYear,
                        onChanged: (val){
                          payrollController.setSelectedYear(val!);
                        },
                      ),),


                    const CustomTitle(title: "employee"),
                    GetBuilder<EmployeeController>(
                        builder: (employeeController) {
                          return Padding(padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: EmployeeDropdown(width: Get.width, title: "select_employee".tr,
                              items: employeeController.employeeModel?.data?.data??[],
                              selectedValue: payrollController.selectedEmployeeItem,
                              onChanged: (val){
                                payrollController.setSelectedEmployeeItem(val!);
                              },
                            ),);
                        }
                    ),



                    CustomTextField(hintText: "0",
                    title: "amount".tr,
                      isAmount: true,
                      controller: amountController,),

                    const CustomTitle(title: "payment_method"),
                    Padding(padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: CustomDropdown(width: Get.width, title: "select".tr,
                        items: payrollController.paymentMethodList,
                        selectedValue: payrollController.selectedPaymentMethod,
                        onChanged: (val){
                          payrollController.setSelectedPaymentMethod(val!);
                        },
                      ),),

                    const CustomTitle(title: "payment_status"),
                    Padding(padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: CustomDropdown(width: Get.width, title: "select_payment_status".tr,
                        items: payrollController.paymentStatusList,
                        selectedValue: payrollController.selectedPaymentStatus,
                        onChanged: (val){
                          payrollController.setSelectedPaymentStatus(val!);
                        },
                      ),),


                    CustomTextField(hintText: "ref".tr,
                      title: "ref".tr,
                      controller: refController,),


                    CustomTextField(hintText: "notes".tr,
                      title: "notes".tr,
                      controller: noteController,),





                    payrollController.isLoading? const Center(child: CircularProgressIndicator()):
                    Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
                        child: CustomButton(onTap: (){
                          String amount = amountController.text.trim();
                          String ref = refController.text.trim();
                          String note = noteController.text.trim();
                          String date = payrollController.formatedDate.trim();
                          String? month = payrollController.selectedMonth;
                          String? year = payrollController.selectedYear;
                          int? employeeId = payrollController.selectedEmployeeItem?.id;
                          String? paymentMethod =payrollController.selectedPaymentMethod;
                          String? paymentStatus = payrollController.selectedPaymentStatus;


                          if(amount.isEmpty){
                            showCustomSnackBar("amount_is_empty".tr);
                          }

                          else if(date.isEmpty){
                            showCustomSnackBar("date_is_empty".tr);
                          }
                          else if(month == null){
                            showCustomSnackBar("month_is_empty".tr);
                          }
                          else if(year == null){
                            showCustomSnackBar("year_is_empty".tr);
                          }
                          else if(employeeId == null){
                            showCustomSnackBar("employee_is_empty".tr);
                          }
                          else if(paymentMethod == null){
                            showCustomSnackBar("payment_method_is_empty".tr);
                          }
                          else if(paymentStatus == null){
                            showCustomSnackBar("payment_status_is_empty".tr);
                          }

                          else{
                            PayrollBody payrollBody = PayrollBody(
                              amount: amount,
                              reference: ref,
                              notes: note,
                              date: date,
                              month: month,
                              year: year,
                              userId: employeeId.toString(),
                              method: paymentMethod,
                              status: paymentStatus,
                            );
                            if(update){
                              payrollController.updatePayroll(payrollBody, widget.payrollItem!.id!);
                            }else{
                              payrollController.createNewPayroll(payrollBody);
                            }

                          }


                        }, text: update? "update".tr : "save".tr))
                  ],);
                }
            ),
          )
        ],),)
      ],),
    );
  }
}
