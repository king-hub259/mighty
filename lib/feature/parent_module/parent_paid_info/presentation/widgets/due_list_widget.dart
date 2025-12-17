import 'package:flutter/material.dart';
import 'package:mighty_school/common/widget/custom_divider.dart';
import 'package:mighty_school/feature/parent_module/parent_paid_info/domain/model/parent_un_paid_report_model.dart';
import 'package:mighty_school/util/dimensions.dart';


class DueListWidget extends StatelessWidget {
  final List<ParentSubHeads>? subHeads;
  const DueListWidget({super.key, this.subHeads});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: subHeads?.length??0,
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index){
          return SubHeadDueItemWidget(subHeads: subHeads?[index]);
        });
  }
}

class SubHeadDueItemWidget extends StatelessWidget {
  final ParentSubHeads? subHeads;
  const SubHeadDueItemWidget({super.key, this.subHeads});

  @override
  Widget build(BuildContext context) {
    return Column(spacing: Dimensions.paddingSizeDefault, crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(spacing: Dimensions.paddingSizeDefault, crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('${subHeads?.subHeadId}', style: const TextStyle(fontSize: 16)),
          Expanded(child: Text('${subHeads?.subHeadName}', style: const TextStyle(fontSize: 16))),
          Expanded(child: Text('${subHeads?.feeAndFinePayable}', style: const TextStyle(fontSize: 16))),
        ]),
        const CustomDivider()
      ],
    );
  }
}
