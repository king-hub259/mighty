import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/edit_delete_section.dart';
import 'package:mighty_school/common/widget/numbering_widget.dart';
import 'package:mighty_school/feature/academic_configuration/section/controller/section_controller.dart';
import 'package:mighty_school/feature/academic_configuration/section/domain/model/section_model.dart';
import 'package:mighty_school/feature/academic_configuration/section/presentation/screens/create_new_section_screen.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';

class SectionItemWidget extends StatelessWidget {
  final SectionItem? sectionItem;
  final int index;
  const SectionItemWidget({super.key, this.sectionItem, required this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault, vertical: Dimensions.paddingSizeSeven),
      child: Row(spacing: Dimensions.paddingSizeDefault, children: [
        NumberingWidget(index: index),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text("${sectionItem?.sectionName}", style: textMedium.copyWith(fontSize: Dimensions.fontSizeDefault),),
            ]),
          ),
          EditDeleteSection(horizontal: true, onEdit: (){
            Get.dialog(CreateNewSectionScreen(sectionItem: sectionItem));
          },
            onDelete: (){
            Get.find<SectionController>().deleteSection(sectionItem!.id!);
          },)
        ]),
    );
  }
}