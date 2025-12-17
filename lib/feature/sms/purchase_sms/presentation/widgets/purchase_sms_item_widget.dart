import 'package:flutter/material.dart';
import 'package:mighty_school/common/widget/custom_contaner.dart';
import 'package:mighty_school/common/widget/edit_delete_section.dart';
import 'package:mighty_school/feature/sms/purchase_sms/domain/models/purchase_sms_model.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';

class PurchaseSmsItemWidget extends StatelessWidget {
  final PurchaseSmsItem? purchaseSmsItem;
  final int index;
  const PurchaseSmsItemWidget({super.key, this.purchaseSmsItem, required this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault, vertical: Dimensions.paddingSizeSeven),
      child: CustomContainer(borderRadius: Dimensions.paddingSizeExtraSmall, child: Row(children: [
          Expanded(child: Column(
            children: [
              Text("${purchaseSmsItem?.noOfSms}", style: textMedium.copyWith(fontSize: Dimensions.fontSizeDefault)),
              Text("${purchaseSmsItem?.noOfSms}", style: textMedium.copyWith(fontSize: Dimensions.fontSizeDefault)),
              Text("${purchaseSmsItem?.noOfSms}", style: textMedium.copyWith(fontSize: Dimensions.fontSizeDefault)),
              Text("${purchaseSmsItem?.noOfSms}", style: textMedium.copyWith(fontSize: Dimensions.fontSizeDefault)),
              Text("${purchaseSmsItem?.noOfSms}", style: textMedium.copyWith(fontSize: Dimensions.fontSizeDefault)),
            ],
          )),
          EditDeleteSection(horizontal: true, onEdit: (){

          },
            onDelete: (){

          },)
        ],
      )),
    );
  }
}