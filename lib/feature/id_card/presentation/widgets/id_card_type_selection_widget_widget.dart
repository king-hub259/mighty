import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/feature/administrator/system_settings/controller/system_settngs_controller.dart';
import 'package:mighty_school/feature/administrator/system_settings/presentation/widgets/heading_type_button_widget.dart';
import 'package:mighty_school/feature/id_card/logic/id_card_controller.dart';
import 'package:mighty_school/feature/profile/logic/profile_controller.dart';
import 'package:mighty_school/util/app_constants.dart';
import 'package:mighty_school/util/dimensions.dart';

class IdCardTypeSelectionWidget extends StatelessWidget {
  const IdCardTypeSelectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<IdCardController>(
      builder: (idCardController) {
        Map<String, dynamic> data = {
          "institute_id": Get.find<ProfileController>().profileModel?.data?.instituteId,
          "branch_id": Get.find<ProfileController>().currentBranch
        };
        String jsonString = jsonEncode(data);
        String base64Encoded = base64Encode(utf8.encode(jsonString));
        return Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
          child: SizedBox(height: 35,
            child: ListView(scrollDirection: Axis.horizontal, shrinkWrap: true,
                padding: EdgeInsets.zero, children: [
                HeadingTypeButtonWidget(title: "teacher_id".tr, selected: idCardController.idTypeIndex == 0,
                    onTap: () {


                      idCardController.setSelectedIdTypeIndex(0);
                      AppConstants.openUrl("${AppConstants.baseUrl}${AppConstants.teacherIdCard}/$base64Encoded");
                    }),
                  HeadingTypeButtonWidget(title: "staff_id".tr, selected: idCardController.idTypeIndex == 1,
                      onTap: () {
                        idCardController.setSelectedIdTypeIndex(1);
                        AppConstants.openUrl("${AppConstants.baseUrl}${AppConstants.staffIdCard}/$base64Encoded");
                      }),
                  HeadingTypeButtonWidget(title: "student_id".tr, selected: idCardController.idTypeIndex == 2,
                      onTap: () => idCardController.setSelectedIdTypeIndex(2)),
                ]),
          ),
        );
      }
    );
  }
}
