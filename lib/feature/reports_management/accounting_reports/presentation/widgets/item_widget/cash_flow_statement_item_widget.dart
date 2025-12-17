import 'package:flutter/material.dart';
import 'package:mighty_school/common/widget/numbering_widget.dart';
import 'package:mighty_school/feature/reports_management/accounting_reports/domain/model/cash_flow_statemrnt_report_model.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';

class CashFlowStatementItemWidget extends StatelessWidget {
  final Data item;
  final int index;
  const CashFlowStatementItemWidget({super.key, required this.item, required this.index});

  @override
  Widget build(BuildContext context) {
    return Row(spacing: Dimensions.paddingSizeDefault, children: [
      NumberingWidget(index: index),
      Expanded(child: Text(item.month ?? '', style: textRegular)),
      Expanded(child: Text(item.year?.toString() ?? '', style: textRegular)),
      Expanded(child: Text(item.totalDebit?.toString() ?? '0', style: textRegular)),
      Text(item.totalCredit?.toString() ?? '0', style: textRegular),

    ]);
  }
}
