import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_title.dart';
import 'package:mighty_school/feature/academic_configuration/period/controller/period_controller.dart';
import 'package:mighty_school/feature/academic_configuration/period/presentation/widgets/period_dropdown.dart';

class SelectPeriodWidget extends StatefulWidget {
  const SelectPeriodWidget({super.key});

  @override
  State<SelectPeriodWidget> createState() => _SelectPeriodWidgetState();
}

class _SelectPeriodWidgetState extends State<SelectPeriodWidget> {
  @override
  void initState() {
    if(Get.find<PeriodController>().periodModel == null){
      Get.find<PeriodController>().getPeriodList(1);
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const CustomTitle(title: "period"),
      GetBuilder<PeriodController>(
          builder: (periodController) {
            return Padding(padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: PeriodDropdown(width: Get.width, title: "select_period".tr,
                items: periodController.periodModel?.data?.data??[],
                selectedValue: periodController.selectedPeriodItem,
                onChanged: (val){
                  periodController.setSelectPeriodItem(val!);
                },
              ),);
          }
      ),
    ],);
  }
}
