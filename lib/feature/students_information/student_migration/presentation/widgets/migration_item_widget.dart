import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_contaner.dart';
import 'package:mighty_school/common/widget/custom_divider.dart';
import 'package:mighty_school/common/widget/custom_image.dart';
import 'package:mighty_school/feature/students_information/student/domain/model/student_model.dart';
import 'package:mighty_school/helper/responsive_helper.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';

class MigrationItemWidget extends StatelessWidget {
  final StudentItem? studentItem;
  final int index;
  final bool isAll;
  const MigrationItemWidget({super.key, this.studentItem, required this.index, this.isAll = false});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.symmetric(vertical: 5),
      child: ResponsiveHelper.isDesktop(context)?
      Column(
        children: [
          Row(crossAxisAlignment: CrossAxisAlignment.start, spacing: Dimensions.paddingSizeSmall, children: [
                SizedBox(width: 50, child: Text(studentItem?.roll??'', style: textRegular.copyWith(),)),
                ClipRRect(borderRadius: BorderRadius.circular(120),
                    child: const CustomImage(width: 25, height: 25, image: "")),
                Expanded(child: Text("${studentItem?.name}", style: textRegular.copyWith(fontSize: Dimensions.fontSizeDefault),)),
                Expanded(child: Text(studentItem?.phone??'', style: textRegular.copyWith(),)),
                SizedBox(width: 70, child: Text(studentItem?.gender??'', style: textRegular.copyWith(),)),
                Expanded(child: Text(studentItem?.section?.sectionName??'', style: textRegular.copyWith(),)),
                Expanded(child: Text(studentItem?.classItem?.className??'', style: textRegular.copyWith(),)),
                Expanded(child: Text(studentItem?.newRoll??'', style: textRegular.copyWith(),)),
              ]),
          const Padding(padding: EdgeInsets.symmetric(vertical:Dimensions.paddingSizeSmall), child: CustomDivider()),
        ],
      ):

      CustomContainer(child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        ClipRRect(borderRadius: BorderRadius.circular(120),
            child: const CustomImage(width: Dimensions.imageSizeBig, height: Dimensions.imageSizeBig, image: "")),
        const SizedBox(width: Dimensions.paddingSizeSmall),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("${studentItem?.name}", style: textMedium.copyWith(fontSize: Dimensions.fontSizeDefault),),
          Text("${"roll".tr} : ${studentItem?.roll??''}", style: textRegular.copyWith(),),
          Text("${"phone".tr} : ${studentItem?.phone??''}", style: textRegular.copyWith(),),
          const SizedBox(height: Dimensions.paddingSizeExtraSmall),

        ])),
      ],
      )),
    );
  }
}