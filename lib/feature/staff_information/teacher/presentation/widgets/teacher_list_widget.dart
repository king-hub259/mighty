import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/layout/list_layout_widget.dart';
import 'package:mighty_school/feature/staff_information/teacher/controller/teacher_controller.dart';
import 'package:mighty_school/feature/staff_information/teacher/presentation/widgets/add_new_teacher_widget.dart';
import 'package:mighty_school/feature/staff_information/teacher/presentation/widgets/teacher_item.dart';

import '../../domain/model/teacher_model.dart';


class TeacherListWidget extends StatelessWidget {
  final ScrollController scrollController;
  const TeacherListWidget({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TeacherController>(
      initState: (val) => Get.find<TeacherController>().getTeacherList(1),
      builder: (teacherController) {
        TeacherModel? teacherModel = teacherController.teacherModel;
        final teacherData = teacherModel?.data;
        return GenericListSection<TeacherItem>(
          sectionTitle: "staff_information".tr,
          pathItems: ["teacher_list".tr],
          addNewTitle: "add_new_teacher".tr,
          onAddNewTap: () => Get.dialog(const Dialog(child: AddNewTeacherWidget(fromStaff: false))),
          headings: const ["image", "name", "phone", "email", "designation", "action"],
          scrollController: scrollController,
          isLoading: teacherModel == null,
          totalSize: teacherData?.total ?? 0,
          offset: teacherData?.currentPage ?? 0,
          onPaginate: (offset) async =>
          await teacherController.getTeacherList(offset ?? 1),
          items: teacherData?.data ?? [],
          itemBuilder: (item, index) => TeacherItemWidget(index: index, teacherItem: item),
        );
      },
    );
  }
}
