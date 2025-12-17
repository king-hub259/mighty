import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_button.dart';
import 'package:mighty_school/common/widget/custom_snackbar.dart';
import 'package:mighty_school/common/widget/custom_text_field.dart';
import 'package:mighty_school/feature/account_management/accounting_category/controller/accounting_category_controller.dart';
import 'package:mighty_school/feature/account_management/accounting_category/presentation/widgets/accounting_category_selection_widget.dart';
import 'package:mighty_school/feature/account_management/accounting_group/domain/model/accounting_group_model.dart';
import 'package:mighty_school/feature/account_management/accounting_group/logic/account_group_controller.dart';
import 'package:mighty_school/util/dimensions.dart';

class CreateNewAccountingGroupWidget extends StatefulWidget {
  final AccountingGroupItem? accountingGroupItem;
  const CreateNewAccountingGroupWidget({super.key, this.accountingGroupItem});

  @override
  State<CreateNewAccountingGroupWidget> createState() => _CreateNewAccountingGroupWidgetState();
}

class _CreateNewAccountingGroupWidgetState extends State<CreateNewAccountingGroupWidget> {

  TextEditingController  nameController = TextEditingController();

  bool updateAccount = false;

  @override
  void initState() {

    if(Get.find<AccountingCategoryController>().accountingCategoryModel == null){
      Get.find<AccountingCategoryController>().getAccountingCategoryList(1);
    }
    if(widget.accountingGroupItem != null) {
      nameController.text = widget.accountingGroupItem?.name??'';
      updateAccount = true;

    }
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Dialog(insetPadding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall)),
      child: GetBuilder<AccountingGroupController>(
          builder: (accountingGroupController) {
            return Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
              child: Column(mainAxisSize: MainAxisSize.min,
                children: [

                  const SelectAccountingCategoryWidget(),

                  CustomTextField(title: "name".tr, isRequired: true,
                    controller: nameController,
                    hintText: "enter_name".tr,),


                  Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
                    child: accountingGroupController.isLoading? const CircularProgressIndicator():
                    CustomButton(onTap: (){

                      String name = nameController.text.trim();
                      int? categoryId = Get.find<AccountingCategoryController>().selectedAccountingCategory?.id;


                      if(name.isEmpty){
                        showCustomSnackBar("name_is_empty".tr);
                      }

                      else if(categoryId == null){
                        showCustomSnackBar("select_category".tr);
                      }

                      else{
                        if(updateAccount){
                          accountingGroupController.updateAccountingGroup(name,categoryId ,widget.accountingGroupItem!.id!);
                        }else{
                          accountingGroupController.createNewAccountingGroup(name, categoryId);
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
