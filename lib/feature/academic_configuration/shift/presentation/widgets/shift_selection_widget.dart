import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_title.dart';
import 'package:mighty_school/feature/academic_configuration/shift/controller/shift_controller.dart';
import 'package:mighty_school/feature/academic_configuration/shift/presentation/widgets/shift_dropdown.dart';

class SelectShiftWidget extends StatefulWidget {
  const SelectShiftWidget({super.key});

  @override
  State<SelectShiftWidget> createState() => _SelectShiftWidgetState();
}

class _SelectShiftWidgetState extends State<SelectShiftWidget> {
  @override
  void initState() {
    if(Get.find<ShiftController>().shiftModel == null){
      Get.find<ShiftController>().getShiftList();
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const CustomTitle(title: "shift"),
      GetBuilder<ShiftController>(
          builder: (shiftController) {
            return Padding(padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: ShiftDropdown(width: Get.width, title: "select".tr,
                items: shiftController.shiftModel?.data??[],
                selectedValue: shiftController.selectedShiftItem,
                onChanged: (val){
                  shiftController.selectShift(val!);
                },
              ),);
          }
      ),
    ],);
  }
}
