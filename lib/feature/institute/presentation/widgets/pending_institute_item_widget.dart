import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/confirmation_dialog.dart';
import 'package:mighty_school/common/widget/custom_button.dart';
import 'package:mighty_school/common/widget/custom_contaner.dart';
import 'package:mighty_school/common/widget/custom_divider.dart';
import 'package:mighty_school/common/widget/custom_item_text_widget.dart';
import 'package:mighty_school/common/widget/edit_delete_section.dart';
import 'package:mighty_school/common/widget/numbering_widget.dart';
import 'package:mighty_school/feature/institute/controller/institute_controller.dart';
import 'package:mighty_school/feature/institute/domain/models/pending_institute_model.dart';
import 'package:mighty_school/helper/responsive_helper.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';
import 'package:popover/popover.dart';

class PendingInstituteItemWidget extends StatelessWidget {
  final PendingInstituteItem? pendingInstituteItem;
  final int index;
  const PendingInstituteItemWidget({super.key, this.pendingInstituteItem, required this.index,  });

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault, vertical: 5),
      child: ResponsiveHelper.isDesktop(context)?
      Row(spacing: Dimensions.paddingSizeSmall, children: [
        NumberingWidget(index: index),
        Expanded(child: CustomItemTextWidget(text:"${pendingInstituteItem?.collectedData?.instituteName}",)),
        Expanded(child: CustomItemTextWidget(text:"${pendingInstituteItem?.collectedData?.instituteDomain}",)),
        Expanded(child: CustomItemTextWidget(text:"${pendingInstituteItem?.collectedData?.institutePhone}")),
        Expanded(child: CustomItemTextWidget(text:"${pendingInstituteItem?.collectedData?.instituteEmail}")),
        Expanded(child: CustomItemTextWidget(text:"${pendingInstituteItem?.collectedData?.instituteType}")),
          IconButton(onPressed: () {
            if (pendingInstituteItem?.id != null) {
              Get.find<InstituteController>().approveInstituteRequest(pendingInstituteItem!.id!);
            }
          }, icon:  const Icon(Icons.check, color: Colors.green))
        ]) :

      CustomContainer(borderRadius: Dimensions.paddingSizeExtraSmall,
        child: Row(spacing: Dimensions.paddingSizeSmall, children: [
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                CustomItemTextWidget(text:"${"institute".tr} : ${pendingInstituteItem?.collectedData?.instituteName}"),
                CustomItemTextWidget(text:"${"domain".tr} : ${pendingInstituteItem?.collectedData?.instituteDomain}"),
                CustomItemTextWidget(text:"${"email".tr} : ${pendingInstituteItem?.collectedData?.instituteEmail}"),
                CustomItemTextWidget(text:"${"phone".tr} : ${pendingInstituteItem?.collectedData?.institutePhone}"),
                CustomItemTextWidget(text:"${"type".tr} : ${pendingInstituteItem?.collectedData?.instituteType}"),

              ]),
            ),
          IconButton(onPressed: () {
            if (pendingInstituteItem?.id != null) {
              Get.find<InstituteController>().approveInstituteRequest(pendingInstituteItem!.id!);
            }
          }, icon:  const Icon(Icons.check, color: Colors.green))
          ],
        ),
      ),
    );
  }

}