import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_contaner.dart';
import 'package:mighty_school/common/widget/edit_delete_section.dart';
import 'package:mighty_school/feature/routine_management/syllabus/controller/syllabus_controller.dart';
import 'package:mighty_school/feature/routine_management/syllabus/domain/models/syllabus_model.dart';
import 'package:mighty_school/feature/routine_management/syllabus/presentation/screens/create_new_syllabus_screen.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';

class SyllabusItemWidget extends StatelessWidget {
  final SyllabusItem? syllabusItem;
  final int index;
  const SyllabusItemWidget({super.key, this.syllabusItem, required this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault, vertical: 5),
      child: CustomContainer(child: Row(
        children: [
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text("${"name".tr} : ${syllabusItem?.title}", style: textMedium.copyWith(fontSize: Dimensions.fontSizeDefault),),
              const SizedBox(height: Dimensions.paddingSizeSmall,),
              Text("${"details".tr} : ${syllabusItem?.description??''}", style: textRegular.copyWith(),),
            ]),
          ),
          EditDeleteSection(onEdit: (){
            Get.to(()=> CreateNewSyllabusScreen(syllabusItem: syllabusItem));
          },
            onDelete: (){
            Get.find<SyllabusController>().deleteDepartment(syllabusItem!.id!);
          },)
        ],
      )),
    );
  }
}