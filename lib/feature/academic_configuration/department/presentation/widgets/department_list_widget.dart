import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/layout/list_layout_widget.dart';
import 'package:mighty_school/feature/academic_configuration/department/controller/department_controller.dart';
import 'package:mighty_school/feature/academic_configuration/department/domain/models/department_model.dart';
import 'package:mighty_school/feature/academic_configuration/department/presentation/screens/create_new_department_screen.dart';
import 'package:mighty_school/feature/academic_configuration/department/presentation/widgets/department_item_widget.dart';

class DepartmentListWidget extends StatelessWidget {
  final ScrollController scrollController;
  const DepartmentListWidget({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DepartmentController>(
      initState: (val) => Get.find<DepartmentController>().getDepartmentList(1),
      builder: (departmentController) {
        final departmentModel = departmentController.departmentModel;
        final departmentData = departmentModel?.data;

        return GenericListSection<DepartmentItem>(
          sectionTitle: "academic_configuration".tr,
          pathItems: ["department_list".tr],
          addNewTitle: "add_new_department".tr,
          onAddNewTap: () => Get.dialog(const CreateNewDepartmentScreen()),
          headings: const ["name", "priority", "action"],

          scrollController: scrollController,
          isLoading: departmentModel == null,
          totalSize: departmentData?.total ?? 0,
          offset: departmentData?.currentPage ?? 0,
          onPaginate: (offset) async =>
          await departmentController.getDepartmentList(offset ?? 1),

          items: departmentData?.data ?? [],
          itemBuilder: (item, index) => DepartmentItemWidget(
            index: index,
            departmentItem: item,
          ),
        );
      },
    );
  }
}