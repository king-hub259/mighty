import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/confirmation_dialog.dart';
import 'package:mighty_school/common/widget/custom_contaner.dart';
import 'package:mighty_school/common/widget/edit_delete_section.dart';
import 'package:mighty_school/common/widget/numbering_widget.dart';
import 'package:mighty_school/feature/academic_configuration/picklist/controller/picklist_controller.dart';
import 'package:mighty_school/feature/academic_configuration/picklist/domain/models/pick_list_model.dart';
import 'package:mighty_school/feature/academic_configuration/picklist/presentation/screens/create_new_picklist_screen.dart';
import 'package:mighty_school/helper/responsive_helper.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';

class PickListItemWidget extends StatelessWidget {
  final PickListItem? pickListItem;
  final int index;
  const PickListItemWidget({super.key, this.pickListItem, required this.index});

  @override
  Widget build(BuildContext context) {
    return ResponsiveHelper.isDesktop(context)?
      Padding(padding: const EdgeInsets.fromLTRB(Dimensions.paddingSizeDefault, Dimensions.paddingSizeDefault, Dimensions.paddingSizeDefault, 0),
        child: Row(spacing: Dimensions.paddingSizeDefault, crossAxisAlignment: CrossAxisAlignment.start, children: [

          NumberingWidget(index: index),
          Expanded(child: Text(pickListItem?.type??'', style: textRegular.copyWith())),
          Expanded(child: Text(pickListItem?.value??'', style: textRegular.copyWith())),
          EditDeleteSection(horizontal: true, onDelete: (){
            Get.dialog(ConfirmationDialog(title: "picklist", content: "picklist",
              onTap: (){
                Get.back();
                Get.find<PickListController>().deletePickList(pickListItem!.id!);
              },));

          }, onEdit: (){
            Get.dialog(CreateNewPickListScreen(pickListItem: pickListItem));
          },)
        ],
        ),
      ):
      Padding(padding: const EdgeInsets.fromLTRB(Dimensions.paddingSizeDefault, Dimensions.paddingSizeDefault, Dimensions.paddingSizeDefault, 0),
        child: CustomContainer(child: Row(
          children: [
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text("${"type".tr} : ${pickListItem?.type}", style: textMedium.copyWith(fontSize: Dimensions.fontSizeDefault),),
              const SizedBox(height: Dimensions.paddingSizeSmall,),
              Text("${"value".tr} : ${pickListItem?.value??''}", style: textRegular.copyWith(),),
            ]),
            ),
            EditDeleteSection(onDelete: (){
              Get.dialog(ConfirmationDialog(
                title: "picklist",
                content: "picklist",
                onTap: (){
                  Get.back();
                  Get.find<PickListController>().deletePickList(pickListItem!.id!);
                },));

            }, onEdit: (){
              Get.dialog(CreateNewPickListScreen(pickListItem: pickListItem));
            },)
          ],
        )),
      );
  }
}