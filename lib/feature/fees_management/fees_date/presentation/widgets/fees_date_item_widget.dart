import 'package:flutter/material.dart';
import 'package:mighty_school/common/widget/numbering_widget.dart';
import 'package:mighty_school/feature/fees_management/fees_date/domain/model/fees_date_model.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';

class FeesDateItemWidget extends StatelessWidget {
  final FeesDateItem feesDateItem;
  final int index;
  const FeesDateItemWidget({super.key, required this.feesDateItem, required this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.fromLTRB(Dimensions.paddingSizeDefault, Dimensions.paddingSizeDefault, Dimensions.paddingSizeDefault, 0),
      child: Row(spacing: Dimensions.paddingSizeDefault, crossAxisAlignment: CrossAxisAlignment.start, children: [

        NumberingWidget(index: index),
        Expanded(child: Text('${feesDateItem.feeSubHeadName}', style: textRegular.copyWith())),
        Expanded(child: Text('${feesDateItem.payableDateStart}', style: textRegular.copyWith())),
        Expanded(child: Text('${feesDateItem.payableDateEnd}', style: textRegular.copyWith())),

      ],
      ),
    );
  }
}
