import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_button.dart';
import 'package:mighty_school/common/widget/custom_dropdown.dart';
import 'package:mighty_school/common/widget/custom_snackbar.dart';
import 'package:mighty_school/common/widget/custom_text_field.dart';
import 'package:mighty_school/common/widget/custom_title.dart';
import 'package:mighty_school/feature/account_management/accounting_category/controller/accounting_category_controller.dart';
import 'package:mighty_school/feature/account_management/accounting_category/domain/models/accounting_category_model.dart';
import 'package:mighty_school/util/dimensions.dart';

class CreateNewAccountingCategoryScreen extends StatefulWidget {
  final AccountingCategoryItem? accountingCategoryItem;
  const CreateNewAccountingCategoryScreen({super.key, this.accountingCategoryItem});

  @override
  State<CreateNewAccountingCategoryScreen> createState() => _CreateNewAccountingCategoryScreenState();
}

class _CreateNewAccountingCategoryScreenState extends State<CreateNewAccountingCategoryScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
   bool update = false;
  @override
  void initState() {
    if(widget.accountingCategoryItem != null){
      update = true;
      nameController.text = widget.accountingCategoryItem?.name??'';
      descriptionController.text = widget.accountingCategoryItem?.type??'';
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Dialog(insetPadding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall)),
      child: Padding(
        padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
        child: GetBuilder<AccountingCategoryController>(
          builder: (accountingCategoryController) {
            return Column(mainAxisSize: MainAxisSize.min, children: [
              const Padding(padding: EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
                child: CustomTitle(title: "add_new_category")),

              CustomTextField(title: "name".tr,
                controller: nameController,
                hintText: "enter_name".tr,),


              const CustomTitle(title: "type", isRequired: true,),
              Padding(padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: CustomDropdown(width: Get.width, title: "select".tr,
                  items: accountingCategoryController.accountingTypes,
                  selectedValue: accountingCategoryController.selectedType,
                  onChanged: (val){
                    accountingCategoryController.setSelectedType(val!);
                  },
                ),),




              accountingCategoryController.isLoading? const Padding(padding: EdgeInsets.all(Dimensions.paddingSizeDefault),
                child: Center(child: CircularProgressIndicator())):

              Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
                child: CustomButton(onTap: (){
                  String name = nameController.text.trim();
                  String type = accountingCategoryController.selectedType;
                  if(name.isEmpty){
                    showCustomSnackBar("name_is_empty");
                  }else{
                    if(update){
                      accountingCategoryController.updateAccountingCategory(name, type, widget.accountingCategoryItem!.id!);
                    }else{
                      accountingCategoryController.createNewAccountingCategory(name, type.toLowerCase());
                    }

                  }
                }, text:  "confirm".tr))
            ],);
          }
        ),
      ),
    );
  }
}
