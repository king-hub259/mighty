import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_title.dart';
import 'package:mighty_school/feature/academic_configuration/department/controller/department_controller.dart';
import 'package:mighty_school/feature/academic_configuration/department/presentation/widgets/department_dropdown.dart';

class SelectDepartmentWidget extends StatefulWidget {
  const SelectDepartmentWidget({super.key});

  @override
  State<SelectDepartmentWidget> createState() => _SelectDepartmentWidgetState();
}

class _SelectDepartmentWidgetState extends State<SelectDepartmentWidget> {
  @override
  void initState() {
    if(Get.find<DepartmentController>().departmentModel == null){
      Get.find<DepartmentController>().getDepartmentList(1);
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const CustomTitle(title: "department"),
      GetBuilder<DepartmentController>(
          builder: (departmentController) {
            return Padding(padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: DepartmentDropdown(width: Get.width, title: "select_department".tr,
                items: departmentController.departmentModel?.data?.data??[],
                selectedValue: departmentController.selectedDepartmentItem,
                onChanged: (val){
                  departmentController.selectDepartment(val!);
                },
              ),);
          }
      ),
    ],);
  }
}
