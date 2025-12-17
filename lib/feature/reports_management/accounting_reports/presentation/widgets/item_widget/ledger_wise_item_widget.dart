import 'package:flutter/material.dart';
import 'package:mighty_school/common/widget/numbering_widget.dart';
import 'package:mighty_school/feature/reports_management/accounting_reports/domain/model/ledger_wise_report_model.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';

class LedgerWiseItemWidget extends StatelessWidget {
  final Data item;
  final int index;
  const LedgerWiseItemWidget({super.key, required this.item, required this.index});

  @override
  Widget build(BuildContext context) {
    return Row(spacing: Dimensions.paddingSizeDefault, children: [
      NumberingWidget(index: index),
      Expanded(child: Text(item.transactionDate ?? '', style: textRegular)),
      Expanded(child: Text(item.reference ?? '', style: textRegular)),
      Expanded(child: Text(item.ledgerName ?? '', style: textRegular)),
      Expanded(child: Text(item.debit ?? '', style: textRegular)),
      Text(item.credit ?? '', style: textRegular),

    ]);
  }
}
