import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/feature/branch/controller/branch_controller.dart';
import 'package:mighty_school/feature/branch/presentation/widgets/change_branch_dropdown.dart';

class ChangeBranchWidget extends StatefulWidget {
  const ChangeBranchWidget({super.key});

  @override
  State<ChangeBranchWidget> createState() => _ChangeBranchWidgetState();
}

class _ChangeBranchWidgetState extends State<ChangeBranchWidget> {
  @override
  void initState() {
    if(Get.find<BranchController>().branchModel == null){
      Get.find<BranchController>().getBranchList(1);
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder<BranchController>(
        builder: (branchController) {
          return Padding(padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: ChangeBranchDropdown(width: Get.width,
              title: "${"branch".tr}: ${branchController.branchName??"".tr}",
              items: branchController.branchModel?.data?.data??[],
              selectedValue: branchController.selectedBranchItem,
              onChanged: (val){
                branchController.selectBranch(val!, change: true);
              },
            ),);
        }
    );
  }
}
