import 'package:flutter/material.dart';
import 'package:mighty_school/common/widget/numbering_widget.dart';
import 'package:mighty_school/feature/fees_management/fees_amount_config/domain/model/fees_model.dart';
import 'package:mighty_school/helper/price_converter.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';

class FeesItemWidget extends StatelessWidget {
  final FeesItem feesItem;
  final int index;
  const FeesItemWidget({super.key, required this.feesItem, required this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.fromLTRB(Dimensions.paddingSizeDefault, Dimensions.paddingSizeDefault, Dimensions.paddingSizeDefault, 0),
      child: Row(spacing: Dimensions.paddingSizeDefault, crossAxisAlignment: CrossAxisAlignment.start, children: [

        NumberingWidget(index: index),
        Expanded(child: Text('${feesItem.feeHead?.name}', style: textRegular.copyWith())),
        Expanded(child: Text('${feesItem.section?.sectionName}', style: textRegular.copyWith())),
        Expanded(child: Text('${feesItem.group?.groupName}', style: textRegular.copyWith())),
        Expanded(child: Text(PriceConverter.convertPrice(context, feesItem.feeAmount ?? 0), style: textRegular.copyWith())),

      ],
      ),
    );
  }
}
