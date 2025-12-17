import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_contaner.dart';
import 'package:mighty_school/feature/academic_configuration/session/presentation/widgets/session_change_widget.dart';
import 'package:mighty_school/feature/branch/presentation/widgets/branch_change_widget.dart';

class UpdateBranchAndSessionWidget extends StatelessWidget {
  const UpdateBranchAndSessionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomSheet(showDragHandle: true,
        onClosing: (){
      Get.back();
    }, builder: (_){
      return CustomContainer(width: Get.width,showShadow: false,
        child: const Column(mainAxisSize: MainAxisSize.min,
        children: [
            SizedBox(width: 250, child: ChangeBranchWidget()),
            SizedBox(width: 200, child: ChangeSessionWidget()),

      ],),);
    });
  }
}
