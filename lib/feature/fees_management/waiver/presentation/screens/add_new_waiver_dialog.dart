import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_button.dart';
import 'package:mighty_school/common/widget/custom_contaner.dart';
import 'package:mighty_school/common/widget/custom_snackbar.dart';
import 'package:mighty_school/common/widget/custom_text_field.dart';
import 'package:mighty_school/feature/fees_management/waiver/controller/waiver_controller.dart';
import 'package:mighty_school/util/dimensions.dart';

class CreateNewWaiverDialog extends StatefulWidget {
  const CreateNewWaiverDialog({super.key});

  @override
  State<CreateNewWaiverDialog> createState() => _CreateNewWaiverDialogState();
}

class _CreateNewWaiverDialogState extends State<CreateNewWaiverDialog> {
  TextEditingController waiverNameController =  TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Dialog(child: SizedBox(width: 500,
      child: CustomContainer(verticalPadding: Dimensions.paddingSizeLarge,
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          CustomTextField(controller: waiverNameController,
            hintText: "name".tr,title: "name".tr,),
           const SizedBox(height: Dimensions.paddingSizeSmall),
           CustomButton(onTap: (){
             String name = waiverNameController.text.trim();
             if(name.isEmpty){
               showCustomSnackBar("name_is_empty".tr);
             }else{
               Get.back();
               Get.find<WaiverController>().addNewWaiver(name);
             }

           }, text: "confirm"),
        ]),
      ),
    ));
  }
}
