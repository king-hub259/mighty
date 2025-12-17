import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/layout/list_layout_widget.dart';
import 'package:mighty_school/feature/academic_configuration/class/controller/class_controller.dart';
import 'package:mighty_school/feature/academic_configuration/class/domain/model/class_model.dart';
import 'package:mighty_school/feature/academic_configuration/class/presentation/screens/create_new_class_dialog.dart';
import 'package:mighty_school/feature/academic_configuration/class/presentation/widgets/class_item.dart';

class ClassListWidget extends StatelessWidget {
  final ScrollController scrollController;
  const ClassListWidget({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ClassController>(
      initState: (val) => Get.find<ClassController>().getClassList(page: 1),
      builder: (classController) {
        final classModel = classController.classModel;
        final classData = classModel?.data;

        return GenericListSection<ClassItem>(
          sectionTitle: "academic_configuration".tr,
          pathItems: ["class_list".tr],
          addNewTitle: "add_new_class".tr,
          onAddNewTap: () => Get.dialog(const CreateNewClassScreen()),
          headings: const ["class", "action"],

          scrollController: scrollController,
          isLoading: classModel == null,
          totalSize: classData?.total ?? 0,
          offset: classData?.currentPage ?? 0,
          onPaginate: (offset) async => await classController.getClassList(page: offset ?? 1),

          items: classData?.data ?? [],
          itemBuilder: (item, index) => ClassWidget(classItem: item, index: index),
        );
      },
    );
  }
}