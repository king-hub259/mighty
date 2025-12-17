import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/controller/datepicker_controller.dart';
import 'package:mighty_school/common/widget/custom_button.dart';
import 'package:mighty_school/common/widget/custom_contaner.dart';
import 'package:mighty_school/common/widget/custom_snackbar.dart';
import 'package:mighty_school/common/widget/custom_text_field.dart';
import 'package:mighty_school/common/widget/date_selection_widget.dart';
import 'package:mighty_school/common/widget/section_header_with_path_widget.dart';
import 'package:mighty_school/feature/account_management/accounting_funds/logic/account_fund_controller.dart';
import 'package:mighty_school/feature/account_management/accounting_funds/presentation/widgets/accounting_fund_selection_widget.dart';
import 'package:mighty_school/feature/account_management/accounting_ledger/logic/account_ledger_controller.dart';
import 'package:mighty_school/feature/account_management/accounting_ledger/presentation/widgets/accounting_ledger_selection_widget.dart';
import 'package:mighty_school/feature/account_management/payment/domain/model/payment_body.dart';
import 'package:mighty_school/feature/account_management/payment/logic/payment_controller.dart';
import 'package:mighty_school/helper/responsive_helper.dart';
import 'package:mighty_school/util/dimensions.dart';

class JournalWidget extends StatefulWidget {
  const JournalWidget({super.key});

  @override
  State<JournalWidget> createState() => _JournalWidgetState();
}

class _JournalWidgetState extends State<JournalWidget> {
  TextEditingController  amountController = TextEditingController();
  TextEditingController  refController = TextEditingController();
  TextEditingController  descriptionController = TextEditingController();
  TextEditingController  dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AccountLedgerController>(builder: (accountLedgerController) {
      return GetBuilder<PaymentController>(builder: (paymentController) {
        return Padding(padding: EdgeInsets.all(ResponsiveHelper.isDesktop(context)? 0 : Dimensions.paddingSizeDefault),
          child: Column(children: [

            SectionHeaderWithPath(sectionTitle: "account_management".tr, pathItems: ["journal".tr]),

            CustomContainer(color: ResponsiveHelper.isDesktop(context)? Theme.of(context).cardColor : Colors.transparent, showShadow: false,
              child: Column(mainAxisSize: MainAxisSize.min, children: [

                const DateSelectionWidget(),

                const SelectAccountingLedgerWidget(showBalance: true, title: "payment_by"),
                    ListView.builder(
                        shrinkWrap:true,
                        itemCount: 1,
                        padding: EdgeInsets.zero,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index){
                          return  Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                              const Expanded(flex: 5,child: SelectAccountingLedgerWidget(title: "transaction_for")),
                              const SizedBox(width: Dimensions.paddingSizeSmall),
                              Expanded(flex: 3,child:  Padding(padding: const EdgeInsets.only(top: 8.0),
                                child: CustomTextField(title: "amount".tr,
                                  controller: amountController,
                                  inputType: TextInputType.number,
                                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                  hintText: "amount".tr,),
                              ),),
                            ],
                          );
                        }),

                    const SelectAccountingFundWidget(title: "fund"),

                    CustomTextField(title: "ref".tr,
                      controller: refController,
                      hintText: "ref".tr,),

                    CustomTextField(title: "description".tr,
                      controller: descriptionController,
                      minLines: 3,
                      maxLines: 5,
                      maxLength: 200,
                      hintText: "description".tr,),



                    paymentController.isLoading? const Center(child: Padding(padding: EdgeInsets.all(8.0), child: CircularProgressIndicator(),)):
                    Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
                      child: accountLedgerController.isLoading? const CircularProgressIndicator():
                      CustomButton(onTap: (){
                        String amount = amountController.text.trim();
                        int? paymentMethodId = Get.find<AccountLedgerController>().selectedAccountingLedgerItemForPayment?.id;
                        int? ledgerId = Get.find<AccountLedgerController>().selectedAccountingLedgerItemForTransaction?.id;
                        int? fundId = Get.find<AccountingFundController>().selectedAccountingFundItem?.id;
                        String? date = Get.find<DatePickerController>().formatedDate;
                        String? ref = refController.text.trim();
                        String? description = descriptionController.text.trim();

                        if(amount.isEmpty){
                          showCustomSnackBar("amount_is_empty".tr);
                        }

                        else if(paymentMethodId == null){
                          showCustomSnackBar("select_payment_method".tr);
                        }
                        else if(ledgerId == null){
                          showCustomSnackBar("select_transaction_type".tr);
                        }
                        else if(fundId == null){
                          showCustomSnackBar("select_fund".tr);
                        }
                        else if(date.isEmpty){
                          showCustomSnackBar("select_date".tr);
                        }
                        else if(ref.isEmpty){
                          showCustomSnackBar("ref_is_empty".tr);
                        }
                        else{
                          PaymentBody paymentBody = PaymentBody(
                            type:  "journal",
                            amounts: [amount],
                            paymentMethodId: paymentMethodId,
                            ledgerIds: [ledgerId],
                            fundId: fundId,
                            transactionDate: date,
                            reference: ref,
                            description: description,
                          );
                          paymentController.createPayment(paymentBody);
                        }
                      }, text: "confirm".tr),
                    )
                  ],
                ),
              ),
                    ],
                  ),
                );
              }
          );
        }
    );
  }
}
