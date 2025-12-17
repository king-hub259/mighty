import 'package:flutter/material.dart';
import 'package:mighty_school/common/widget/numbering_widget.dart';
import 'package:mighty_school/feature/reports_management/fees_reports/domain/model/fees_monthly_report_model.dart';
import 'package:mighty_school/helper/price_converter.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';

class FeesMonthlyReportItemWidget extends StatelessWidget {
  final MonthlyReportItem? item;
  final int index;
  const FeesMonthlyReportItemWidget({super.key, this.item, required this.index});

  @override
  Widget build(BuildContext context) {
    return Row(spacing : Dimensions.paddingSizeDefault, children: [
      NumberingWidget(index: index),
      Expanded(child: Text(item?.firstName ?? '', maxLines: 1, overflow: TextOverflow.ellipsis, style: textRegular)),
      Expanded(child: Text(item?.roll ?? '', maxLines: 1, overflow: TextOverflow.ellipsis, style: textRegular)),
      Expanded(child: Text(item?.invoiceDate ?? '', maxLines: 1, overflow: TextOverflow.ellipsis, style: textRegular)),
      Expanded(child: Text(item?.details ?? '', maxLines: 1, overflow: TextOverflow.ellipsis, style: textRegular)),
      Expanded(child: Text(PriceConverter.convertPrice(context, item?.totalAmount ?? 0), maxLines: 1, overflow: TextOverflow.ellipsis, style: textRegular)),

    ],);
  }
}
