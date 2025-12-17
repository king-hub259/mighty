import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_title.dart';
import 'package:mighty_school/feature/fees_management/fees_head/controller/fees_head_controller.dart';
import 'package:mighty_school/feature/fees_management/fees_head/presentation/widgets/fees_head_dropdown_widget.dart';

class SelectFeesHeadWidget extends StatefulWidget {
  const SelectFeesHeadWidget({super.key});

  @override
  State<SelectFeesHeadWidget> createState() => _SelectFeesHeadWidgetState();
}

class _SelectFeesHeadWidgetState extends State<SelectFeesHeadWidget> {
  @override
  void initState() {
    if(Get.find<FeesHeadController>().feesHeadModel == null){
      Get.find<FeesHeadController>().getFeesHeadList(1);
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const CustomTitle(title: "fees_head"),
      GetBuilder<FeesHeadController>(
          builder: (feesHeadController) {
            return Padding(padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: FeesHeadDropdown(width: Get.width, title: "select".tr,
                items: feesHeadController.feesHeadModel?.data?.data?.toSet().toList()??[],
                selectedValue: feesHeadController.selectedFeesHeadItem,
                onChanged: (val){
                  feesHeadController.selectFeesHeadItem(val!);
                },
              ),);
          }
      ),
    ],);
  }
}
