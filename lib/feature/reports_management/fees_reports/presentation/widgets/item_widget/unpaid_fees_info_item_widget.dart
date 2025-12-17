import 'package:flutter/material.dart';
import 'package:mighty_school/common/widget/numbering_widget.dart';
import 'package:mighty_school/feature/reports_management/fees_reports/domain/model/fees_payment_info_model.dart';
import 'package:mighty_school/helper/price_converter.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';

class UnpaidFeesInfoItemWidget extends StatelessWidget {
  final FeesPaymentInfoItem? item;
  final int index;
  const UnpaidFeesInfoItemWidget({super.key, this.item, required this.index});

  @override
  Widget build(BuildContext context) {
    return Row(spacing: Dimensions.paddingSizeDefault, children: [
      NumberingWidget(index: index),
      Expanded(child: Text("${item?.student?.firstName ?? ''} ${item?.student?.lastName ?? ''}", maxLines: 1, overflow: TextOverflow.ellipsis, style: textRegular)),
      Expanded(child: Text(item?.invoiceId ?? '', maxLines: 1, overflow: TextOverflow.ellipsis, style: textRegular)),
      Expanded(child: Text(PriceConverter.convertPrice(context, double.tryParse(item?.totalPayable ?? '0') ?? 0), maxLines: 1, overflow: TextOverflow.ellipsis, style: textRegular)),
      Expanded(child: Text(PriceConverter.convertPrice(context, double.tryParse(item?.totalPaid ?? '0') ?? 0), maxLines: 1, overflow: TextOverflow.ellipsis, style: textRegular)),
      Expanded(child: Text(PriceConverter.convertPrice(context, double.tryParse(item?.totalDue ?? '0') ?? 0), maxLines: 1, overflow: TextOverflow.ellipsis, style: textRegular)),

    ]);
  }
}
