import 'package:flutter/material.dart';
import 'package:mighty_school/common/widget/numbering_widget.dart';
import 'package:mighty_school/feature/account_management/chart_of_account/domain/model/char_of_account_model.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';

class ChartOfAccountItemWidget extends StatelessWidget {
  final ChartOfAccountItem? chartOfAccountItem;
  final int index;
  const ChartOfAccountItemWidget({super.key, this.chartOfAccountItem, required this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.fromLTRB(Dimensions.paddingSizeDefault, Dimensions.paddingSizeDefault, Dimensions.paddingSizeDefault, 0),
      child: Row(spacing: Dimensions.paddingSizeDefault, crossAxisAlignment: CrossAxisAlignment.start, children: [

        NumberingWidget(index: index),
        Expanded(child: Text('${chartOfAccountItem?.name}', style: textRegular.copyWith())),
        Expanded(child: Text('${chartOfAccountItem?.type}', style: textRegular.copyWith())),
        Expanded(flex: 2, child: SizedBox(height: 40,
          child: ListView.builder(shrinkWrap: true, scrollDirection: Axis.horizontal,
            physics: const NeverScrollableScrollPhysics(), padding: EdgeInsets.zero,
            itemCount: chartOfAccountItem?.accountingGroups?.length?? 0,
            itemBuilder: (context, index){
              return Text("${chartOfAccountItem?.accountingGroups?[index].name??''}, ");
            }),
        )),
      ],
      ),
    );
  }
}
