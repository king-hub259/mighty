import 'package:flutter/material.dart';
import 'package:mighty_school/common/widget/numbering_widget.dart';
import 'package:mighty_school/helper/price_converter.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';

class FeesPaymentRatioItemWidget extends StatelessWidget {
  final dynamic item;
  final int index;
  const FeesPaymentRatioItemWidget({super.key, this.item, required this.index});

  @override
  Widget build(BuildContext context) {
    return Row(spacing: Dimensions.paddingSizeDefault, children: [
      NumberingWidget(index: index),
      Expanded(child: Text(item?['category'] ?? '', maxLines: 1, overflow: TextOverflow.ellipsis, style: textRegular)),
      Expanded(child: Text(PriceConverter.convertPrice(context, double.tryParse(item?['total_amount']?.toString() ?? '0') ?? 0), maxLines: 1, overflow: TextOverflow.ellipsis, style: textRegular)),
      Expanded(child: Text(PriceConverter.convertPrice(context, double.tryParse(item?['paid_amount']?.toString() ?? '0') ?? 0), maxLines: 1, overflow: TextOverflow.ellipsis, style: textRegular)),
      Expanded(child: Text("${item?['ratio']?.toString() ?? '0'}%", maxLines: 1, overflow: TextOverflow.ellipsis, style: textRegular)),

    ]);
  }
}
