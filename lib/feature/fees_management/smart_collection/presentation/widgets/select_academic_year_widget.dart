import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_dropdown.dart';
import 'package:mighty_school/common/widget/custom_title.dart';
import 'package:mighty_school/feature/fees_management/smart_collection/controller/smart_collection_controller.dart';

class SelectAcademicYearWidget extends StatelessWidget {
  const SelectAcademicYearWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SmartCollectionController>(
        builder: (smartCollectionController) {
          return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const CustomTitle(title: "academic_year", isRequired: true,),
            Padding(padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: CustomDropdown(width: Get.width, title: "select".tr,
                items: smartCollectionController.academicYears,
                selectedValue: smartCollectionController.selectedYear,
                onChanged: (val){
                  smartCollectionController.setSelectedYear(val!);
                },
              ),),
          ],);
        }
    );
  }
}
