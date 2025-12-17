import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_title.dart';
import 'package:mighty_school/feature/academic_configuration/class/controller/class_controller.dart';
import 'package:mighty_school/feature/academic_configuration/class/presentation/widgets/class_dropdown.dart';

class SelectClassWidgetToMigrationWidget extends StatefulWidget {
  final String? title;
  final bool fromMigration;
  const SelectClassWidgetToMigrationWidget({super.key, this.title, this.fromMigration = false});

  @override
  State<SelectClassWidgetToMigrationWidget> createState() => _SelectClassWidgetToMigrationWidgetState();
}

class _SelectClassWidgetToMigrationWidgetState extends State<SelectClassWidgetToMigrationWidget> {
  @override
  void initState() {
    if(Get.find<ClassController>().classModel == null){
      Get.find<ClassController>().getClassList(perPage: 100);
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      if(widget.title != "empty")
       CustomTitle(title: widget.title?? "class"),
      GetBuilder<ClassController>(
          builder: (classController) {
            return Padding(padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: ClassDropdown(width: Get.width, title: "select_class".tr,
                items: classController.classModel?.data?.data??[],
                selectedValue:widget.fromMigration ? classController.selectedClassItemToMigration : classController.selectedClassItem,
                onChanged: (val){
                  classController.setSelectClass(val!, fromMigration: widget.fromMigration);
                },
              ),);
          }
      ),
    ],);
  }
}
