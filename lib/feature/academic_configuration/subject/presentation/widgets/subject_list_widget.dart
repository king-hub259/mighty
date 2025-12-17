import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/layout/list_layout_widget.dart';
import 'package:mighty_school/feature/academic_configuration/subject/controller/subject_controller.dart';
import 'package:mighty_school/feature/academic_configuration/subject/domain/model/subject_model.dart';
import 'package:mighty_school/feature/academic_configuration/subject/presentation/widgets/subject_item_widget.dart';
import 'package:mighty_school/helper/route_helper.dart';

class SubjectListWidget extends StatelessWidget {
  final ScrollController scrollController;
  const SubjectListWidget({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SubjectController>(
      initState: (val) => Get.find<SubjectController>().getSubjectList(1),
      builder: (subjectController) {
        final subjectModel = subjectController.subjectModel;
        final subjectData = subjectModel?.data;

        return GenericListSection<SubjectItem>(
          sectionTitle: "academic_configuration".tr,
          pathItems: ["subject_list".tr],
          addNewTitle: "add_new_subject".tr,
          onAddNewTap: () => Get.toNamed(RouteHelper.getAddNewSubjectRoute()),
          headings: const ["name", "code", "class", "full_mark", "pass_mark", "action"],

          scrollController: scrollController,
          isLoading: subjectModel == null,
          totalSize: subjectData?.total ?? 0,
          offset: subjectData?.currentPage ?? 1,
          onPaginate: (offset) async => await subjectController.getSubjectList(offset ?? 1),

          items: subjectData?.data ?? [],
          itemBuilder: (item, index) => SubjectItemWidget(index: index, subjectItem: item),
        );
      },
    );
  }
}