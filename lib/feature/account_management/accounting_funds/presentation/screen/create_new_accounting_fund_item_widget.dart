import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_button.dart';
import 'package:mighty_school/common/widget/custom_snackbar.dart';
import 'package:mighty_school/common/widget/custom_text_field.dart';
import 'package:mighty_school/feature/account_management/accounting_funds/domain/model/account_fund_model.dart';
import 'package:mighty_school/feature/account_management/accounting_funds/logic/account_fund_controller.dart';
import 'package:mighty_school/util/dimensions.dart';

class CreateNewAccountingFundWidget extends StatefulWidget {
  final AccountingFundItem? accountingFundItem;
  const CreateNewAccountingFundWidget({super.key, this.accountingFundItem});

  @override
  State<CreateNewAccountingFundWidget> createState() => _CreateNewAccountingFundWidgetState();
}

class _CreateNewAccountingFundWidgetState extends State<CreateNewAccountingFundWidget> {

  TextEditingController  nameController = TextEditingController();

  bool updateAccount = false;

  @override
  void initState() {

    if(widget.accountingFundItem != null) {
      nameController.text = widget.accountingFundItem?.name??'';
      updateAccount = true;

    }
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Dialog(insetPadding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall)),
      child: GetBuilder<AccountingFundController>(
          builder: (accountingFundController) {
            return Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
              child: Column(mainAxisSize: MainAxisSize.min,
                children: [
                  CustomTextField(title: "name".tr, isRequired: true,
                    controller: nameController,
                    hintText: "enter_name".tr,),


                  Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
                    child: accountingFundController.isLoading? const CircularProgressIndicator():
                    CustomButton(onTap: (){

                      String name = nameController.text.trim();

                      if(name.isEmpty){
                        showCustomSnackBar("name_is_empty".tr);
                      }
                      else{

                        if(updateAccount){
                          accountingFundController.updateAccountingFund(name, widget.accountingFundItem!.id!);
                        }else{
                          accountingFundController.createNewAccountingFund(name);
                        }
                      }
                    }, text: "confirm".tr),
                  )


                ],
              ),
            );
          }
      ),
    );
  }
}
