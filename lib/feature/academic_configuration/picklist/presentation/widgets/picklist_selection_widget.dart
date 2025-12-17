import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_title.dart';
import 'package:mighty_school/feature/academic_configuration/picklist/controller/picklist_controller.dart';
import 'package:mighty_school/feature/academic_configuration/picklist/presentation/widgets/picklist_dropdown.dart';

class SelectPicklistWidget extends StatefulWidget {
  const SelectPicklistWidget({super.key});

  @override
  State<SelectPicklistWidget> createState() => _SelectPicklistWidgetState();
}

class _SelectPicklistWidgetState extends State<SelectPicklistWidget> {
  @override
  void initState() {
    if(Get.find<PickListController>().pickListModel == null){
      Get.find<PickListController>().getPickList(1);
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const CustomTitle(title: "designation"),
      GetBuilder<PickListController>(
          builder: (picklistController) {
            return Padding(padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: PicklistDropdown(width: Get.width, title: "select".tr,
                items: picklistController.pickListModel?.data?.data??[],
                selectedValue: picklistController.selectedPicklistItem,
                onChanged: (val){
                  picklistController.selectPicklistItem(val!);
                },
              ),);
          }
      ),
    ],);
  }
}
