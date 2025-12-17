import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/confirmation_dialog.dart';
import 'package:mighty_school/common/widget/custom_contaner.dart';
import 'package:mighty_school/common/widget/custom_image.dart';
import 'package:mighty_school/common/widget/edit_delete_section.dart';
import 'package:mighty_school/common/widget/numbering_widget.dart';
import 'package:mighty_school/feature/academic_configuration/subject/controller/subject_controller.dart';
import 'package:mighty_school/feature/academic_configuration/subject/domain/model/subject_model.dart';
import 'package:mighty_school/helper/responsive_helper.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';

class SubjectItemWidget extends StatelessWidget {
  final SubjectItem? subjectItem;
  final int index;
  const SubjectItemWidget({super.key, this.subjectItem, required this.index});

  @override
  Widget build(BuildContext context) {
    return ResponsiveHelper.isDesktop(context)?
      Padding(padding: const EdgeInsets.fromLTRB(Dimensions.paddingSizeDefault, Dimensions.paddingSizeDefault, Dimensions.paddingSizeDefault, 0),
        child: Row(spacing: Dimensions.paddingSizeDefault, crossAxisAlignment: CrossAxisAlignment.start, children: [

          NumberingWidget(index: index),
          Expanded(child: Text("${subjectItem?.subjectName}", style: textRegular.copyWith())),
          Expanded(child: Text(subjectItem?.subjectCode??'', style: textRegular.copyWith(),)),
          Expanded(child: Text(subjectItem?.className??'', style: textRegular.copyWith(),)),
          Expanded(child: Text(subjectItem?.fullMark??'', style: textRegular.copyWith(),)),
          Expanded(child: Text(subjectItem?.passMark??'', style: textRegular.copyWith(),)),
          EditDeleteSection(horizontal: true, onDelete: (){
            Get.dialog(ConfirmationDialog(title: "subject", content: "subject",
              onTap: (){
                Get.back();
                Get.find<SubjectController>().deleteSubject(subjectItem!.id!);
              },));

          }, onEdit: (){
            // TODO: Add edit functionality
          },)
        ],
        ),
      ):
      Padding(padding: const EdgeInsets.fromLTRB(Dimensions.paddingSizeDefault, Dimensions.paddingSizeDefault, Dimensions.paddingSizeDefault, 0),
        child: CustomContainer(child: Row(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(borderRadius: BorderRadius.circular(120),
                child: const CustomImage(width: Dimensions.imageSizeBig, height: Dimensions.imageSizeBig, image: "")),
            const SizedBox(width: Dimensions.paddingSizeSmall),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text("${subjectItem?.subjectName}", style: textMedium.copyWith(fontSize: Dimensions.fontSizeDefault),),
              Text("${"code".tr} : ${subjectItem?.subjectCode??''}", style: textRegular.copyWith(),),
              Text("${"class".tr} : ${subjectItem?.className??''}", style: textRegular.copyWith(),),
              Text("${"full_mark".tr} : ${subjectItem?.fullMark??''}", style: textRegular.copyWith(),),
              const SizedBox(height: Dimensions.paddingSizeExtraSmall),
              Text("${"pass_mark".tr} : ${subjectItem?.passMark??''}", style: textRegular.copyWith(),),
              const SizedBox(height: Dimensions.paddingSizeExtraSmall),

            ]),
            ),
            EditDeleteSection(onDelete: (){
              Get.dialog(ConfirmationDialog(title: "subject", content: "subject",
                onTap: (){
                  Get.back();
                  Get.find<SubjectController>().deleteSubject(subjectItem!.id!);
                },));

            }, onEdit: (){
              // TODO: Add edit functionality
            },)

          ],
        )),
      );
  }
}