import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_button.dart';
import 'package:mighty_school/common/widget/custom_contaner.dart';
import 'package:mighty_school/common/widget/custom_image.dart';
import 'package:mighty_school/common/widget/custom_item_text_widget.dart';
import 'package:mighty_school/common/widget/numbering_widget.dart';
import 'package:mighty_school/feature/payroll_management/due/presentation/widgets/due_payment_widget.dart';
import 'package:mighty_school/feature/staff_information/staff/domain/models/staff_model.dart';
import 'package:mighty_school/helper/responsive_helper.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';

class StaffItemWidget extends StatelessWidget {
  final StaffItem? staffItem;
  final int index;
  final bool duePayment;
  const StaffItemWidget({super.key, this.staffItem, required this.index, this.duePayment = false});

  @override
  Widget build(BuildContext context) {
    return ResponsiveHelper.isDesktop(context)?
    Row(spacing: Dimensions.paddingSizeDefault, children: [

      NumberingWidget(index: index),
      ClipRRect(borderRadius: BorderRadius.circular(120),
          child: CustomImage(width: Dimensions.profileWebImageSize,
              height: Dimensions.profileWebImageSize, image: staffItem?.image)),

      Expanded(child :CustomItemTextWidget(text:"${staffItem?.name}")),
      Expanded(child: CustomItemTextWidget(text:staffItem?.phone??'')),
      Expanded(child: CustomItemTextWidget(text:staffItem?.email??'')),
      Expanded(child: CustomItemTextWidget(text:staffItem?.designation??'')),
      if(duePayment) dueWidget(context),
    ]) :
    CustomContainer(borderRadius: 6,
        child: Row(spacing: Dimensions.paddingSizeSmall, crossAxisAlignment: CrossAxisAlignment.start, children: [
        ClipRRect(borderRadius: BorderRadius.circular(120),
            child: const CustomImage(width: Dimensions.imageSizeBig, height: Dimensions.imageSizeBig, image: "")),

        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          CustomItemTextWidget(text:"${staffItem?.name}, ${staffItem?.designation??''}"),
          CustomItemTextWidget(text:"${"phone".tr} : ${staffItem?.phone??''}"),


        ]),
        ),
          if(duePayment) dueWidget(context),
      ],
    ));
  }
  Widget dueWidget(BuildContext context) {
    return CustomContainer(showShadow: false, border: Border.all(color: Theme.of(context).primaryColor),
        verticalPadding: 0, horizontalPadding: 5, borderRadius: 2,
        borderColor: Theme.of(context).primaryColor,
        onTap: (){
          Get.dialog( Dialog(child : Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeOverLarge),
              child: DuePaymentWidget(userId: staffItem!.id.toString()))));
        }, child: Center(child: Text("due".tr,
            style: textSemiBold.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).primaryColor))));
  }
}