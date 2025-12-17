import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_title.dart';
import 'package:mighty_school/feature/fees_management/fees_sub_head/controller/fees_sub_head_controller.dart';
import 'package:mighty_school/feature/fees_management/fees_sub_head/presentation/widgets/fees_sub_head_dropdown_widget.dart';

class SelectFeesSubHeadWidget extends StatefulWidget {
  const SelectFeesSubHeadWidget({super.key});

  @override
  State<SelectFeesSubHeadWidget> createState() => _SelectFeesSubHeadWidgetState();
}

class _SelectFeesSubHeadWidgetState extends State<SelectFeesSubHeadWidget> {
  @override
  void initState() {
    if(Get.find<FeesSubHeadController>().feesSubHeadModel == null){
      Get.find<FeesSubHeadController>().getFeesSubHeadList(1);
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const CustomTitle(title: "fees_sub_head"),
      GetBuilder<FeesSubHeadController>(
          builder: (feesSubHeadController) {
            return Padding(padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: FeesSubHeadDropdown(width: Get.width, title: "select".tr,
                items: feesSubHeadController.feesSubHeadModel?.data?.data??[],
                selectedValue: feesSubHeadController.selectedFeesSubHeadItem,
                onChanged: (val){
                  feesSubHeadController.selectFeesSubHeadItem(val!);
                },
              ),);
          }
      ),
    ],);
  }
}
