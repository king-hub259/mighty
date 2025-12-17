import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_button.dart';
import 'package:mighty_school/common/widget/custom_contaner.dart';
import 'package:mighty_school/common/widget/custom_snackbar.dart';
import 'package:mighty_school/common/widget/custom_text_field.dart';
import 'package:mighty_school/common/widget/section_header_with_path_widget.dart';
import 'package:mighty_school/feature/administrator/system_settings/controller/system_settngs_controller.dart';
import 'package:mighty_school/feature/zoom_class/logic/zoom_class_controller.dart';
import 'package:mighty_school/util/dimensions.dart';

class ZoomClassConfigWidget extends StatefulWidget {
  const ZoomClassConfigWidget({super.key});

  @override
  State<ZoomClassConfigWidget> createState() => _ZoomClassConfigWidgetState();
}

class _ZoomClassConfigWidgetState extends State<ZoomClassConfigWidget> {
  TextEditingController accountIdController = TextEditingController();
  TextEditingController apiKeyController = TextEditingController();
  TextEditingController apiSecretController = TextEditingController();


  @override
  void initState() {
    accountIdController.text = Get.find<SystemSettingsController>().generalSettingModel?.data?.zoomAccountId??'';
    apiKeyController.text = Get.find<SystemSettingsController>().generalSettingModel?.data?.zoomClientKey??'';
    apiSecretController.text = Get.find<SystemSettingsController>().generalSettingModel?.data?.zoomClientSecret??'';
    super.initState();
  }




  @override
  Widget build(BuildContext context) {
    return Column(children: [
        SectionHeaderWithPath(sectionTitle: "zoom_config".tr, ),
        Padding(padding:  const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
          child: CustomContainer(
            child: Column(spacing: Dimensions.paddingSizeLarge, children: [
          
             CustomTextField(
                title: "account_id".tr,
                hintText: "enter_account_id".tr,
                controller: accountIdController),
          
             CustomTextField(
                title: "client_key".tr,
                hintText: "enter_client_key".tr,
                controller: apiKeyController),
          
             CustomTextField(
               title: "client_secret".tr,
                hintText: "enter_client_secret".tr,
                controller: apiSecretController),
          
              GetBuilder<ZoomClassController>(
                builder: (zoomClassController) {
                  return zoomClassController.isLoading? const Center(child: CircularProgressIndicator()):
                  CustomButton(onTap: (){
                    String accountId = accountIdController.text.trim();
                    String apiKey = apiKeyController.text.trim();
                    String apiSecret = apiSecretController.text.trim();
                    if (accountId.isEmpty){
                      showCustomSnackBar("enter_account_id".tr);
                    } else if (apiKey.isEmpty) {
                      showCustomSnackBar("enter_api_key".tr);
                    } else if (apiSecret.isEmpty) {
                      showCustomSnackBar("enter_api_secret".tr);
                    } else {
                      zoomClassController.updateZoomConfig( accountId,  apiKey,  apiSecret);
                    }
                  }, text: "update".tr);
                }
              )
            ]),
          ),
        ),
      ],
    );
  }
}
