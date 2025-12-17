import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_contaner.dart';
import 'package:mighty_school/common/widget/custom_image.dart';
import 'package:mighty_school/common/widget/edit_delete_section.dart';
import 'package:mighty_school/common/widget/numbering_widget.dart';
import 'package:mighty_school/feature/students_information/student/domain/model/student_model.dart';
import 'package:mighty_school/helper/responsive_helper.dart';
import 'package:mighty_school/util/app_constants.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';

class AllStudentItemWidget extends StatelessWidget {
  final StudentItem? studentItem;
  final int index;
  final bool isAll;
  const AllStudentItemWidget({super.key, this.studentItem, required this.index, this.isAll = false});

  @override
  Widget build(BuildContext context) {
    log("logo ==> ${"${AppConstants.baseUrl}/storage/users/${studentItem?.image}"}");
    bool enable = studentItem?.status == "1";
    return ResponsiveHelper.isDesktop(context)?
    Row(crossAxisAlignment: CrossAxisAlignment.center, spacing: Dimensions.paddingSizeSmall, children: [
       NumberingWidget(index: index),

        SizedBox(width: 50, child: Center(child: ClipRRect(borderRadius: BorderRadius.circular(120),
            child: CustomImage(width: 25, height: 25, image: "${AppConstants.baseUrl}/storage/users/${studentItem?.image}" )),)),
        Expanded(child: Text(studentItem?.roll??'', style: textRegular.copyWith(),)),
        Expanded(child: Text("${studentItem?.name}", maxLines: 1,overflow: TextOverflow.ellipsis,
          style: textRegular.copyWith(fontSize: Dimensions.fontSizeDefault),)),
        Expanded(child: Text(studentItem?.phone??'', style: textRegular.copyWith(),)),
        Expanded( child: Text(studentItem?.gender??'', style: textRegular.copyWith(),)),
        Expanded(child:  Text(studentItem?.sectionName??'N/A', style: textRegular.copyWith())),
        Expanded(child: Text(studentItem?.className??'N/A', style: textRegular.copyWith(),)),
        Expanded(child: Text(studentItem?.fatherName??'',maxLines: 1,overflow: TextOverflow.ellipsis, style: textRegular.copyWith(),)),


        if(!isAll)
          CustomContainer(borderRadius: 123,
              verticalPadding: 2, horizontalPadding: 7,
              color: enable? Colors.green : Colors.red,
              child: Center(child: Text(enable? "enable".tr : "disable",
                    style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: enable? Colors.white : Colors.black)),)),
        const SizedBox(width: Dimensions.paddingSizeSmall),
        if(!isAll)
        EditDeleteSection(horizontal: studentItem?.status == "1", onEdit: (){},
          onChange: (val){

          })
      ]):

    CustomContainer(child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        ClipRRect(borderRadius: BorderRadius.circular(120),
            child: const CustomImage(width: Dimensions.imageSizeBig, height: Dimensions.imageSizeBig, image: "")),
        const SizedBox(width: Dimensions.paddingSizeSmall),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("${studentItem?.name}", style: textMedium.copyWith(fontSize: Dimensions.fontSizeDefault),),
          Text("${"roll".tr} : ${studentItem?.roll??''}", style: textRegular.copyWith(),),
          Text("${"phone".tr} : ${studentItem?.phone??''}", style: textRegular.copyWith(),),
          const SizedBox(height: Dimensions.paddingSizeExtraSmall),
          if(!isAll)
          CustomContainer(borderRadius: Dimensions.paddingSizeExtraSmall,
              verticalPadding: 5,
              color: enable? Colors.green : Colors.red,
              child: Text(enable? "enable".tr : "disable",
              style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall)))

        ])),
        if(!isAll)
        EditDeleteSection(onEdit: (){},
        onChange: (val){

        },)

      ],
    ));
  }
}