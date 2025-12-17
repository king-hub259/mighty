import 'package:flutter/material.dart';
import 'package:mighty_school/common/widget/custom_contaner.dart';
import 'package:mighty_school/common/widget/custom_divider.dart';
import 'package:mighty_school/common/widget/edit_delete_section.dart';
import 'package:mighty_school/common/widget/numbering_widget.dart';
import 'package:mighty_school/feature/fees_management/fees_date/domain/model/fees_date_model.dart';
import 'package:mighty_school/helper/responsive_helper.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';

class FeesDateCardWidget extends StatelessWidget {
  final FeesDateItem? feesDateItem;
  final int index;
  const FeesDateCardWidget({super.key, this.feesDateItem, required this.index});

  @override
  Widget build(BuildContext context) {
    return ResponsiveHelper.isDesktop(context)?
    Row(spacing: Dimensions.paddingSizeDefault, children: [
      NumberingWidget(index: index),
      Expanded(child: Text(feesDateItem?.feeSubHeadName??'', style: textRegular.copyWith(fontSize: Dimensions.fontSizeDefault),)),
      Expanded(child: Text("${feesDateItem?.payableDateEnd}", style: textRegular.copyWith(fontSize: Dimensions.fontSizeDefault),)),
      Expanded(child: Text("${feesDateItem?.payableDateStart}", style: textRegular.copyWith(fontSize: Dimensions.fontSizeDefault),)),
      EditDeleteSection(horizontal: true, onEdit: (){},onDelete: (){},)
    ],):

    Padding(padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: CustomContainer(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(feesDateItem?.feeSubHeadName??'', style: textRegular.copyWith(fontSize: Dimensions.fontSizeDefault),),
                Row(children: [
                  Expanded(child: Text("${feesDateItem?.payableDateEnd}", style: textRegular.copyWith(fontSize: Dimensions.fontSizeDefault),)),
                  const SizedBox(width: Dimensions.paddingSizeSmall),
                  Expanded(child: Text("${feesDateItem?.payableDateStart}", style: textRegular.copyWith(fontSize: Dimensions.fontSizeDefault),)),
                ],)
              ],
            )),
            EditDeleteSection(onDelete: (){},onEdit: (){},)
          ],
        ),

      ],),),
    );
  }
}
