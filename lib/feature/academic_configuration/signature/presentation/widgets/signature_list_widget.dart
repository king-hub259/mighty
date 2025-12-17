import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/layout/list_layout_widget.dart';
import 'package:mighty_school/feature/academic_configuration/signature/controller/signature_controller.dart';
import 'package:mighty_school/feature/academic_configuration/signature/domain/models/signature_list_model.dart';
import 'package:mighty_school/feature/academic_configuration/signature/presentation/screens/create_new_signature_screen.dart';
import 'package:mighty_school/feature/academic_configuration/signature/presentation/widgets/signature_item_widget.dart';

class SignatureListWidget extends StatelessWidget {
  final ScrollController scrollController;
  const SignatureListWidget({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SignatureController>(
      initState: (val) => Get.find<SignatureController>().getSignatureList(1),
      builder: (signatureController) {
        final signatureModel = signatureController.signatureModel;
        final signatureData = signatureModel?.data;

        return GenericListSection<SignatureItem>(
          sectionTitle: "academic_configuration".tr,
          pathItems: ["signature_list".tr],
          addNewTitle: "add_new_signature".tr,
          onAddNewTap: () => Get.dialog(const CreateNewSignatureScreen()),
          headings: const ["image", "name","position", "action"],

          scrollController: scrollController,
          isLoading: signatureModel == null,
          totalSize: signatureData?.total ?? 0,
          offset: signatureData?.currentPage ?? 0,
          onPaginate: (offset) async => await signatureController.getSignatureList(offset ?? 1),
          items: signatureData?.data ?? [],
          itemBuilder: (item, index) => SignatureItemWidget(index: index, signatureItem: item),
        );
      },
    );
  }
}