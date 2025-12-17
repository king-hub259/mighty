import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_button.dart';
import 'package:mighty_school/common/widget/custom_contaner.dart';
import 'package:mighty_school/common/widget/custom_snackbar.dart';
import 'package:mighty_school/common/widget/custom_text_field.dart';
import 'package:mighty_school/common/widget/custom_title.dart';
import 'package:mighty_school/feature/academic_configuration/class/controller/class_controller.dart';
import 'package:mighty_school/feature/academic_configuration/class/presentation/widgets/select_class_widget.dart';
import 'package:mighty_school/feature/academic_configuration/section/controller/section_controller.dart';
import 'package:mighty_school/feature/academic_configuration/section/presentation/widgets/select_section_widget.dart';
import 'package:mighty_school/feature/layout_and_certificate/enum/certificate_type_enum.dart';
import 'package:mighty_school/feature/layout_and_certificate/logic/layout_and_certificate_controller.dart';
import 'package:mighty_school/feature/profile/logic/profile_controller.dart';
import 'package:mighty_school/helper/responsive_helper.dart';
import 'package:mighty_school/util/app_constants.dart';
import 'package:mighty_school/util/dimensions.dart';

class IdCardWidget extends StatefulWidget {
  const IdCardWidget({super.key});

  @override
  State<IdCardWidget> createState() => _IdCardWidgetState();
}

class _IdCardWidgetState extends State<IdCardWidget> {

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LayoutAndCertificateController>(
        builder: (layoutAndCertificateController) {
          String title = 'id_card'.tr;
          return Column(children: [
            Padding(padding: const EdgeInsets.only(top: Dimensions.paddingSizeDefault),
              child: CustomTitle(title: title, webTitle: ResponsiveHelper.isDesktop(context),),),

            Padding(padding: const EdgeInsets.symmetric(horizontal : Dimensions.paddingSizeDefault),
              child: CustomContainer(showShadow: false, borderRadius: 5,
                  child: Row(spacing: Dimensions.paddingSizeDefault,crossAxisAlignment: CrossAxisAlignment.end, children: [
                    const Expanded(child: SelectClassWidget()),

                    SizedBox(width: 120,child: Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: CustomButton(onTap: (){
                        int? classId = Get.find<ClassController>().selectedClassItem?.id;

                         if(classId == null){
                          showCustomSnackBar("class_is_empty".tr);
                        }else{
                           Map<String, dynamic> data = {
                             "institute_id": Get.find<ProfileController>().profileModel?.data?.instituteId,
                             "branch_id": Get.find<ProfileController>().currentBranch,
                             "class_id": classId
                           };
                            String jsonString = jsonEncode(data);
                            String base64Encoded = base64Encode(utf8.encode(jsonString));
                           AppConstants.openUrl("${AppConstants.baseUrl}${AppConstants.idCard}/$base64Encoded");
                         }
                      }, text: "search".tr),
                    ),)
                  ])),
            ),

            const SizedBox(height: Dimensions.paddingSizeDefault),

          ]);
        }
    );
  }

}
