import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_button.dart';
import 'package:mighty_school/common/widget/custom_contaner.dart';
import 'package:mighty_school/feature/payroll_management/payroll_assign/domain/model/payroll_assign_model.dart';
import 'package:mighty_school/feature/payroll_management/payroll_assign/logic/payroll_assign_controller.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';

class PayrollAssignListWidget extends StatefulWidget {
  final ScrollController scrollController;

  const PayrollAssignListWidget({
    super.key,
    required this.scrollController,
  });

  @override
  State<PayrollAssignListWidget> createState() => _PayrollAssignListWidgetState();
}

class _PayrollAssignListWidgetState extends State<PayrollAssignListWidget> {
  late ScrollController _verticalScrollController;
  late ScrollController _horizontalScrollController;

  @override
  void initState() {
    super.initState();
    _verticalScrollController = ScrollController();
    _horizontalScrollController = ScrollController();
  }

  @override
  void dispose() {
    _verticalScrollController.dispose();
    _horizontalScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = 120;
    double height = 80;
    return GetBuilder<PayrollAssignController>(
      initState: (val) => Get.find<PayrollAssignController>().getPayrollAssign(),
      builder: (payrollController) {
        PayrollAssignModel? payrollModel = payrollController.payrollAssignModel;
        List<PayrollUserItem> payrollData = payrollModel?.data ?? [];

        return payrollModel != null ? Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
          child: LayoutBuilder(builder: (context, constraints) {
              return SizedBox(height: calculateDynamicHeight(payrollData, constraints),
                child: Column(mainAxisSize: MainAxisSize.min, children: [

                    SingleChildScrollView(controller: _horizontalScrollController, scrollDirection: Axis.horizontal,
                      child: CustomContainer(height: 60,
                        child: Row(children: [
                            SizedBox(width: width, child: Center(child: Text("name".tr, style: textRegular))),
                            Container(width: 1, height: height, color: Theme.of(context).dividerColor),
                            SizedBox(width: width, child: Center(child: Text("designation".tr, style: textRegular))),
                            Container(width: 1, height: 40, color: Theme.of(context).dividerColor),

                            if (payrollData.isNotEmpty)
                              ...payrollData[0].salaryHeads?.map((head) => [
                                SizedBox(width: width, child: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                                        Text(head.name ?? "", style: textRegular, textAlign: TextAlign.center, maxLines: 1, overflow: TextOverflow.ellipsis),
                                        Text(head.type == "Addition" ? "(+)" : "(-)",
                                          style: textRegular.copyWith(color: head.type == "Addition" ? Colors.green : Colors.red)),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(width: 1, height: height, color: Theme.of(context).dividerColor),
                              ]).expand((x) => x).toList() ?? [],
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: Dimensions.paddingSizeSmall),

                    Expanded(child: Scrollbar(controller: _verticalScrollController, thumbVisibility: true,
                      child: SingleChildScrollView(controller: _verticalScrollController,
                        child: SingleChildScrollView(controller: _horizontalScrollController,
                          scrollDirection: Axis.horizontal,
                          child: IntrinsicWidth(child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                            children: payrollData.asMap().entries.map((entry) {
                              int index = entry.key;
                              PayrollUserItem user = entry.value;

                              return Column(children: [
                                SizedBox(height: 60, child: Row(children: [
                                  SizedBox(width: width, child: Padding(padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                    child: Text("${index + 1}. ${user.user?.name ?? ''}",
                                      maxLines: 2, overflow: TextOverflow.ellipsis, style: textRegular,))),
                                  Container(width: 1, height: height, color: Theme.of(context).dividerColor,),
                                  SizedBox(width: width, child: Center(
                                    child: Text(user.user?.userType ?? "", style: textRegular, textAlign: TextAlign.center))),
                                  Container(width: 1, height: height, color: Theme.of(context).dividerColor),

                                  /// Editable Salary Heads
                                  if (user.salaryHeadUserPayrolls != null)
                                    ...user.salaryHeadUserPayrolls!.map((head) => [
                                      SizedBox(width: width,
                                        child: Padding(padding: const EdgeInsets.all(4.0),
                                          child: TextField(controller: payrollController.textControllers[user.user?.id ?? 0]?[head.salaryHeadId ?? 0],
                                            keyboardType: TextInputType.number,
                                            decoration: const InputDecoration(
                                              border: OutlineInputBorder(),
                                              isDense: true,
                                              contentPadding: EdgeInsets.symmetric(
                                                  horizontal: 8, vertical: 8)),
                                            onChanged: (val) {
                                            payrollController.updateAmount(user.user?.id ?? 0, head.salaryHeadId ?? 0, val);
                                            },
                                          ))),
                                      Container(width: 1, height: height, color: Theme.of(context).dividerColor),
                                    ]).expand((x) => x)])),
                                if (index < payrollData.length - 1)
                                  Container(height: 1, color: Theme.of(context).dividerColor,
                                    margin: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeExtraSmall)),
                              ]);
                            }).toList(),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: Dimensions.paddingSizeDefault),

                  Align(alignment: Alignment.centerRight, child: SizedBox(width: 200,
                    child: CustomButton(onTap: () => payrollController.createPayrollAssign(),
                        text: "update".tr))),
                  ],
                ),
              );
            },
          ),
        ) : Center(child: Padding(padding: ThemeShadow.getPadding(),
            child: const CircularProgressIndicator()),
        );
      },
    );
  }

  /// Calculate dynamic height based on content and screen constraints
  double calculateDynamicHeight(List<PayrollUserItem> payrollData, BoxConstraints constraints) {
    const double headerHeight = 60.0;
    const double rowHeight = 60.0;
    const double buttonHeight = 40.0;
    const double padding = Dimensions.paddingSizeDefault * 3;
    const double dividerHeight = 1.0;
    double contentHeight = headerHeight + buttonHeight + padding;
    contentHeight += (payrollData.length * rowHeight);
    contentHeight += ((payrollData.length - 1) * dividerHeight);
    double availableHeight = constraints.maxHeight;
    double dynamicHeight = contentHeight.clamp(300.0, availableHeight * 0.8);
    return dynamicHeight;
  }
}
