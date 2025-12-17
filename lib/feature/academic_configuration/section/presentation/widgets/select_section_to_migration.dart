import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_title.dart';
import 'package:mighty_school/feature/academic_configuration/section/controller/section_controller.dart';
import 'package:mighty_school/feature/academic_configuration/section/presentation/widgets/section_dropdown.dart';

class SelectSectionToMigrationWidget extends StatefulWidget {
  final bool fromMigration;
  const SelectSectionToMigrationWidget({super.key,  this.fromMigration = false});

  @override
  State<SelectSectionToMigrationWidget> createState() => _SelectSectionToMigrationWidgetState();
}

class _SelectSectionToMigrationWidgetState extends State<SelectSectionToMigrationWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const CustomTitle(title: "section"),
      GetBuilder<SectionController>(
          builder: (sectionController) {
            return Padding(padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: SectionDropdown(width: Get.width, title: "select".tr,
                items: sectionController.sectionModelForMigration?.data?.data??[],
                selectedValue: widget.fromMigration? sectionController.selectedSectionItemForMigration : sectionController.selectedSectionItem,
                onChanged: (val){
                  sectionController.setSelectSectionItem(val!, isMigration: widget.fromMigration);
                },
              ),);
          }
      ),
    ],);
  }
}
