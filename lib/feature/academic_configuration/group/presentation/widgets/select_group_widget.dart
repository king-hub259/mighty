import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_title.dart';
import 'package:mighty_school/feature/academic_configuration/group/controller/group_controller.dart';
import 'package:mighty_school/feature/academic_configuration/group/presentation/widgets/group_dropdown.dart';

class SelectGroupWidget extends StatefulWidget {
  const SelectGroupWidget({super.key});

  @override
  State<SelectGroupWidget> createState() => _SelectGroupWidgetState();
}

class _SelectGroupWidgetState extends State<SelectGroupWidget> {
  @override
  void initState() {
    if(Get.find<GroupController>().groupModel == null){
      Get.find<GroupController>().getGroupList(1);
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
      const CustomTitle(title: "group"),
      GetBuilder<GroupController>(
          builder: (groupController) {
            return Padding(padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: GroupDropdown(width: Get.width, title: "select".tr,
                items: groupController.groupModel?.data?.data??[],
                selectedValue: groupController.groupItem,
                onChanged: (val){
                  groupController.setSelectedGroupItem(val!);
                },
              ),);
          }
      ),
    ],);
  }
}
