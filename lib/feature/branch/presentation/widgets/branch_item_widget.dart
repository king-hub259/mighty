import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/confirmation_dialog.dart';
import 'package:mighty_school/common/widget/custom_contaner.dart';
import 'package:mighty_school/common/widget/edit_delete_section.dart';
import 'package:mighty_school/common/widget/numbering_widget.dart';
import 'package:mighty_school/feature/branch/controller/branch_controller.dart';
import 'package:mighty_school/feature/branch/domain/models/branch_model.dart';
import 'package:mighty_school/feature/branch/presentation/screens/create_new_branch_screen.dart';
import 'package:mighty_school/feature/branch/presentation/widgets/create_new_branch_widget.dart';
import 'package:mighty_school/helper/responsive_helper.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';

class BranchItemWidget extends StatelessWidget {
  final BranchItem? branchItem;
  final int index;
  const BranchItemWidget({super.key, this.branchItem, required this.index,});

  @override
  Widget build(BuildContext context) {
    return ResponsiveHelper.isDesktop(context)?
    Row(spacing: Dimensions.paddingSizeDefault, children: [
     NumberingWidget(index: index),
      Expanded(child: Text("${branchItem?.name}", style: textMedium.copyWith(fontSize: Dimensions.fontSizeDefault),)),

        EditDeleteSection(horizontal: true, onEdit: (){
          Get.dialog(CreateNewBranchWidget(branchItem: branchItem));
        },
          onDelete: (){
            Get.dialog(ConfirmationDialog(
              title: "branch",
              content: "branch",
              onTap: (){
                Get.back();
                Get.find<BranchController>().deleteBranch(branchItem!.id!);
              },));

          },)
      ],
    ) :
    CustomContainer(borderRadius: Dimensions.paddingSizeExtraSmall,
      child: Row(spacing: Dimensions.paddingSizeExtraSmall, children: [
          NumberingWidget(index: index),
          Expanded(child: Text("${branchItem?.name}", style: textMedium.copyWith(fontSize: Dimensions.fontSizeDefault),),),
          EditDeleteSection(horizontal: true, onEdit: (){
            Get.dialog(CreateNewBranchScreen(branchItem: branchItem));
          },
            onDelete: (){
              Get.dialog(ConfirmationDialog(
                title: "branch",
                content: "branch",
                onTap: (){
                  Get.back();
                  Get.find<BranchController>().deleteBranch(branchItem!.id!);
                },));

          },)
        ],
      ),
    );
  }
}