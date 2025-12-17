import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:mighty_school/common/layout/list_layout_widget.dart';
import 'package:mighty_school/feature/exam_management/exam/controller/exam_controller.dart';
import 'package:mighty_school/feature/exam_management/exam/presentation/widgets/create_new_exam_dialog.dart';
import 'package:mighty_school/feature/exam_management/exam/presentation/widgets/exam_card_widget.dart';
import 'package:mighty_school/feature/exam_management/exam/domain/model/exam_model.dart';
import 'package:mighty_school/helper/responsive_helper.dart';
import 'package:mighty_school/util/dimensions.dart';
  class ExamListviewWidget extends StatelessWidget {
    final ScrollController scrollController;
    const ExamListviewWidget({super.key, required this.scrollController});

    @override
    Widget build(BuildContext context) {
      return GetBuilder<ExamController>(
        initState: (val) => Get.find<ExamController>().getExamList(1),
        builder: (examController) {
          final examModel = examController.examModel;
          final examData = examModel?.data;

          return GenericListSection<ExamItem>(
            sectionTitle: "exam_management".tr,
            pathItems: ["exam".tr],
            addNewTitle: "add_new_exam".tr,
            onAddNewTap: () => Get.dialog(Dialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              child: SizedBox(
                width: ResponsiveHelper.isDesktop(context) ? 600 : Get.width,
                child: const Padding(padding: EdgeInsets.all(Dimensions.paddingSizeDefault),
                  child: CreateNewExamDialog(),
                ),
              ),
            )),
            headings: const ["name", "subject", "action"],
            scrollController: scrollController,
            isLoading: examModel == null,
            totalSize: examData?.total ?? 0,
            offset: examData?.currentPage ?? 1,
            onPaginate: (offset) async => await examController.getExamList(offset ?? 1),
            items: examData?.data ?? [],
            itemBuilder: (item, index) => ExamCardWidget(examItem: item, index: index),
          );
        },
      );
    }
  }