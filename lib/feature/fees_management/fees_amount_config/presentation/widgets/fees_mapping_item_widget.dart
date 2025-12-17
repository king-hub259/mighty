import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/confirmation_dialog.dart';
import 'package:mighty_school/common/widget/custom_contaner.dart';
import 'package:mighty_school/common/widget/edit_delete_section.dart';
import 'package:mighty_school/feature/fees_management/fees_mapping/domain/model/fees_mapping_model.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';

class FeesMappingItemWidget extends StatelessWidget {
  final FeesMappingItem? feesMappingItem;
  final int index;
  const FeesMappingItemWidget({super.key, this.feesMappingItem, required this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.fromLTRB(Dimensions.paddingSizeDefault, Dimensions.paddingSizeDefault, Dimensions.paddingSizeDefault, 0),
      child: CustomContainer(borderRadius: Dimensions.paddingSizeExtraSmall,

        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Expanded(child: Text('${feesMappingItem?.feeHead?.name}', style: textRegular.copyWith(),),),
          Expanded(child: Text('${feesMappingItem?.feeLedger?.ledgerName}', style: textRegular.copyWith(),),),
          EditDeleteSection(horizontal: true, onDelete: (){
            Get.dialog(ConfirmationDialog(
              title: "account",
              content: "account",
              onTap: (){
                Get.back();
                // Get.find<ClassController>().deleteClass(classItem!.id!);
              },));

          }, onEdit: (){
            //Get.dialog(CreateNewClassScreen(classItem: classItem));
          },)
        ],
        ),
      ),
    );
  }
}
