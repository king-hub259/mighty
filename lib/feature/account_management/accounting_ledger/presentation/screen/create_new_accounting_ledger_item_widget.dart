import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_button.dart';
import 'package:mighty_school/common/widget/custom_snackbar.dart';
import 'package:mighty_school/common/widget/custom_text_field.dart';
import 'package:mighty_school/feature/account_management/accounting_category/controller/accounting_category_controller.dart';
import 'package:mighty_school/feature/account_management/accounting_category/presentation/widgets/accounting_category_selection_widget.dart';
import 'package:mighty_school/feature/account_management/accounting_group/logic/account_group_controller.dart';
import 'package:mighty_school/feature/account_management/accounting_group/presentation/widgets/accounting_group_selection_widget.dart';
import 'package:mighty_school/feature/account_management/accounting_ledger/domain/model/accounting_ledger_model.dart';
import 'package:mighty_school/feature/account_management/accounting_ledger/logic/account_ledger_controller.dart';
import 'package:mighty_school/util/dimensions.dart';

class CreateNewAccountingLedgerWidget extends StatefulWidget {
  final AccountingLedgerItem? accountingLedgerItem;
  const CreateNewAccountingLedgerWidget({super.key, this.accountingLedgerItem});

  @override
  State<CreateNewAccountingLedgerWidget> createState() => _CreateNewAccountingLedgerWidgetState();
}

class _CreateNewAccountingLedgerWidgetState extends State<CreateNewAccountingLedgerWidget> {

  TextEditingController  nameController = TextEditingController();

  bool updateAccount = false;

  @override
  void initState() {

    if(Get.find<AccountingCategoryController>().accountingCategoryModel == null){
      Get.find<AccountingCategoryController>().getAccountingCategoryList(1);
    }
    if(Get.find<AccountingGroupController>().accountingGroupModel == null){
      Get.find<AccountingGroupController>().getAccountingGroupList(1);
    }
    if(widget.accountingLedgerItem != null) {
      nameController.text = widget.accountingLedgerItem?.ledgerName??'';
      updateAccount = true;

    }
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Dialog(insetPadding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall)),
      child: GetBuilder<AccountLedgerController>(
          builder: (accountLedgerController) {
            return Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
              child: Column(mainAxisSize: MainAxisSize.min,
                children: [

                  const SelectAccountingCategoryWidget(),
                  const SelectAccountingGroupWidget(),

                  CustomTextField(title: "name".tr, isRequired: true,
                    controller: nameController,
                    hintText: "enter_name".tr,),


                  Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
                    child: accountLedgerController.isLoading? const CircularProgressIndicator():
                    CustomButton(onTap: (){

                      String name = nameController.text.trim();
                      int? categoryId = Get.find<AccountingCategoryController>().selectedAccountingCategory?.id;
                      int? groupId = Get.find<AccountingGroupController>().selectedAccountingGroupItem?.id;


                      if(name.isEmpty){
                        showCustomSnackBar("name_is_empty".tr);
                      }

                      else if(categoryId == null){
                        showCustomSnackBar("select_category".tr);
                      }
                      else if(groupId == null){
                        showCustomSnackBar("select_group".tr);
                      }

                      else{
                        if(updateAccount){
                          accountLedgerController.updateAccountingLedger(name,categoryId , groupId, widget.accountingLedgerItem!.id!);
                        }else{
                          accountLedgerController.createNewAccountingLedger(name, categoryId, groupId);
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
