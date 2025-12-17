import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_contaner.dart';
import 'package:mighty_school/feature/parent_module/parent_attendance/domain/models/attendance_fine_model.dart';
import 'package:mighty_school/feature/parent_module/parent_paid_info/presentation/widgets/parent_paid_report_item_widget.dart';
import 'package:mighty_school/util/dimensions.dart';

class AttendanceFineItemWidget extends StatelessWidget {
  final Months? fineItem;
  final int index;
  const AttendanceFineItemWidget({super.key, this.fineItem, required this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault, vertical: 5),
      child: CustomContainer(borderRadius: Dimensions.paddingSizeSmall, borderWidth: .5,
          showShadow: false, borderColor: Theme.of(context).hintColor, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            ItemInfoWithStyleWidget(title: "month".tr, value: fineItem?.monthName),
            ItemInfoWithStyleWidget(title: "total_absent".tr, value: "${fineItem?.absentCount} ${"days".tr}"),
            ItemInfoWithStyleWidget(title: "amount".tr, value: fineItem?.fineAmount),
        ])),
    );
  }
}