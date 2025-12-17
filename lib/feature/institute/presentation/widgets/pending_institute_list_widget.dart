import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/layout/list_layout_widget.dart';
import 'package:mighty_school/feature/institute/controller/institute_controller.dart';
import 'package:mighty_school/feature/institute/domain/models/pending_institute_model.dart';
import 'package:mighty_school/feature/institute/presentation/widgets/pending_institute_item_widget.dart';

class PendingInstituteListWidget extends StatelessWidget {
  final ScrollController scrollController;
  const PendingInstituteListWidget({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<InstituteController>(
      initState: (val) => Get.find<InstituteController>().getPendingInstituteList(1),
      builder: (instituteController) {
        final pendingInstituteModel = instituteController.pendingInstituteModel;
        final pendingInstituteData = pendingInstituteModel?.data;

        return GenericListSection<PendingInstituteItem>(
          sectionTitle: "institute".tr,
          pathItems: ["pending_institute".tr],

          headings: const [
            "institute",
            "domain",
            "phone",
            "email",
            "type",
            "action",
          ],

          scrollController: scrollController,
          isLoading: pendingInstituteModel == null,
          totalSize: pendingInstituteData?.total ?? 0,
          offset: pendingInstituteData?.currentPage ?? 0,
          onPaginate: (offset) async =>
          await instituteController.getPendingInstituteList(offset ?? 1),

          items: pendingInstituteData?.data ?? [],
          itemBuilder: (item, index) => PendingInstituteItemWidget(
            index: index,
            pendingInstituteItem: item,
          ),
        );
      },
    );
  }
}
