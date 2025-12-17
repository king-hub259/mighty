import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_button.dart';
import 'package:mighty_school/common/widget/custom_text_field.dart';
import 'package:mighty_school/feature/fees_management/fees_head/controller/fees_head_controller.dart';
import 'package:mighty_school/feature/fees_management/fees_start_up/controller/fees_management_controller.dart';
import 'package:mighty_school/feature/fees_management/fees_sub_head/controller/fees_sub_head_controller.dart';
import 'package:mighty_school/feature/fees_management/waiver/controller/waiver_controller.dart';
import 'package:mighty_school/util/dimensions.dart';

class CreateNewFeesAndWaiverWidget extends StatefulWidget {
  const CreateNewFeesAndWaiverWidget({super.key});

  @override
  State<CreateNewFeesAndWaiverWidget> createState() => _CreateNewFeesAndWaiverWidgetState();
}

class _CreateNewFeesAndWaiverWidgetState extends State<CreateNewFeesAndWaiverWidget> {
  TextEditingController nameController = TextEditingController();
  TextEditingController serialController = TextEditingController();
  void clearTextField(){
    nameController.clear();
    serialController.clear();
  }
  @override
  Widget build(BuildContext context) {
    return Row(crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(child: CustomTextField(title: "name".tr,
          hintText: "name".tr, controller: nameController,)),
        const SizedBox(width: Dimensions.paddingSizeDefault),

        Expanded(child: CustomTextField(title: "serial".tr,
          hintText: "serial".tr, controller: serialController,)),
        const SizedBox(width: Dimensions.paddingSizeDefault,),
        GetBuilder<FeesHeadController>(
            builder: (feesHeadController) {
              return GetBuilder<FeesSubHeadController>(
                  builder: (subHeadController) {
                    return GetBuilder<WaiverController>(
                        builder: (waiverController) {
                          return Align(alignment: Alignment.centerRight,
                              child: SizedBox(width: 120, child: (feesHeadController.isLoading || subHeadController.isLoading || waiverController.isLoading)? const Center(child: CircularProgressIndicator()):
                              GetBuilder<FeesManagementController>(
                                  builder: (feesController) {
                                    return CustomButton(onTap: (){
                                      String name= nameController.text.trim();
                                      String serial= serialController.text.trim();

                                      if(feesController.feesStartupTypeIndex == 0){
                                        feesHeadController.addNewFeesHead(name, serial);
                                      }else if(feesController.feesStartupTypeIndex == 1){
                                        subHeadController.addNewFeesSubHead(name, serial);
                                      }else{
                                        waiverController.addNewWaiver(name);
                                      }
                                      clearTextField();

                                    }, text: "confirm".tr);
                                  }
                              )));
                        }
                    );
                  }
              );
            }
        )

      ],
    );
  }
}
