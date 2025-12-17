import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/layout/list_layout_widget.dart';
import 'package:mighty_school/feature/cms_management/academic_image/domain/model/academic_image_model.dart';
import 'package:mighty_school/feature/cms_management/academic_image/logic/academic_image_controller.dart';
import 'package:mighty_school/feature/cms_management/academic_image/presentation/widgets/academic_image_item_widget.dart';
import 'package:mighty_school/feature/cms_management/academic_image/presentation/widgets/create_new_academic_image_widget.dart';
import 'package:mighty_school/helper/responsive_helper.dart';

class AcademicImageListWidget extends StatelessWidget {
  final ScrollController scrollController;
  const AcademicImageListWidget({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AcademicImageController>(
      initState: (val) => Get.find<AcademicImageController>().getAcademicImage(1),
      builder: (academicImageController) {
        final academicImageModel = academicImageController.academicImageModel;
        final academicImageData = academicImageModel?.data;

        return GenericListSection<AcademicImageItem>(
          sectionTitle: "cms_management".tr,
          pathItems: ["academic_image".tr],
          addNewTitle: "add".tr,
          onAddNewTap: () => Get.dialog(Dialog(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: SizedBox(width: ResponsiveHelper.isDesktop(context) ? 600 : Get.width,
              child: const Padding(padding: EdgeInsets.all(16.0),
                child: CreateNewAcademicImageWidget())))),
          headings: const ["image", "title"],

          scrollController: scrollController,
          isLoading: academicImageModel == null,
          totalSize: academicImageData?.total ?? 0,
          offset: academicImageData?.currentPage ?? 1,
          onPaginate: (offset) async => await academicImageController.getAcademicImage(offset ?? 1),

          items: academicImageData?.data ?? [],
          itemBuilder: (item, index) => AcademicImageItemWidget(academicImageItem: item, index: index),
        );
      },
    );
  }
}