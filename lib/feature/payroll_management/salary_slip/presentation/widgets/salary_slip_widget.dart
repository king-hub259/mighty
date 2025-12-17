import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_button.dart';
import 'package:mighty_school/common/widget/custom_contaner.dart';
import 'package:mighty_school/common/widget/custom_snackbar.dart';
import 'package:mighty_school/common/widget/no_data_found.dart';
import 'package:mighty_school/feature/payroll_management/salary_slip/domain/model/salary_slip_body.dart';
import 'package:mighty_school/feature/payroll_management/salary_slip/domain/model/salary_slip_model.dart' hide SalaryHeads;
import 'package:mighty_school/feature/payroll_management/salary_slip/logic/salary_slip_controller.dart';
import 'package:mighty_school/feature/payroll_management/salary_slip/presentation/widgets/salary_slip_item_title_widget.dart';
import 'package:mighty_school/feature/payroll_management/salary_slip/presentation/widgets/salary_slip_value_item_widget.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';

class SalarySlipListWidget extends StatefulWidget {
  final ScrollController scrollController;

  const SalarySlipListWidget({
    super.key,
    required this.scrollController,
  });

  @override
  State<SalarySlipListWidget> createState() => _SalarySlipListWidgetState();
}

class _SalarySlipListWidgetState extends State<SalarySlipListWidget> {
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
    return GetBuilder<SalarySlipController>(builder: (salarySlipController) {
        SalarySlipModel? salarySlipModel = salarySlipController.salarySlipModel;
        List<SalarySlips> salarySlipData = salarySlipModel?.data?.salarySlips ?? [];

        if (salarySlipData.isEmpty) {
          return const Center(child: NoDataFound());
        }

        return salarySlipModel != null ? Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
          child: LayoutBuilder(builder: (context, constraints) {
              return SizedBox(height: _calculateDynamicHeight(salarySlipData, constraints),
                child: Column(mainAxisSize: MainAxisSize.min, children: [

                  SingleChildScrollView(controller: _horizontalScrollController, scrollDirection: Axis.horizontal,
                      child: CustomContainer(height: 60,
                        child: Row(children: [

                          SizedBox(width : 20, height: 20,
                            child: Checkbox(value: salarySlipController.allSelected,
                                onChanged: (val){
                                  salarySlipController.toggleAllSelection();
                            }),
                          ),
                            SizedBox(width: width, child: Center(child: Text("name".tr, style: textRegular.copyWith(fontWeight: FontWeight.w600)))),
                            Container(width: 1, height: height, color: Theme.of(context).dividerColor),
                            SizedBox(width: width, child: Center(child: Text("designation".tr, style: textRegular.copyWith(fontWeight: FontWeight.w600)))),
                          const CustomBorder(),

                            if (salarySlipData.isNotEmpty && salarySlipData[0].salaryHeads != null)
                              ...salarySlipData[0].salaryHeads!.map((head) => [
                                SalarySlipItemTitleWidget(width: width, head: head),
                                const CustomBorder(),
                              ]).expand((x) => x),
                            // Net Salary column
                            SizedBox(width: width, child: Center(
                                child: Text("net_salary".tr, style: textRegular.copyWith(color: Theme.of(context).primaryColor), textAlign: TextAlign.center))),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: Dimensions.paddingSizeSmall),

                    Expanded(child: Scrollbar(controller: _verticalScrollController, thumbVisibility: true,
                        child: SingleChildScrollView(controller: _verticalScrollController,
                          child: SingleChildScrollView(controller: _horizontalScrollController, scrollDirection: Axis.horizontal,
                            child: IntrinsicWidth(child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                              children: salarySlipData.asMap().entries.map((entry) {
                                int index = entry.key;
                                SalarySlips user = entry.value;
                                return SalarySlipValueItemWidget(
                                  index: index,
                                  user: user,
                                  salarySlipData: salarySlipData,
                                  width: width,
                                  height: height,
                                );
                                }).toList(),
                              ),
                            ),
                          ),
                        ),
                      )),
                    const SizedBox(height: Dimensions.paddingSizeDefault),
                  Align(alignment: Alignment.centerRight,
                      child: SizedBox(width: 150,  child: salarySlipController.isLoading?
                      const Center(child: CircularProgressIndicator()):
                      CustomButton(onTap: (){

                        List<SalarySlips> selectedSlips = salarySlipData.where((slip) => slip.isSelected).toList();

                        if (selectedSlips.isEmpty) {
                          showCustomSnackBar("please_select_at_least_one_employee".tr, isError: true);
                          return;
                        }

                        // Prepare users list from selected items
                        List<Users> users = selectedSlips.map((slip) {
                          // Convert salary head user payrolls to salary heads for the body
                          List<SalaryHeads> salaryHeads = [];
                          if (slip.salaryHeadUserPayrolls != null) {
                            salaryHeads = slip.salaryHeadUserPayrolls!.map((payroll) {
                              return SalaryHeads(
                                salaryHeadId: payroll.salaryHeadId,
                                amount: payroll.amount,
                              );
                            }).toList();
                          }

                          return Users(
                            userId: slip.user?.id,
                            salaryHeads: salaryHeads,
                          );
                        }).toList();

                        SalarySlipBody body = SalarySlipBody(
                          year: int.tryParse(salarySlipController.selectedYear??"1"),
                          month: int.tryParse(salarySlipController.selectedMonthValue ?? '1'),
                          users: users,
                        );

                        salarySlipController.createSalarySlip(body);
                  }, text: "create".tr)))
                  ],
                ),
              );
            },
          ),
        ) : Center(child: Padding(padding: ThemeShadow.getPadding(),
              child: const CircularProgressIndicator()));
      },
    );
  }



  /// Calculate dynamic height based on content and screen constraints
  double _calculateDynamicHeight(List<SalarySlips> salarySlipData, BoxConstraints constraints) {
    const double headerHeight = 60.0;
    const double rowHeight = 60.0;
    const double padding = Dimensions.paddingSizeDefault * 2;
    const double dividerHeight = 1.0;
    const double spacing = Dimensions.paddingSizeSmall;

    // Calculate minimum content height
    double contentHeight = headerHeight + padding + spacing;
    contentHeight += (salarySlipData.length * rowHeight);
    contentHeight += ((salarySlipData.length - 1) * dividerHeight); // Dividers between rows

    // Use available height but ensure minimum and maximum bounds
    double availableHeight = constraints.maxHeight;
    double dynamicHeight = contentHeight.clamp(
      300.0, // Minimum height
      availableHeight * 0.8, // Maximum 80% of available height
    );

    return dynamicHeight;
  }
}
class CustomBorder extends StatelessWidget {
  const CustomBorder({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(width: 1, height: 80, color: Theme.of(context).dividerColor);
  }
}
