import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/controller/datepicker_controller.dart';
import 'package:mighty_school/common/widget/custom_button.dart';
import 'package:mighty_school/common/widget/custom_dropdown.dart';
import 'package:mighty_school/common/widget/custom_snackbar.dart';
import 'package:mighty_school/common/widget/custom_text_field.dart';
import 'package:mighty_school/common/widget/custom_title.dart';
import 'package:mighty_school/common/widget/date_selection_widget.dart';
import 'package:mighty_school/feature/sms/purchase_sms/controller/purchase_sms_controller.dart';
import 'package:mighty_school/feature/sms/purchase_sms/domain/models/purchase_sms_body.dart';
import 'package:mighty_school/feature/sms/purchase_sms/domain/models/purchase_sms_model.dart';
import 'package:mighty_school/helper/responsive_helper.dart';
import 'package:mighty_school/util/dimensions.dart';

class CreateNewPurchaseSmsWidget extends StatefulWidget {
  final PurchaseSmsItem? purchaseSmsItem;
  const CreateNewPurchaseSmsWidget({super.key, this.purchaseSmsItem});

  @override
  State<CreateNewPurchaseSmsWidget> createState() => _CreateNewPurchaseSmsWidgetState();
}

class _CreateNewPurchaseSmsWidgetState extends State<CreateNewPurchaseSmsWidget> {
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  bool update = false;
  @override
  void initState() {
    if(widget.purchaseSmsItem != null){
      update = true;
      nameController.text = widget.purchaseSmsItem?.noOfSms??'';
      priceController.text = widget.purchaseSmsItem?.amount??'';
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
      child: GetBuilder<PurchaseSmsController>(
          builder: (purchaseSmsController) {
            return ResponsiveHelper.isDesktop(context)?
            Column(children: [
              Row(children: [
                Expanded(
                  child: CustomTextField(title: "quantity".tr,
                    controller: nameController,
                    isAmount: true,
                    inputType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    hintText: "12000",),
                ),

                const SizedBox(width: Dimensions.paddingSizeDefault),
                Expanded(
                  child: CustomTextField(title: "price".tr,
                      isAmount: true,
                      inputType: TextInputType.number,
                      controller: priceController,
                      hintText: "12345"),
                ),

                const SizedBox(width: Dimensions.paddingSizeDefault),
                const Expanded(child: DateSelectionWidget()),
              ],),
              Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
                Expanded(child: Column(children: [
                  const CustomTitle(title: "asking_type"),
                  Padding(padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: CustomDropdown(width: Get.width, title: "select".tr,
                      items: purchaseSmsController.maskingTypes,
                      selectedValue: purchaseSmsController.selectedMaskingType,
                      onChanged: (val){
                        purchaseSmsController.setSelectedMaskingType(val!);
                      },
                    ),),
                ],)),
                const SizedBox(width: Dimensions.paddingSizeDefault),
                Expanded(child: Column(children: [
                  const CustomTitle(title: "sms_gateway"),
                  Padding(padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: CustomDropdown(width: Get.width, title: "select".tr,
                      items: purchaseSmsController.smsGateway,
                      selectedValue: purchaseSmsController.selectedSmsGateway,
                      onChanged: (val){
                        purchaseSmsController.setSelectedSmsGateway(val!);
                      },
                    ),),
                ],)),

                const SizedBox(width: Dimensions.paddingSizeDefault),

                purchaseSmsController.isLoading? const Padding(padding: EdgeInsets.all(Dimensions.paddingSizeDefault),
                    child: Center(child: CircularProgressIndicator())):

                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: CustomButton(onTap: (){
                      String quantity = nameController.text.trim();
                      String price = priceController.text.trim();
                      String date = Get.find<DatePickerController>().formatedDate;
                      String maskingType = purchaseSmsController.selectedMaskingType;
                      String smsGateway = purchaseSmsController.selectedSmsGateway;
                      if(quantity.isEmpty){
                        showCustomSnackBar("quantity_is_empty".tr);
                      }else if(price.isEmpty){
                        showCustomSnackBar("price_is_empty".tr);
                      }
                      else if(date.isEmpty){
                        showCustomSnackBar("date_is_empty".tr);
                      }else if(maskingType.isEmpty){
                        showCustomSnackBar("masking_type_is_empty".tr);
                      }else if(smsGateway.isEmpty){
                        showCustomSnackBar("sms_gateway_is_empty".tr);
                      }
                      else{
                        PurchaseSmsBody body = PurchaseSmsBody(
                          noOfSms: quantity,
                          amount: price,
                          transactionDate: date,
                          maskingType: maskingType,
                          smsGateway: smsGateway,
                        );
                        if(update){
                          purchaseSmsController.updatePurchaseSms(body, widget.purchaseSmsItem!.id!);
                        }else{
                          purchaseSmsController.createPurchaseSms(body);
                        }

                      }
                    }, text: update? "update".tr : "save".tr),
                  ),
                )
              ],),
            ],):
              Column(mainAxisSize: MainAxisSize.min, children: [

              CustomTextField(title: "quantity".tr,
                controller: nameController,
                isAmount: true,
                inputType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                hintText: "12000",),

              CustomTextField(title: "price".tr,
                isAmount: true,
                inputType: TextInputType.number,
                controller: priceController,
                hintText: "12345"),

              const DateSelectionWidget(),

              Row(children: [
                Expanded(child: Column(children: [
                  const CustomTitle(title: "asking_type"),
                  Padding(padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: CustomDropdown(width: Get.width, title: "select".tr,
                      items: purchaseSmsController.maskingTypes,
                      selectedValue: purchaseSmsController.selectedMaskingType,
                      onChanged: (val){
                        purchaseSmsController.setSelectedMaskingType(val!);
                      },
                    ),),
                ],)),
                const SizedBox(width: Dimensions.paddingSizeDefault),
                Expanded(child: Column(children: [
                  const CustomTitle(title: "sms_gateway"),
                  Padding(padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: CustomDropdown(width: Get.width, title: "select".tr,
                      items: purchaseSmsController.smsGateway,
                      selectedValue: purchaseSmsController.selectedSmsGateway,
                      onChanged: (val){
                        purchaseSmsController.setSelectedSmsGateway(val!);
                      },
                    ),),
                ],)),
              ],),


              purchaseSmsController.isLoading? const Padding(padding: EdgeInsets.all(Dimensions.paddingSizeDefault),
                  child: Center(child: CircularProgressIndicator())):

              Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
                  child: CustomButton(onTap: (){
                    String quantity = nameController.text.trim();
                    String price = priceController.text.trim();
                    String date = Get.find<DatePickerController>().formatedDate;
                    String maskingType = purchaseSmsController.selectedMaskingType;
                    String smsGateway = purchaseSmsController.selectedSmsGateway;
                    if(quantity.isEmpty){
                      showCustomSnackBar("quantity_is_empty".tr);
                    }else if(price.isEmpty){
                      showCustomSnackBar("price_is_empty".tr);
                    }
                    else if(date.isEmpty){
                      showCustomSnackBar("date_is_empty".tr);
                    }else if(maskingType.isEmpty){
                      showCustomSnackBar("masking_type_is_empty".tr);
                    }else if(smsGateway.isEmpty){
                      showCustomSnackBar("sms_gateway_is_empty".tr);
                    }
                    else{
                      PurchaseSmsBody body = PurchaseSmsBody(
                        noOfSms: quantity,
                        amount: price,
                        transactionDate: date,
                        maskingType: maskingType,
                        smsGateway: smsGateway,
                      );
                      if(update){
                        purchaseSmsController.updatePurchaseSms(body, widget.purchaseSmsItem!.id!);
                      }else{
                        purchaseSmsController.createPurchaseSms(body);
                      }

                    }
                  }, text: update? "update".tr : "save".tr))
            ],);
          }
      ),
    );
  }
}
