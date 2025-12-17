import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_contaner.dart';
import 'package:mighty_school/common/widget/custom_image.dart';
import 'package:mighty_school/common/widget/edit_delete_section.dart';
import 'package:mighty_school/common/widget/numbering_widget.dart';
import 'package:mighty_school/feature/administrator/system_settings/controller/system_settngs_controller.dart';
import 'package:mighty_school/feature/profile/logic/profile_controller.dart';
import 'package:mighty_school/feature/students_information/student/domain/model/student_model.dart';
import 'package:mighty_school/feature/students_information/student/presentation/screens/add_new_student_screen.dart';
import 'package:mighty_school/helper/responsive_helper.dart';
import 'package:mighty_school/util/app_constants.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/images.dart';
import 'package:mighty_school/util/styles.dart';

class StudentItemWidget extends StatelessWidget {
  final StudentItem? studentItem;
  final int index;
  final bool isAll;
  const StudentItemWidget({super.key, this.studentItem, required this.index, this.isAll = false});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.symmetric(vertical: 5),
      child: ResponsiveHelper.isDesktop(context)?
      Row(crossAxisAlignment: CrossAxisAlignment.start, spacing: Dimensions.paddingSizeSmall, children: [
        NumberingWidget(index: index),
          ClipRRect(borderRadius: BorderRadius.circular(120),
              child:  CustomImage(width: 25, height: 25, image: "${AppConstants.baseUrl}/storage/users/${studentItem?.image}")),
          Expanded(child: Text(studentItem?.roll??'', style: textRegular.copyWith(),)),
          Expanded(child: Text("${studentItem?.name}", maxLines: 1,overflow: TextOverflow.ellipsis,
            style: textRegular.copyWith(fontSize: Dimensions.fontSizeDefault),)),
          Expanded(child: Text(studentItem?.phone??'N/A', style: textRegular.copyWith(),)),
          Expanded(child: Text(studentItem?.gender??'N/A', style: textRegular.copyWith(),)),
          Expanded(child: Text(studentItem?.fatherName??'N/A',maxLines: 1,overflow: TextOverflow.ellipsis, style: textRegular.copyWith(),)),
          Expanded(
            child: Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
              child: Text(studentItem?.status == "1"? "Active" : "Inactive", maxLines: 1,overflow: TextOverflow.ellipsis,
                style: textSemiBold.copyWith(color: studentItem?.status == "1"? Colors.green : Colors.red)),
            ),
          ),
        IconButton(onPressed: (){
          Map<String, dynamic> data = {
            "institute_id": Get.find<ProfileController>().profileModel?.data?.instituteId,
            "branch_id": Get.find<ProfileController>().currentBranch,
            "student_id": studentItem?.id
          };


          String jsonString = jsonEncode(data);
          String base64Encoded = base64Encode(utf8.encode(jsonString));

          AppConstants.openUrl("${AppConstants.baseUrl}${AppConstants.resultCard}/$base64Encoded");
        }, icon:  SizedBox(width: 25, child: Image.asset( Images.examResults, color: Theme.of(context).hintColor)))
        ]):

      CustomContainer(child: Row(crossAxisAlignment: CrossAxisAlignment.start,  spacing: Dimensions.paddingSizeSmall, children: [
          ClipRRect(borderRadius: BorderRadius.circular(120),
              child: const CustomImage(width: Dimensions.imageSizeBig, height: Dimensions.imageSizeBig, image: "")),

          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text("${studentItem?.name}", style: textMedium.copyWith(fontSize: Dimensions.fontSizeDefault),),
            Text("${"roll".tr} : ${studentItem?.roll??''}", style: textRegular.copyWith(),),
            Text("${"phone".tr} : ${studentItem?.phone??''}", style: textRegular.copyWith(),),
            const SizedBox(height: Dimensions.paddingSizeExtraSmall),


          ])),
          if(!isAll)
          EditDeleteSection(onEdit: (){
            Get.to(()=> const AddNewStudentScreen());
          })

        ],
      )),
    );
  }
}