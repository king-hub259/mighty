import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_contaner.dart';
import 'package:mighty_school/feature/payroll_management/salary/domain/models/salary_model.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';

class SalaryItemWidget extends StatelessWidget {
  final int index;
  final SalaryItem? salaryItem;

  const SalaryItemWidget({
    super.key,
    required this.index,
    this.salaryItem,
  });

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      
      child: Padding(
        padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${salaryItem?.employee?.firstName ?? ''} ${salaryItem?.employee?.lastName ?? ''}",
                        style: textMedium.copyWith(
                          fontSize: Dimensions.fontSizeLarge,
                        ),
                      ),
                      const SizedBox(height: Dimensions.paddingSizeExtraSmall),
                      Text(
                        "${salaryItem?.month ?? ''} ${salaryItem?.year ?? ''}",
                        style: textRegular.copyWith(
                          fontSize: Dimensions.fontSizeDefault,
                          color: Theme.of(context).hintColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "net_salary".tr,
                      style: textRegular.copyWith(
                        fontSize: Dimensions.fontSizeSmall,
                        color: Theme.of(context).hintColor,
                      ),
                    ),
                    Text(
                      salaryItem?.netSalary ?? '0',
                      style: textMedium.copyWith(
                        fontSize: Dimensions.fontSizeLarge,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: Dimensions.paddingSizeSmall),
            Row(
              children: [
                Expanded(
                  child: _buildSalaryInfo(
                    context,
                    "basic_salary".tr,
                    "\$${salaryItem?.basicSalary ?? '0'}",
                    Colors.blue,
                  ),
                ),
                Expanded(
                  child: _buildSalaryInfo(
                    context,
                    "total_earning".tr,
                    "\$${salaryItem?.totalEarning ?? '0'}",
                    Colors.green,
                  ),
                ),
                Expanded(
                  child: _buildSalaryInfo(
                    context,
                    "total_deduction".tr,
                    "\$${salaryItem?.totalDeduction ?? '0'}",
                    Colors.red,
                  ),
                ),
              ],
            ),
            const SizedBox(height: Dimensions.paddingSizeSmall),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Dimensions.paddingSizeSmall,
                    vertical: Dimensions.paddingSizeExtraSmall,
                  ),
                  decoration: BoxDecoration(
                    color: _getStatusColor(salaryItem?.status).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                  ),
                  child: Text(
                    salaryItem?.status?.tr ?? '',
                    style: textMedium.copyWith(
                      fontSize: Dimensions.fontSizeSmall,
                      color: _getStatusColor(salaryItem?.status),
                    ),
                  ),
                ),
                Text(
                  "${"processed_at".tr}: ${salaryItem?.processedAt ?? 'N/A'}",
                  style: textRegular.copyWith(
                    fontSize: Dimensions.fontSizeSmall,
                    color: Theme.of(context).hintColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSalaryInfo(BuildContext context, String title, String amount, Color color) {
    return Column(
      children: [
        Text(
          title,
          style: textRegular.copyWith(
            fontSize: Dimensions.fontSizeSmall,
            color: Theme.of(context).hintColor,
          ),
        ),
        const SizedBox(height: Dimensions.paddingSizeExtraSmall),
        Text(
          amount,
          style: textMedium.copyWith(
            fontSize: Dimensions.fontSizeDefault,
            color: color,
          ),
        ),
      ],
    );
  }

  Color _getStatusColor(String? status) {
    switch (status?.toLowerCase()) {
      case 'processed':
        return Colors.green;
      case 'pending':
        return Colors.orange;
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}